*** Settings ***
Documentation   Arquivo keywords para o Robô de relatórios do BMG Crédito
Library       SikuliLibrary
Resource    variables.robot

*** Keywords ***
# Abre o sistema da FJ-FRIGO
Abrir Sistema FJ Frigo
    Open Application    ${fjfrigo_path}
    Wait Until Screen Contain    fjbanner_icon.png    30
    Sleep    7    Espera 7s para contiar o processo
    Passar TAB    3
    Type With Modifiers    ${password}
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