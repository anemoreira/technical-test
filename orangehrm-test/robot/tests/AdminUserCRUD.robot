*** Settings ***
Library           Browser
Resource          ../variables/vars.robot
Resource          ../resources/common/Common.robot
Resource          ../resources/pages/LoginPage.robot
Resource          ../resources/pages/AdminPage.robot
Suite Setup       Suite Setup Keyword
Suite Teardown    Suite Teardown Keyword
Test Setup        Test Setup Keyword
Test Teardown     Test Teardown Keyword

*** Test Cases ***
Admin: Add, Edit and Delete User
    [Documentation]    Create a user, edit its status, and delete it in Admin.
    [Tags]    admin    crud    smoke
    ${rand}=    Evaluate    __import__('random').randint(10000,99999)
    ${username}=    Set Variable    user${rand}
    ${password}=    Set Variable    Passw0rd*

    Given Admin Is Logged In
    When Open User Management
    When Click Add User
    When Select User Role    ESS
    When Select Status       Enabled
    When Type Employee Name  Peter Mac Anderson
    When Pick Employee From Hint
    When Set Admin Username  ${username}
    When Set Passwords       ${password}
    Then Save And Expect Success

    When Open User Management
    When Open Edit For Username    ${username}
    When Select Status             Disabled
    Then Save And Expect Success

    When Open User Management
    When Delete Username           ${username}