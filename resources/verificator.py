import os
import time
import pyautogui
import pywinauto


def verify_exists_update():
    """Verifica se existe uma janela de atualização e, se existir e NÃO houver a janela 'Controle administrativo',
    ativa a janela e pressiona a tecla "enter"."""
    while True:
        print(">>> Verificando se existe janela de atualização", end="\r")
        windows_list_activated = pywinauto.Desktop(backend="uia").windows()
        # Verifica se existe any janela com "Controle administrativo"
        has_controle_admin = any(
            "Controle administrativo" or 'Login de usuário' in window.window_text()
            for window in windows_list_activated
        )

        # Se não existir janela de Controle administrativo, 
        # procura janela de atualização
        if not has_controle_admin:
            print('>>> Não existe janela de Controle administrativo ' \
            'ou Login de usuário',end="\r")
            for window in windows_list_activated:
                if "atualização" in window.window_text():
                    print('>>> Janela de atualização encontrada')
                    window.set_focus()
                    time.sleep(2)
                    pyautogui.press("enter")
                    print(
                        ">>> Tecla 'enter' pressionada para atualizar o sistema"
                    )
        else:
            for window in windows_list_activated:
                if "atualização" in window.window_text():
                    print('>>> Janela de atualização encontrada')
                    os.system('taskkill /F /IM FJUpdaterLocal.exe')
                    print(
                        ">>> Janela de atualização ignorada, " \
                        "pois existe janela de Controle administrativo " \
                        "ou Login do usuário"
                    )
        time.sleep(1)


if __name__ == "__main__":
    verify_exists_update()