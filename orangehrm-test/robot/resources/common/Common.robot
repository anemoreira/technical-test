*** Settings ***
Library    Browser
Library    OperatingSystem

*** Keywords ***
Load Env File
    ${env_path}=    Set Variable    ${CURDIR}/../../.env
    ${exists}=    Run Keyword And Return Status    File Should Exist    ${env_path}
    Run Keyword If    not ${exists}    Return From Keyword
    ${content}=    Get File    ${env_path}
    @{lines}=    Split To Lines    ${content}
    FOR    ${line}    IN    @{lines}
        ${is_empty}=    Evaluate    len(str(${line}).strip()) == 0
        Run Keyword If    ${is_empty}    Continue For Loop
        ${is_comment}=    Evaluate    str(${line}).lstrip().startswith('#')
        Run Keyword If    ${is_comment}    Continue For Loop
        ${parts}=    Split String    ${line}    =
        ${len}=    Get Length    ${parts}
        Run Keyword If    ${len} < 2    Continue For Loop
        ${key}=    Get From List    ${parts}    0
        ${val}=    Get From List    ${parts}    1
        ${existing}=    Get Environment Variable    ${key}    __UNDEFINED__
        Run Keyword If    '${existing}'=='__UNDEFINED__'    Set Environment Variable    ${key}    ${val}
    END

Suite Setup Keyword
    Load Env File
    ${base_url}=    Get Environment Variable    BASE_URL    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    ${admin_user}=    Get Environment Variable    ADMIN_USER    Admin
    ${admin_pass}=    Get Environment Variable    ADMIN_PASS    admin123
    ${headless_str}=    Get Environment Variable    HEADLESS    True
    ${headless}=    Convert To Boolean    ${headless_str}
    Set Suite Variable    ${BASE_URL}    ${base_url}
    Set Suite Variable    ${ADMIN_USER}    ${admin_user}
    Set Suite Variable    ${ADMIN_PASS}    ${admin_pass}
    Set Suite Variable    ${HEADLESS}    ${headless}
    New Browser    chromium    headless=${HEADLESS}
    New Context
    New Page    ${BASE_URL}

Suite Teardown Keyword
    Close Browser

Test Setup Keyword
    No Operation

Test Teardown Keyword
    Run Keyword If    "${TEST STATUS}"!="PASS"    Take Screenshot    filename=EMBED

Click With Wait
    [Arguments]    ${selector}
    Wait For Elements State    ${selector}    visible    10s
    Click    ${selector}

Fill Text With Wait
    [Arguments]    ${selector}    ${text}
    Wait For Elements State    ${selector}    visible    10s
    Fill Text    ${selector}    ${text}

Expect Visible
    [Arguments]    ${selector}
    Wait For Elements State    ${selector}    visible    10s
