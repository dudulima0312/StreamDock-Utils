import json
import time
import threading
from src.core.action import Action
from src.core.logger import Logger

# Importar bibliotecas necessárias para simulação de teclado
try:
    import pyautogui
    pyautogui.FAILSAFE = False  # Desabilitar failsafe para evitar problemas
except ImportError:
    Logger.error("pyautogui not installed. Please install it using: pip install pyautogui")
    pyautogui = None

try:
    from pynput import keyboard
    from pynput.keyboard import Key, Controller
    keyboard_controller = Controller()
except ImportError:
    Logger.error("pynput not installed. Please install it using: pip install pynput")
    keyboard = None
    keyboard_controller = None


class WindowCycle(Action):
    def __init__(self, action: str, context: str, settings: dict, plugin):
        super().__init__(action, context, settings, plugin)

        # Estado do Task View
        self.task_view_active = False
        self.alt_pressed = False
        self.last_rotation_time = 0
        self.rotation_timeout = None

        # Configurações
        self.rotation_sensitivity = settings.get('rotationSensitivity', 1)  # Quantos ticks por Tab
        self.auto_release_delay = settings.get('autoReleaseDelay', 1.5)  # Segundos para liberar Alt
        self.reverse_direction = settings.get('reverseDirection', False)
        self.enable_knob_press = settings.get('enableKnobPress', True)

        # Contador de rotação
        self.rotation_accumulator = 0

        # Atualizar display inicial
        self.update_button_display()

        Logger.info(f"[WindowCycle] Initialized with context {context}")

    def update_button_display(self):
        """Atualiza o display do botão"""
        try:
            if self.task_view_active:
                self.set_title("Task View")
                self.set_state(1)  # Estado ativo
            else:
                self.set_title("Window Cycle")
                self.set_state(0)  # Estado normal

        except Exception as e:
            Logger.error(f"[WindowCycle] Error updating display: {e}")

    def open_task_view(self):
        """Abre o Task View (Alt+Tab)"""
        if not keyboard_controller:
            Logger.error("[WindowCycle] Keyboard controller not available")
            self.show_alert()
            return

        try:
            if not self.task_view_active:
                Logger.info("[WindowCycle] Opening Task View")

                # Pressionar Alt+Tab para abrir o Task View
                keyboard_controller.press(Key.alt)
                keyboard_controller.press(Key.tab)
                keyboard_controller.release(Key.tab)

                # Manter Alt pressionado
                self.alt_pressed = True
                self.task_view_active = True

                # Atualizar display
                self.update_button_display()

                # Iniciar timer para auto-release
                self.reset_release_timer()

        except Exception as e:
            Logger.error(f"[WindowCycle] Error opening Task View: {e}")
            self.show_alert()

    def navigate_task_view(self, direction='forward'):
        """Navega pelo Task View"""
        if not self.task_view_active or not keyboard_controller:
            return

        try:
            Logger.info(f"[WindowCycle] Navigating Task View - Direction: {direction}")

            if direction == 'forward':
                # Pressionar Tab (com Alt ainda pressionado)
                keyboard_controller.press(Key.tab)
                keyboard_controller.release(Key.tab)
            else:
                # Pressionar Shift+Tab para voltar
                keyboard_controller.press(Key.shift)
                keyboard_controller.press(Key.tab)
                keyboard_controller.release(Key.tab)
                keyboard_controller.release(Key.shift)

            # Resetar timer de auto-release
            self.reset_release_timer()

        except Exception as e:
            Logger.error(f"[WindowCycle] Error navigating Task View: {e}")

    def close_task_view(self):
        """Fecha o Task View liberando Alt"""
        if not self.task_view_active or not keyboard_controller:
            return

        try:
            Logger.info("[WindowCycle] Closing Task View")

            # Liberar Alt para selecionar a janela atual
            if self.alt_pressed:
                keyboard_controller.release(Key.alt)
                self.alt_pressed = False

            self.task_view_active = False

            # Cancelar timer se existir
            if self.rotation_timeout:
                self.rotation_timeout.cancel()
                self.rotation_timeout = None

            # Atualizar display
            self.update_button_display()

            # Feedback visual
            self.show_ok()

        except Exception as e:
            Logger.error(f"[WindowCycle] Error closing Task View: {e}")

    def reset_release_timer(self):
        """Reseta o timer para liberar Alt automaticamente"""
        # Cancelar timer anterior se existir
        if self.rotation_timeout:
            self.rotation_timeout.cancel()

        # Criar novo timer
        self.rotation_timeout = threading.Timer(
            self.auto_release_delay,
            self.auto_release_alt
        )
        self.rotation_timeout.start()

    def auto_release_alt(self):
        """Libera Alt automaticamente após timeout"""
        Logger.info("[WindowCycle] Auto-releasing Alt due to timeout")
        self.close_task_view()

    def on_dial_rotate(self, payload: dict):
        """Handle dial rotation - navega pelo Task View"""
        ticks = payload.get('ticks', 0)
        pressed = payload.get('pressed', False)

        Logger.info(f"[WindowCycle] Dial rotated - Ticks: {ticks}, Pressed: {pressed}")

        # Se não está no Task View, abrir
        if not self.task_view_active:
            self.open_task_view()
            time.sleep(0.1)  # Pequeno delay para garantir que o Task View abriu

        # Acumular rotações para sensibilidade
        self.rotation_accumulator += ticks

        # Determinar direção baseada na configuração
        if self.reverse_direction:
            ticks = -ticks

        # Navegar baseado na sensibilidade
        while abs(self.rotation_accumulator) >= self.rotation_sensitivity:
            if self.rotation_accumulator > 0:
                self.navigate_task_view('forward')
                self.rotation_accumulator -= self.rotation_sensitivity
            else:
                self.navigate_task_view('backward')
                self.rotation_accumulator += self.rotation_sensitivity

            # Pequeno delay entre navegações para evitar movimentos muito rápidos
            time.sleep(0.05)

    def on_dial_press(self, payload: dict):
        """Handle dial press - confirma seleção ou abre Task View"""
        pressed = payload.get('pressed', False)

        Logger.info(f"[WindowCycle] Dial pressed - Pressed: {pressed}")

        if not self.enable_knob_press:
            return

        if pressed:
            # Se Task View está aberto, fechar (selecionar janela)
            if self.task_view_active:
                self.close_task_view()
            else:
                # Se está fechado, abrir
                self.open_task_view()

    def on_dial_down(self, payload: dict):
        """Quando o dial é pressionado para baixo"""
        self.on_dial_press({'pressed': True})

    def on_dial_up(self, payload: dict):
        """Quando o dial é liberado"""
        # Se estiver com Task View aberto, pode fechar
        if self.task_view_active and self.enable_knob_press:
            self.close_task_view()

    def on_key_down(self, payload: dict):
        """Handle key press - abre Task View ou navega"""
        Logger.info(f"[WindowCycle] Key down event")

        # Verificar se é parte de multi-action
        if payload.get('isInMultiAction', False):
            # Em multi-action, apenas abrir/fechar Task View
            if self.task_view_active:
                self.close_task_view()
            else:
                self.open_task_view()
        else:
            # Botão normal - alternar ou navegar
            if not self.task_view_active:
                self.open_task_view()
            else:
                self.navigate_task_view('forward')

    def on_key_up(self, payload: dict):
        """Handle key release"""
        Logger.info(f"[WindowCycle] Key up event")
        # Não fechar automaticamente no key up para permitir múltiplos cliques

    def on_will_disappear(self):
        """Clean up quando a ação é removida"""
        # Garantir que Alt seja liberado se ainda estiver pressionado
        if self.task_view_active:
            self.close_task_view()

        # Cancelar timers
        if self.rotation_timeout:
            self.rotation_timeout.cancel()

        Logger.info(f"[WindowCycle] Will disappear for context {self.context}")

    def on_did_receive_settings(self, settings: dict):
        """Handle settings update from Property Inspector"""
        self.rotation_sensitivity = settings.get('rotationSensitivity', 1)
        self.auto_release_delay = settings.get('autoReleaseDelay', 1.5)
        self.reverse_direction = settings.get('reverseDirection', False)
        self.enable_knob_press = settings.get('enableKnobPress', True)

        Logger.info(f"[WindowCycle] Settings updated: {settings}")

        # Atualizar display
        self.update_button_display()

    def on_property_inspector_did_appear(self):
        """Send current settings to Property Inspector"""
        self.send_to_property_inspector({
            'rotationSensitivity': self.rotation_sensitivity,
            'autoReleaseDelay': self.auto_release_delay,
            'reverseDirection': self.reverse_direction,
            'enableKnobPress': self.enable_knob_press,
            'taskViewActive': self.task_view_active
        })