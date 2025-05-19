import datetime
import os
import sys
import pyautogui
from pywinauto import Desktop
import time


def press_keys(key1, key2):
    pyautogui.hotkey(key1, key2)


def alt_f4():
    pyautogui.hotkey("alt", "f4")


def get_current_datetime():
    return datetime.datetime.now().strftime("%d_%m_%Y %H_%M_%S")

def write_text(text):
    pyautogui.write(text, interval=0.1)


def switch_to_fj_frigo():
    """Tenta encontrar uma janela cujo título contenha 'FJ Frigo' e traz o foco para ela."""
    while True:
        windows = Desktop(backend="uia").windows()
        for win in windows:
            if "atualização" in win.window_text():
                win.set_focus()
                time.sleep(0.5)
                pyautogui.press("right")
                pyautogui.press("enter")
                continue
            if (
                "FJFrigo" in win.window_text()
                and not "atualização" in win.window_text()
            ):
                win.set_focus()
                return True
        break
    return False

def copy_file_cliente_base():
    print(">>> Copiando arquivo cliente_base.xlsx\
          >>> De: C:\\Users\\use\\Documents\\" \
          ">>> Para: C:\\Users\\use\\Desktop\\BMG-Creditos-Bordero\\data\\")
    os.remove('C:\\Users\\use\\Desktop\\BMG-Creditos-Bordero\\data\\cliente_base.xlsx')
    os.rename(
        "C:\\Users\\use\\Documents\\cliente_base.xlsx",
        "C:\\Users\\use\\Desktop\\BMG-Creditos-Bordero\\data\\cliente_base.xlsx",
    )
    print(">>> Arquivo cliente_base copiado com sucesso para pasta data.")

def kill_process():
    try:
        os.system('taskkill /F /IM fjfrigo.exe')
        os.system('taskkill /F /IM EXCEL.EXE')
        os.system('taskkill /F /IM FJUpdaterLocal.exe')
        return True
    except Exception as e:
        print(f"Erro ao matar o processo: {e}")
        return False