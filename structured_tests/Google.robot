*** Settings ***
Suite Setup       Google.Site.Open
Suite Teardown    Google.Site.Close
Test Setup        Google.Site.Init
Resource          settings/Settings.resource
Resource          imports/Google.resource

*** Test Cases ***
Open And Close Google Site
    Capture Page Screenshot
    
Store Web Element In JavaScript
    Execute Javascript    window.document.my_element = window.document.getElementsByClassName('gsfi')[0];
    ${className}=    Execute Javascript    return window.document.my_element.className;
    Should Contain    ${className}    gsfi

Search Robotframework Selenium2Library
    Google.Search.Search String    Robotframework Selenium2Library Java
    
Search With JavaScript Locator
    SeleniumLibrary.Add Location Strategy    elementById    byID Locator Strategy
    Input Text    elementById=lst-ib    Robotframework Selenium2Library Java
    Press Key    elementById=lst-ib    \\13
    Wait Until Element Is Visible    xpath=//a[contains(.,'MarkusBernhardt')]
    Capture Page Screenshot
   
Search With JavaScript Locator Text
    SeleniumLibrary.Add Location Strategy    custom    ByValue Locator Strategy
    Wait Until Element Is Visible    custom=Google-Suche

Search Without Locator Type
    Input Text    lst-ib    Robotframework Selenium2Library Java
    Press Key    lst-ib    \\13
    Wait Until Element Is Visible    //a[contains(.,'MarkusBernhardt')]
    
Get Id Of Active Element With JavaScript
    Input Text    lst-ib    Robotframework Selenium2Library
    ${activeElementId}=    Execute JavaScript    return window.document.activeElement.id;

*** Keywords ***
ByValue Locator Strategy
    [Arguments]    ${browser}    ${criteria}    ${tag}    ${constraints}
    ${retVal}=    Execute Javascript    return window.document.evaluate("//*[contains(@value,'" + "${criteria}" + "')]", window.document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    [Return]    ${retVal}		

byID Locator Strategy
    [Arguments]    ${browser}    ${criteria}    ${tag}    ${constraints}
    ${retVal}=    Execute Javascript	return window.document.getElementById('${criteria}') || [];
    [Return]    ${retVal}		
