import time
import pyautogui
import pywinauto


def verify_exists_update():
    """Verifica se existe uma janela de atualização e, se existir, ativa a janela e pressiona as teclas "right" e "enter"."""
    while True:
        try:
            windows_list_activeted = pywinauto.Desktop(backend="uia").windows()
            for window in windows_list_activeted:
                if "atualização FJFrigo" in window.window_text():
                    window.set_focus()
                    time.sleep(0.5)
                    pyautogui.press("right")
                    pyautogui.press("enter")
        except Exception as e:
            print(f"Erro ao verificar a janela de atualização: {e}")
            continue
        finally:
            time.sleep(10)

if __name__ == "__main__":
    verify_exists_update()