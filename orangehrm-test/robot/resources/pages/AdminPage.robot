*** Settings ***
Library    Browser
Resource   ../locators/AdminLeftNav.robot
Resource   ../locators/AdminDialog.robot

*** Keywords ***
When Go To Admin Module
    Click With Wait    ${ADMIN_MENU}

When Click Add User
    Click With Wait    ${ADD_BUTTON}
    Expect Visible     ${ADD_USER_TITLE}

When Type Employee Name    ${name}
    Fill Text With Wait    ${EMPLOYEE_HINT}    ${name}

When Pick Employee From Hint
    Click With Wait    ${EMPLOYEE_OPTION_PETER}

Then No Records Found Should Be Visible
    Expect Visible    ${NO_RECORDS_FOUND}

When Focus Admin Header
    Click With Wait    ${ADMIN_HEADER}

Then Invalid Message Should Be Visible
    Expect Visible    ${INVALID_MESSAGE}

When Set Admin Username    ${value}
    Fill Text With Wait    ${ADMIN_USERNAME_INPUT}    ${value}

Then Min 5 Characters Message Should Be Visible
    Expect Visible    ${MIN5_MESSAGE}

Then Add User Title Should Be Visible
    Expect Visible    ${ADD_USER_TITLE}

When Click Dialog Element    ${name}
    ${sel}=    Set Variable    ${DIALOG.${name}}
    Click With Wait    ${sel}

When Type In Dialog    ${field}    ${value}
    ${sel}=    Set Variable    ${DIALOG.${field}}
    Fill Text With Wait    ${sel}    ${value}

Then Already Exists Message Should Be Visible
    Expect Visible    ${ALREADY_EXISTS}

Then Lowercase Rule Message Should Be Visible
    Expect Visible    ${LOWERCASE_RULE}

When Open User Management
    Click With Wait    ${ADMIN_MENU}
    Click With Wait    ${USER_MANAGEMENT}

When Select User Role    ${role}
    Click With Wait    ${USER_ROLE_DROPDOWN}
    Click    xpath=//div[@role='listbox']//span[normalize-space()='${role}']

When Select Status    ${status}
    Click With Wait    ${STATUS_DROPDOWN}
    Click    xpath=//div[@role='listbox']//span[normalize-space()='${status}']

When Set Passwords    ${password}
    Fill Text With Wait    ${PASSWORD_INPUT_1}    ${password}
    Fill Text With Wait    ${PASSWORD_INPUT_2}    ${password}

Then Save And Expect Success
    Click With Wait    ${SAVE_BUTTON}
    Expect Visible     ${SUCCESS_TOAST}

When Open Edit For Username    ${username}
    ${row_cell}=    Set Variable    //div[@class='oxd-table-cell oxd-padding-cell' and normalize-space()='${username}']
    Wait For Elements State    ${row_cell}    visible    10s
    ${edit_icon}=    Set Variable    xpath=${row_cell}/following::div[contains(@class,'oxd-table-cell-actions')][1]//i[contains(@class,'bi-pencil-fill')]
    Click    ${edit_icon}

When Delete Username    ${username}
    ${row_cell}=    Set Variable    //div[@class='oxd-table-cell oxd-padding-cell' and normalize-space()='${username}']
    Wait For Elements State    ${row_cell}    visible    10s
    ${trash_icon}=    Set Variable    xpath=${row_cell}/following::div[contains(@class,'oxd-table-cell-actions')][1]//i[contains(@class,'bi-trash')]
    Click    ${trash_icon}
    Click With Wait    ${YES_DELETE_BUTTON}
    Expect Visible     ${SUCCESS_TOAST}