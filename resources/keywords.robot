*** Settings ***
Documentation   Arquivo keywords para o Robô de relatórios do BMG Crédito
Library       SikuliLibrary
Resource    ./shares.robot
Library    ./keywords.py

*** Keywords ***
Executar FJ Frigo
    Press Special Key    WIN
    Sleep    2
    Type With Modifiers    fjfrigo
    Sleep    5
    Press Special Key    ENTER
# Abre o sistema da FJ-FRIGO
Abrir Sistema FJ Frigo
    Executar FJ Frigo  
    Wait Until Screen Contain    fjbanner_icon.png    30
    Sleep    7    Espera 7s para contiar o processo
    Passar TAB    3
    Write Text    ${password}
    Passar TAB    1
    Press Special Key    ENTER
# Passa com a tecla TAB
Passar TAB
    [Arguments]  ${qtd}
    FOR    ${counter}    IN RANGE    0    ${qtd} 
        Press Special Key    TAB
    END
# Seleciona o campo emitentes no menu da fjfrigo principal
Abrir os Emitentes
    Esperar e Clicar    person_icon.png    10
# Seleciona o campo +999 emitentes no menu da fjfrigo > emitentes
Selecionar Emitentes
    Esperar e Clicar    select_emitente_icon.png    10
# Seleciona o campo cliente no submenu de emitentes
Selecionar Cliente
    Esperar e Clicar    select_client_icon.png    10
    # TODO: Descomentar o código abaixo quando for necessário testes com uma base menor 
    # Esperar e Clicar    drivers_icon.png    10
# Aperta em confirmar após a keyword
Confirmar
    Esperar e Clicar    yes_icon.png    12
    Sleep    2
Espera o Cancelar Desaparecer
    Sleep    3
    Wait Until Screen Not Contain    cancel_icon.png    3600
    Log    O Botão Cancelar Sumiu!!    level=DEBUG     console=True    
# Aperta em exporta a planilha
Exportar Planilha
    Esperar e Clicar    export_icon.png    12
# Espera o Excel abrir
Espera o Excel Abrir
    ${encontrado}=    Run Keyword And Return Status    Wait Until Screen Contain    is_opened_excel_icon.png    120
    WHILE    ${encontrado} == False
        Sleep    2
        ${encontrado}=    Run Keyword And Return Status    Wait Until Screen Contain    is_opened_excel_icon.png    120
    END
Espera o Icone de Abrir o Excel
    ${encontrado}=    Run Keyword And Return Status    Wait Until Screen Contain    alert_excel_icon.png    120
    WHILE    ${encontrado} == False
        Sleep    2
        ${encontrado}=    Run Keyword And Return Status    Wait Until Screen Contain    alert_excel_icon.png    120
    END
# Abre o Excel
Abrir o Excel
    Espera o Icone de Abrir o Excel
    Log   O Excel apareceu!!    console=True
    Sleep    10    Espera 10s para o excel abrir
    Esperar e Clicar    alert_excel_icon.png    10
    Espera o Excel Abrir
    Log    O Excel abriu com sucesso!!    console=True
Verifica se vai sobreescrever o arquivo
    ${is_opened}=    Run Keyword And Return Status    Wait Until Screen Contain    alert_overwrite_icon.png    10
    IF    ${is_opened} == True
        Press Special Key    LEFT
        Sleep    2
        Press Special Key    ENTER
    ELSE
        Log    O arquivo cliente_base já existe. Não é necessário sobrescrever.    console=True
    END
# Salva a planilha
Salvar Planilha
    Press Keys    ctrl    b
    Esperar e Clicar    resources_icon.png    10
    Wait Until Screen Contain    is_opened_explore_icon.png    15
    Type With Modifiers    cliente_base
    Press Special Key    ENTER
    Verifica se vai sobreescrever o arquivo
    Espera o Excel Abrir
    Sleep    20    Espera 20s para o excel salvar a planilha
    Alt F4
    Copy File Cliente Base
    Log    Planilha salva com sucesso!!    console=True  
# Muda o foco para a janela do sistema FJ Frigo
Switch Para Janela FJ Frigo
    ${status}=    Switch To FJ Frigo
    
# Fecha o Sistema da Fj Frigo
Fechar Sistema FJ Frigo
    ${is_open}    Exists    fj_is_opened_icon.png    10
    IF    ${is_open} == 'True'
       Esperar e Clicar    fj_exit_icon.png    10
    ELSE
        Switch Para Janela FJ Frigo
        Esperar e Clicar    fj_exit_icon.png    10
    END 

Fechar Sistemas CMD
    Kill Process