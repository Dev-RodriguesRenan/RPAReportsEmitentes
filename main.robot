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
        Espera o Cancelar Desaparecer
        Exportar Planilha
        Espera o Cancelar Desaparecer
        Abrir o Excel
        Salvar Planilha
        Fechar Sistema FJ Frigo

    
