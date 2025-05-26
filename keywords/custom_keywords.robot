*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${APP_URL}           http://localhost:4200
${BROWSER}           Firefox
${HEADER_TITLE}      css:.toolbar-title
${ITEM_NAME_INPUT}   css:input#name
${ITEM_DESC_INPUT}   css:textarea#description
${ITEM_ROWS}         css:table tbody tr
${DELETE_BTN}        css:button.btn-danger
${ITEM_ROW_NAME}     css:table tbody tr:nth-child(1) td:nth-child(2)
${DEFAULT_TIMEOUT}    10s

*** Keywords ***
# --- Keywords techniques ---
Wait For And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Wait For And Input
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Input Text    ${locator}    ${text}

Verify Element Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Text    ${locator}
    Should Be Equal    ${actual_text}    ${expected_text}

Take Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot

Wait For And Verify Element Text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Element Is Visible    ${locator}    timeout=${DEFAULT_TIMEOUT}
    ${actual_text}=    Get Text    ${locator}
    Should Be Equal    ${actual_text}    ${expected_text}

# --- Keywords métiers ---
Open Application
    Open Browser    ${APP_URL}    ${BROWSER}
    Maximize Browser Window
    Wait For And Verify Element Text    ${HEADER_TITLE}    Gestion des Éléments

Get Item Count
    ${count}=    Get Element Count    ${ITEM_ROWS}
    [Return]    ${count}

Delete First Item
    Wait For And Click    ${DELETE_BTN}
    Handle Alert    action=ACCEPT

Verify First Item Name
    [Arguments]    ${expected_name}
    Verify Element Text    ${ITEM_ROW_NAME}    ${expected_name}