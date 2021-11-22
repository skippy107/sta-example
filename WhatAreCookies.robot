*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Cookies
    Open Browser    http://www.whatarecookies.com/cookietest.asp    firefox    mainbrowser
    ${all_cookies}=    Get Cookies
    ${test}=    Get Cookie    __atuvc
    Close Browser 