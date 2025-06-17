*** Settings ***
Library         SikuliLibrary
Library         keywords.py
Library         verificator.py
Resource        keywords.robot
Test Setup        Carragar Imagens


*** Keywords ***
Open FJ Frigo
    Press Special Key    WIN
    Sleep    3s

    Input Text    ${EMPTY}    fjfrigo
    Sleep    5s
    Press Special Key    ENTER
Verify And Update FJ Frigo
    Wait Until Screen Contain    fjbanner_icon.png    30
    Sleep    15s    Aguarda para caso apareça a tela de update
    # Verifica se a tela de update está presente
    ${update}    Update Fj Frigo
    IF    ${update} == True
        Log    \nFJFRIGO ATUALIZADO...\n    level=DEBUG    console=True
    ELSE
        Log    \nFJFRIGO NÃO FOI ATUALIZADO...\n    level=DEBUG    console=True
        Alt F4
    END

*** Test Cases ***
Updater
    Open FJ Frigo
    Verify And Update FJ Frigo