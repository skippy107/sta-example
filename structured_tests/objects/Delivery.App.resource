*** Settings ***

Resource          ../adapters/SeleniumLibrary.resource

Documentation     Defines all resources and keywords 
...               handling the application object
...
...    For example purposes, the web driver commands are commented out
...  

*** Variables ***

${App.Url}    http://www.google.com
${App.GridUrl}    http://www.google.com
${App.PageTitle}    Google

*** Keywords ***

App.Open
    [Arguments]    ${Browser.Alias}=default
    Run Keyword If    '${Selenium.Grid}'!='true'
    ...    Open Browser    ${App.Url}
    Run Keyword If    '${Selenium.Grid}'=='true'
    ...    Open Browser    ${App.GridUrl}
    Set Selenium Implicit Wait    ${Selenium.Timeout}
    Set Selenium Timeout    ${Selenium.Timeout}
#   
#   Initialize constants
#  
    ${ret}    Evaluate    ${Threshold} + 1   
    Set Suite Variable    ${AboveThreshold}    ${ret}   

    ${ret}    Evaluate    ${Threshold} - 1   
    Set Suite Variable    ${BelowThreshold}    ${ret}   
    App.Init

App.Init
    Delete All Cookies
    App.GoTo

    Log    Application initialized successfully.

App.GoTo
    ${Current.Location}=    Get Location
    Run Keyword If    '${Current.Location}'!='${App.Url}'
    ...    SeleniumLibrary.Go To    ${App.Url}
    Title Should Be    ${App.PageTitle}
    Log    Application opened successfully.

App.Close
    Close Browser
    Log    Application closed successfully.

App.Login
    [Arguments]    ${User ID}    ${User Password}

    No Operation

    Log    Log in was successful as user ${User ID}

App.Logout
    ${CustomerType}=    ${None}
    No Operation
    Log    Log out was successful.

