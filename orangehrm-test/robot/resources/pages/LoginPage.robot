*** Settings ***
Library    Browser
Resource   ../locators/LoginLocators.robot

*** Keywords ***
Given Open Login Page
    Go To    ${BASE_URL}

Given Login As Admin
    Fill Text With Wait    ${LOGIN_USERNAME}    ${ADMIN_USER}
    Fill Text With Wait    ${LOGIN_PASSWORD}    ${ADMIN_PASS}
    Click With Wait        ${LOGIN_SUBMIT}
    Expect Visible         ${ADMIN_MENU}

Given Admin Is Logged In
    Given Open Login Page
    Given Login As Admin