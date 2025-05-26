*** Settings ***
Resource    ../keywords/custom_keywords.robot

*** Variables ***
# Page-specific locators
${ADD_ITEM_BUTTON}       css:.btn-primary
${ITEM_FORM}             css:.card-body form
${ITEM_TABLE}            css:table.table
${SUCCESS_ALERT}         css:.alert-success

*** Keywords ***
# --- Page-specific keywords ---
Navigate To Home Screen
    [Documentation]    Opens the application and verifies homepage loads
    Open Application
    Wait Until Element Is Visible    ${ITEM_TABLE}

Verify Item Exists In Table
    [Arguments]    ${item_name}
    [Documentation]    Checks if item exists in the table
    Table Should Contain    ${ITEM_TABLE}    ${item_name}

Verify Item Count In Table
    [Arguments]    ${expected_count}
    [Documentation]    Verifies exact number of items in table
    ${row_count}=    Get Element Count    ${ITEM_ROWS}
    Should Be Equal As Numbers    ${row_count}    ${expected_count}

Verify Form Is Visible
    [Documentation]    Checks if item form is displayed
    Wait Until Element Is Visible    ${ITEM_FORM}

Verify Success Message
    [Documentation]    Verifies operation success alert
    Wait Until Element Is Visible    ${SUCCESS_ALERT}