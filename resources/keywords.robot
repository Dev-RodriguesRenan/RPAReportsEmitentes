*** Settings ***
Documentation   Arquivo keywords para o Robô de relatórios do BMG Crédito
Library       SikuliLibrary
Resource    ./variables.robot
Library    ./keywords.py

*** Keywords ***
# Carrega as imagens do sistema
Carragar Imagens 
    Add Image Path    ${IMAGE_DIR}
Executar FJ Frigo
    Press Special Key    WIN
    Sleep    2
    Type With Modifiers    fjfrigo
    Sleep    2
    Press Special Key    ENTER
# Abre o sistema da FJ-FRIGO
Abrir Sistema FJ Frigo
    Executar FJ Frigo  
    Wait Until Screen Contain    fjbanner_icon.png    30
    Sleep    7    Espera 7s para contiar o processo
    Passar TAB    3
    Write Text    ${password}
    Click    ok_icon.png
# Passa com a tecla TAB
Passar TAB
    [Arguments]  ${qtd}
    FOR    ${counter}    IN RANGE    0    ${qtd} 
        Press Special Key    TAB
    END
# Seleciona o campo emitentes no menu da fjfrigo principal
Abrir os Emitentes
    Wait Until Screen Contain    person_icon.png    10
    Click    person_icon.png
# Seleciona o campo +999 emitentes no menu da fjfrigo > emitentes
Selecionar Emitentes
    Wait Until Screen Contain    select_emitente_icon.png    10
    Click    select_emitente_icon.png
# Seleciona o campo cliente no submenu de emitentes
Selecionar Cliente
    Wait Until Screen Contain    select_client_icon.png    10
    Click    select_client_icon.png
# Aperta em confirmar após a keyword
Confirmar
    Wait Until Screen Contain    yes_icon.png    12
    Click    yes_icon.png
# Procura o botão de cancelar, enquanto ele existir o loop continua
Procurar Cancelar
    ${isCancel}    Exists    cancel_icon.png    8
    WHILE    ${isCancel} == 'True'
        Sleep    3
        ${isCancel}    Exists    cancel_icon.png    8
        IF    ${isCancel} == 'False'
            BREAK
        END
    END
# Aperta em exporta a planilha
Exportar Planilha
    Wait Until Screen Contain    export_icon.png    12
    Click    export_icon.png
    Procurar Cancelar
# Espera o Excel abrir
Espera o Excel Abrir
    ${isExcel}    Exists    is_opened_excel_icon.png    8
    WHILE    ${isExcel} == 'False'
        Sleep    3
        ${isExcel}    Exists    is_opened_excel_icon.png    8
        IF    ${isExcel} == 'True'
            BREAK
        END
    END
# Abre o Excel
Abrir o Excel
    Wait Until Screen Contain    alert_excel_icon.png    10
    Click    alert_excel_icon.png
    Espera o Excel Abrir
# Salva a planilha
Salvar Planilha
    Press Keys    ctrl    b
    Wait Until Screen Contain    resources_icon.png    10
    Click    resources_icon.png
    Wait Until Screen Contain    is_opened_explore_icon.png    15
    ${data_hoje}    Get Current Datetime
    Type With Modifiers    data_${data_hoje}
    Press Special Key    ENTER
    Espera o Excel Abrir
    Alt F4
Fechar Sistema FJ Frigo
    ${is_open}    Exists    fj_is_opened_icon.png    8
    IF    ${is_open} == 'True'
       Wait Until Screen Contain    fj_exit_icon.png    10
       Click    fj_exit_icon.png
    ELSE
        Wait Until Screen Contain    fj_opened_icon.png    10
        Click    fj_opened_icon.png
        Wait Until Screen Contain    fj_exit_icon.png    10
        Click    fj_exit_icon.png
    END 