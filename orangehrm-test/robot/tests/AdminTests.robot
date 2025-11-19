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
GRP1-6-TA: Invalid and no records messages
    [Documentation]    Validate error messages when invalid employee name is entered.
    [Tags]    admin    validation    grp1-6-ta
    Given Admin Is Logged In
    When Go To Admin Module
    When Click Add User
    When Type Employee Name    Haydar
    Then No Records Found Should Be Visible
    When Focus Admin Header
    Then Invalid Message Should Be Visible

GRP1-7-TA: Username minimum five characters
    [Documentation]    Validate username field requires at least five characters.
    [Tags]    admin    validation    grp1-7-ta
    Given Admin Is Logged In
    When Go To Admin Module
    When Click Add User
    When Set Admin Username    test
    Then Min 5 Characters Message Should Be Visible

GRP1-11-TA: Add User title visible
    [Documentation]    Verify Add User title is visible on the form.
    [Tags]    admin    ui    grp1-11-ta
    Given Admin Is Logged In
    When Go To Admin Module
    When Click Add User
    Then Add User Title Should Be Visible

GRP1-8-ZY: Already exists message for username
    [Documentation]    Validate already exists message when entering existing username.
    [Tags]    admin    validation    grp1-8-zy
    Given Admin Is Logged In
    When Go To Admin Module
    When Click Dialog Element    UserManagment
    When Click Dialog Element    addButton
    When Type In Dialog    userNameInput    Admin
    Then Already Exists Message Should Be Visible

GRP1-13-ZY: Lowercase rule for password
    [Documentation]    Validate password requires at least one lowercase letter.
    [Tags]    admin    validation    grp1-13-zy
    Given Admin Is Logged In
    When Go To Admin Module
    When Click Dialog Element    addButton
    When Type In Dialog    userPassword    DEMOCODE*9
    Then Lowercase Rule Message Should Be Visible