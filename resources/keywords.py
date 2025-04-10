import datetime
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
            if "FJFrigo" in win.window_text():
                win.set_focus()
                return True
        time.sleep(3)
    return False
