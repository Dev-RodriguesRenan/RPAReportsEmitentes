import datetime
import subprocess
import pyautogui


def press_keys(key1, key2):
    pyautogui.hotkey(key1, key2)


def alt_f4():
    pyautogui.hotkey("alt", "f4")


def get_current_datetime():
    return datetime.datetime.now().strftime("%d_%m_%Y %H_%M_%S")


def write_text(text):
    pyautogui.write(text, interval=0.1)
