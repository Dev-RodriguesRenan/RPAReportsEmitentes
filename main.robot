*** Settings ***
Documentation   Arquivo base para o Robô de relatórios do BMG Crédito
Resource        resources/keywords.robot
Library         resources/keywords.py
Library       SikuliLibrary 
Library    DateTime
Test Setup    Carragar Imagens
Test Teardown    Fechar Sistemas CMD
*** Variables ***
${is_executed}    False

*** Test Cases ***
Caso de Baixar Planilha
    [Documentation]    Baixa a planilha do sistema FJ Frigo
    ${DATE_CURRENT}    Get Current Datetime
    TRY
                Log    Iniciando o robô    console=True
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
                Log    Planilha gerada com sucesso!!    console=True
                Set Variable    ${is_executed}    True
    EXCEPT     AS     ${error}
                Log    Erro ao executar o robô:\n${error}    console=True
                Fechar Sistemas CMD
    END
    Log    Programa executado com sucesso ${DATE_CURRENT}    console=True
        
                

    
