import logging
import colorama
from colorama import Fore, Back, Style
import os
import datetime

# Inicializar colorama
colorama.init(autoreset=True)


class ColoredFormatter(logging.Formatter):
    """Formatter personalizado para adicionar cores aos logs no console"""

    # Definir cores para cada nível de log
    COLORS = {
        "DEBUG": Fore.CYAN,
        "INFO": Fore.GREEN,
        "WARNING": Fore.YELLOW,
        "ERROR": Fore.RED,
        "CRITICAL": Fore.RED + Back.WHITE + Style.BRIGHT,
    }

    def format(self, record):
        # Obter a cor para o nível do log
        log_color = self.COLORS.get(record.levelname, Fore.WHITE)

        # Formatar a mensagem original
        formatted_message = super().format(record)

        # Aplicar cor apenas ao nome do nível
        colored_level = f"{log_color}{record.levelname}{Style.RESET_ALL}"

        # Substituir o nível original pelo colorido
        formatted_message = formatted_message.replace(
            record.levelname, colored_level, 1
        )

        return formatted_message


def setup_logger(name="app_logger", log_file="app.log", level=logging.DEBUG):
    """
    Configura um logger com saída para arquivo e console colorido

    Args:
        name (str): Nome do logger
        log_file (str): Nome do arquivo de log
        level: Nível de logging (DEBUG, INFO, WARNING, ERROR, CRITICAL)

    Returns:
        logging.Logger: Logger configurado
    """

    # Criar diretório de logs se não existir
    log_dir = "logs"
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)

    # Caminho completo do arquivo de log
    log_path = os.path.join(log_dir, log_file)

    # Criar logger
    logger = logging.getLogger(name)
    logger.setLevel(level)

    # Evitar duplicação de handlers se o logger já foi configurado
    if logger.handlers:
        return logger

    # Formato para logs
    log_format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    date_format = "%Y-%m-%d %H:%M:%S"

    # Handler para arquivo (sem cores)
    file_handler = logging.FileHandler(log_path, encoding="utf-8")
    file_handler.setLevel(level)
    file_formatter = logging.Formatter(log_format, date_format)
    file_handler.setFormatter(file_formatter)

    # Handler para console (com cores)
    console_handler = logging.StreamHandler()
    console_handler.setLevel(level)
    console_formatter = ColoredFormatter(log_format, date_format)
    console_handler.setFormatter(console_formatter)

    # Adicionar handlers ao logger
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    return logger


LOGGER_HANDLER = setup_logger(
    __file__.replace(".py", ""), f"app_{datetime.datetime.now().strftime('%d%m%Y')}.log"
)
