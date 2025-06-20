*** Settings ***
Library   SikuliLibrary
Resource    ./variables.robot
*** Keywords ***
# Carrega as imagens do sistema
Carragar Imagens 
    Add Image Path    ${IMAGE_DIR}

Esperar e Clicar
    [Arguments]    ${image}    ${timeout}=60
    Wait Until Screen Contain    ${image}    ${timeout}
    Click    ${image}