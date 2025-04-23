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
    # TODO: Descomentar o código abaixo quando for necessário testes com uma base menor 
    # Wait Until Screen Contain    drivers_icon.png    10
    # Click    drivers_icon.png
# Aperta em confirmar após a keyword
Confirmar
    Wait Until Screen Contain    yes_icon.png    12
    Click    yes_icon.png
# Procura o botão de cancelar, enquanto ele existir o loop continua
Procurar Icone
    [Arguments]    ${icon}
    ${icon_exists}=    Exists    ${icon}.png    12
    WHILE    ${icon_exists} == 'True'
        Log    ${icon} não encontrado
        ${icon_exists}=    Exists    ${icon}.png    12
    END
    Log    ${icon} encontrado
Espera o Cancelar Desaparecer
    ${cancel_icon}    Exists    cancel_icon.png    12
    WHILE    ${cancel_icon} == 'True'
        Log    ${cancel_icon} não encontrado
        ${cancel_icon}    Exists    cancel_icon.png    12
        IF    ${cancel_icon} == 'False'
            BREAK
        END
    END
# Aperta em exporta a planilha
Exportar Planilha
    Wait Until Screen Contain    export_icon.png    12
    Click    export_icon.png
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
    Procurar Icone    alert_excel_icon
    Sleep    10    Espera 10s para o excel abrir
    Wait Until Screen Contain    alert_excel_icon.png    10
    Click    alert_excel_icon.png
    Espera o Excel Abrir
# Salva a planilha
Salvar Planilha
    Press Keys    ctrl    b
    Wait Until Screen Contain    resources_icon.png    10
    Click    resources_icon.png
    Wait Until Screen Contain    is_opened_explore_icon.png    15
    Type With Modifiers    cliente_base
    Copy File Cliente Base  
    Press Special Key    ENTER
    Espera o Excel Abrir
    Alt F4
# Muda o foco para a janela do sistema FJ Frigo
Switch Para Janela FJ Frigo
    ${status}=    Switch To FJ Frigo
    
# Fecha o Sistema da Fj Frigo
Fechar Sistema FJ Frigo
    ${is_open}    Exists    fj_is_opened_icon.png    10
    IF    ${is_open} == 'True'
       Wait Until Screen Contain    fj_exit_icon.png    10
       Click    fj_exit_icon.png
    ELSE
        Switch Para Janela FJ Frigo
        Wait Until Screen Contain    fj_exit_icon.png    10
        Click    fj_exit_icon.png
    END 