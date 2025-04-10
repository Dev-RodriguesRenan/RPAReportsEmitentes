*** Settings ***
Documentation   Arquivo base para o Robô de relatórios do BMG Crédito
Resource        resources/keywords.robot
Library       SikuliLibrary 

*** Test Cases ***
Caso de Baixar Planilha
    Carragar Imagens
    Abrir Sistema FJ Frigo
    Abrir os Emitentes
    Selecionar Emitentes
    Selecionar Cliente
    Confirmar
    Procurar Cancelar
    Exportar Planilha
    Abrir o Excel
    Salvar Planilha
    Fechar Sistema FJ Frigo
