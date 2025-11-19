*** Settings ***
Library    Browser

*** Keywords ***
Suite Setup Keyword
    New Browser    chromium    headless=${HEADLESS}
    New Context
    New Page    ${BASE_URL}

Suite Teardown Keyword
    Close Browser

Test Setup Keyword
    No Operation

Test Teardown Keyword
    Run Keyword If    "${TEST STATUS}"!="PASS"    Take Screenshot    filename=EMBED

Click With Wait    ${selector}
    [Arguments]    ${selector}
    Wait For Elements State    ${selector}    visible    10s
    Click    ${selector}

Fill Text With Wait    ${selector}    ${text}
    [Arguments]    ${selector}    ${text}
    Wait For Elements State    ${selector}    visible    10s
    Fill Text    ${selector}    ${text}

Expect Visible    ${selector}
    [Arguments]    ${selector}
    Wait For Elements State    ${selector}    visible    10s