*** Settings ***
Library   SikuliLibrary
Library    keywords.py
Resource    ./variables.robot
*** Keywords ***
# Carrega as imagens do sistema
Carragar Imagens 
    Add Image Path    ${IMAGE_DIR}

Esperar e Clicar
    [Arguments]    ${image}    ${timeout}=60
    Wait Until Screen Contain    ${image}    ${timeout}
    Click    ${image}

Selecionar Base de Dados
    [Arguments]    ${base}=5
    Click At Location   (689,359)
    Sleep    2
    Press Special Key    UP
    Sleep    1
    FOR    ${i}    IN RANGE    0    ${base}    
        Log    Campo de base: ${i}
        Press Special Key    DOWN
        Sleep    1
    END
    Sleep    1
    Press Special Key    ENTER