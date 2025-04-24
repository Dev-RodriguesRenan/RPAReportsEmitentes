import time
import pyautogui
import pywinauto


def verify_exists_update():
    """Verifica se existe uma janela de atualização e, se existir, ativa a janela e pressiona as teclas "right" e "enter"."""
    while True:
        try:
            windows_list = pywinauto.Desktop(backend="uia").windows()
            is_fjfrigo_open = False
            update_window = None
            for window in windows_list:
                text = window.window_text()
                if "FJFrigo" in text and "atualização" not in text:
                    is_fjfrigo_open = True
                if "atualização FJFrigo" in text:
                    update_window = window
                # Se não houver janela FJFrigo ativa (sem atualização) e existir a janela de atualização, atualiza
                if update_window and not is_fjfrigo_open:
                    update_window.set_focus()
                    time.sleep(0.5)
                    pyautogui.press("right")
                    pyautogui.press("enter")
        except Exception as e:
            print(f"Erro ao verificar a janela de atualização: {e}")
            continue
        finally:
            time.sleep(2.5)

if __name__ == "__main__":
    verify_exists_update()