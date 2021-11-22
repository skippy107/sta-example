*** Settings ***

Resource    ../adapters/SeleniumLibrary.resource

Documentation     Defines all resources and keywords 
...               handling web based application object
...
...    For example purposes, some web driver commands are commented out
...  

*** Variables ***

${App.Url}    http://www.google.com
${App.GridUrl}    http://www.google.de
${App.PageTitle}    Google

*** Keywords ***

Open
    Open Browser    ${App.Url}

    App.Init

Init
    Delete All Cookies
    Get Variable Value    ${Selenium.Timeout}   30
    Set Selenium Implicit Wait    ${Selenium.Timeout}
    Set Selenium Timeout    ${Selenium.Timeout}
    App.GoTo
    Log    Application initialized successfully.

GoTo
    ${currentloc}=    Get Location
    Run Keyword If    '${currentloc}'!='${App.Url}'
    ...    SeleniumLibrary.Go To    ${App.Url}
    Title Should Be    ${App.PageTitle}
    Log    Application opened successfully.

Close
    Close Browser
    Log    Application closed successfully

Login
    [Arguments]    ${User ID}    ${User Password}
    No Operation
    Log    TODO: Implementation of App.Login for ${SUITE NAME}

Logout
    No Operation
    Log    TODO: Implementation of App.Logout for ${SUITE NAME}

