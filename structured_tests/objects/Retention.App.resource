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
    Run Keyword If    '${Selenium.Grid}'!='true'    Open Browser    ${App.Url}
    Run Keyword If    '${Selenium.Grid}'=='true'    Open Browser    ${App.GridUrl}
    Set Selenium Implicit Wait    ${Selenium.Timeout}
    Set Selenium Timeout    ${Selenium.Timeout}
    App.Init

App.Init
    Delete All Cookies
    App.GoTo
    Log    Application initialized successfully.

App.GoTo
    ${Current.Location}=    Get Location
    Run Keyword If    '${Current.Location}'!='${App.Url}'    SeleniumLibrary.Go To    ${App.Url}
    Title Should Be    ${App.PageTitle}
    Log    Application opened successfully.

App.Close
    Close Browser
    Log    Application closed successfully.

App.Login
    [Arguments]    ${UserID}    ${UserPassword}
#   Assuming browser is open on the login page
#   Input Text    ${Username TextBox ID}    ${UserID}
#   Input Text    ${Password TextBox ID}    ${UserPassword}
#   Click Button    ${Login Button ID}
#   Wait Until Page Contains    ${Home Menu ID}
    No Operation
    Log    Log in was successful.

App.Logout
#   Assuming there is an active session
#   Click Button    ${Logout Button ID}
#   Wait Until Page Contains    ${Signoff Label ID}
    No Operation
    Log    Log out was successful.

