*** Settings ***
Resource    ../keywords/custom_keywords.robot
Test Teardown    Run Keywords    Take Screenshot On Failure
    ...    AND    Close Browser

*** Test Cases ***
Verify Initial State
    [Tags]    smoke
    Given The Application Is Open
    Then The System Should Show 2 Items
    And The Header Should Display "Gestion des Éléments"

Test Delete Item
    [Tags]    regression
    Given The Application Is Open
    When User Deletes First Item
    Then The System Should Show 1 Items

Test Failed Test
    [Tags]    regression
    Given The Application Is Open
    When User Deletes First Item
    Then The System Should Show 2 Items

*** Keywords ***
# --- En utilisant la syntaxe Gherkin ---
The Application Is Open
    Open Application

The System Should Show ${number} Items
    ${count}=    Get Item Count
    Should Be Equal As Numbers    ${count}    ${number}

The Header Should Display "${text}"
    Verify Element Text    ${HEADER_TITLE}    ${text}

The First Item Should Be Named "${name}"
    Verify First Item Name    ${name}

User Deletes First Item
    Delete First Item