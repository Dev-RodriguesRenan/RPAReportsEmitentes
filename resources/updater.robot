*** Settings ***
Documentation   Arquivo de atualização do Robô de relatórios do BMG Crédito
Library       SikuliLibrary
Resource    ./variables.robot
Resource    keywords.robot
Library    ./verificator.py
Library    keywords.py
Test Setup    Carragar Imagens
*** Keywords ***
# Verifica se o Robô de relatórios do BMG Crédito está atualizado
Atualizar Sistema
    # Abre o sistema FJ Frigo     
    Executar FJ Frigo

    # Aguarda a tela do FJ Frigo aparecer e aguarda o tempo para aparecer o FJUpdater
    Wait Until Screen Contain    fjbanner_icon.png    30
    Sleep    20s
    # Atualiza o sistema caso exista o FJUpdater
    ${atualizacao}    Update
    IF    ${atualizacao} == 'True'
        Log    message=O Robô de relatórios do BMG Crédito atualizado com sucesso!    console=True 
    ELSE
        Log    message=O Robô de relatórios do BMG Crédito já está atualizado!    console=True 
    END

*** Test Cases ***
# Verifica se o Robô de relatórios do BMG Crédito está atualizado
Verificar e Atualizar
    Atualizar Sistema
    Alt F4