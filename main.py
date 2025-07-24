import os
import subprocess
import sys

import schedule

from resources.logger import LOGGER_HANDLER

BASE_PATH = "C:\\Users\\use\\Desktop\\vjbots-robot-fjfrigo\\"
PYTHON_PATH_VENV = os.path.join(BASE_PATH, "venv\\Scripts\\python.exe")
MAIN_SCRIPT_PATH = os.path.join(BASE_PATH, "main.robot")
UPDATER_PATH = os.path.join(BASE_PATH, "resources\\updater.robot")
VERIFICATOR_PATH = os.path.join(BASE_PATH, "resources\\verificator.py")


def run_robot_file(file_path):
    """Executa o arquivos robot.

    Args:
        file_path (str): Caminho do arquivo a ser executado.
    """
    try:
        if not os.path.exists(PYTHON_PATH_VENV) or not os.path.exists(file_path):
            LOGGER_HANDLER.info(">>> Caminho do arquivo não encontrado...")
            raise FileNotFoundError("Caminho do arquivo não encontrado.")
        subprocess.run(
            [PYTHON_PATH_VENV, "-m", "robot", "-d", "results", file_path], check=True
        )
        LOGGER_HANDLER.info(f">>> {file_path} executado com sucesso.")
    except Exception as e:
        LOGGER_HANDLER.error(f"Erro ao executar {file_path}: {e}")


def run_python_file(file_path):
    """Executa o arquivos python.

    Args:
        file_path (str): Caminho do arquivo a ser executado.
    """
    try:
        if not os.path.exists(PYTHON_PATH_VENV) or not os.path.exists(file_path):
            LOGGER_HANDLER.info(">>> Caminho do arquivo não encontrado...")
            raise FileNotFoundError("Caminho do arquivo não encontrado.")
        subprocess.run([PYTHON_PATH_VENV, file_path], check=True)
        LOGGER_HANDLER.info(f">>> {file_path} executado com sucesso.")
    except Exception as e:
        LOGGER_HANDLER.error(f"Erro ao executar {file_path}: {e}")


if __name__ == "__main__":
    LOGGER_HANDLER.info(sys.argv)
    if len(sys.argv) > 1:
        if sys.argv[1] == "--update":
            LOGGER_HANDLER.info(
                ">>> Argumento --update detectado, iniciando o script de atualização..."
            )
            run_robot_file(UPDATER_PATH)
        elif sys.argv[1] == "--main":
            LOGGER_HANDLER.info(
                ">>> Argumento --main detectado, iniciando o script principal..."
            )
            run_robot_file(MAIN_SCRIPT_PATH)
        elif sys.argv[1] == "--debug":
            LOGGER_HANDLER.debug(
                ">>> Argumento --debug detectado, iniciando os scripts principais (main.robot e updater.robot)..."
            )
            run_robot_file(UPDATER_PATH)
            run_robot_file(MAIN_SCRIPT_PATH)
        elif sys.argv[1] == "--verify":
            LOGGER_HANDLER.debug(
                ">>> Argumento --verify detectado, iniciando o script verificador..."
            )
            run_python_file(VERIFICATOR_PATH)
    else:
        LOGGER_HANDLER.info(
            "Aguarde o horario de execução do bot, ou execute com o argumento --update para atualizar o sistema."
        )
        schedule.every().sunday.at("12:00").do(run_robot_file, UPDATER_PATH)
        schedule.every().sunday.at("12:10").do(run_robot_file, MAIN_SCRIPT_PATH)
        schedule.every().sunday.at("12:15").do(run_python_file, VERIFICATOR_PATH)
