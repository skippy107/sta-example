*** Settings ***
Suite Teardown    Close All Browsers
Library           SeleniumLibrary

*** Variables ***
${URL Application}    http://www.w3schools.com

*** Test Cases ***
Select
    Open Browser    http://www.w3schools.com    firefox    mainbrowser
    Go To    http://www.w3schools.com/tags/tryit.asp?filename=tryhtml_select
    Wait Until Page Contains Element    iframeResult
    Select Frame    iframeResult
    Wait Until Page Contains Element    xpath=//select
    Select From List By Value    xpath=//select    Opel
    ${label}    Get Selected List Label    xpath=//select
    Should Be Equal    ${label}    Opel
    List Selection Should Be    xpath=//select    Opel
    
Multiple Browsers
    Open Browser    http://www.w3schools.com    firefox    mainbrowser1
    Open Browser    http://www.w3schools.com    firefox    mainbrowser2
    Close All Browsers

No Browser Alias
    Open Browser    http://www.w3schools.com    firefox
    Close Browser

Close All Browsers reset the browser index to 1
    [Documentation]    Ensure that the Browser count is reset to 0 when Close All Browsers is used.
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser1
    Should Be Equal    ${id}    1    
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser2
    Should Be Equal    ${id}    2    
    Close All Browsers
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser1
    Should Be Equal    ${id}    1
    Close All Browsers

Open Browser after Close Browser creates unique browser id
    [Documentation]    Ensure that the Close Browser keyword doesn't reset the count, rather that it decrements.
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser1
    Should Be Equal    ${id}    1    
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser2
    Should Be Equal    ${id}    2    
    Close browser
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser2
    Should Be Equal    ${id}    2    
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser3
    Should Be Equal    ${id}    3    
    Close browser
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser4
    Should Be Equal    ${id}    3
    Switch Browser    2    
    Close browser
    ${id}    Open Browser    http://www.w3schools.com    firefox    mainbrowser2
    Should Be Equal    ${id}    2    
    Close All Browsers
