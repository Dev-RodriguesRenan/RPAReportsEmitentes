*** Settings ***
Documentation   Arquivo base para o Robô de relatórios do BMG Crédito
Resource        resources/keywords.robot
Library       SikuliLibrary 

*** Variables ***

*** Keywords ***
*** Test Cases ***
Caso de Baixar Planilha
    Abrir Sistema FJ Frigo
    Abrir os Emitentes
    Selecionar Emitentes
    Selecionar Cliente
    Confirmar
    Procurar Cancelar
    Exportar Planilha

