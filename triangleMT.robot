*** Settings ***
Documentation     Example test cases using a triangle calculator web page
...
...               Notice that one of these tests fails on purpose to show how
...               failures look like.
Suite Setup       Test Launch
Suite Teardown    Close Browser
Library           Selenium2Library

*** Variables ***

*** Test Cases ***
Integer Test
    [Documentation]    Integer value inputs
    [Tags]    Integer
    [Template]    Calculate_Triangle
    2    45    37
    5    68    26
    4    26    19

Decimal Test
    [Documentation]    Decimal value inputs
    [Tags]    Decimal
    [Template]    Calculate_Triangle
    2.8    41.5    21.7
    3.2    23.7    36.4
    1.2    63.7    29.8

*** Keywords ***
Calculate_Triangle
    [Arguments]    ${SideB}    ${AngleA}    ${AngleC}
    Wait Until Page Contains Element    angle_a
    Wait Until Page Contains Element    angle_c
    Wait Until Page Contains Element    side_b
    Input Text    side_b    ${SideB}
    Input Text    angle_a    ${AngleA}
    Input Text    angle_c    ${AngleC}
    Submit Form    calculator
    Sleep    1
    Capture Page Screenshot
    Click Link    \#calculator
    Click Button    clear
 
Test Launch
    Set Selenium Timeout    10
    Set Selenium Implicit Wait    10
    Open Browser    http://cossincalc.com    googlechrome
    Maximize Browser Window
