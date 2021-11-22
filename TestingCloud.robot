*** Settings ***

Library  SeleniumLibrary

*** Variables ***

@{_tmp} 
    ...  browserName: Chrome,
    ...  platform: Windows 10,
    ...  version: latest,
    ...  username: %{SAUCE_USERNAME},
    ...  accessKey: %{SAUCE_ACCESS_KEY},
    ...  name: ${SUITE_NAME},
    ...  build: My-Selenium-Robot-Test

${browser}          Chrome
${capabilities}     ${EMPTY.join(${_tmp})} 
${remote_url}       https://ondemand.saucelabs.com/wd/hub

*** Keywords ***

Open Test App
    Open browser  https://www.saucedemo.com  browser=${browser}
    ...  remote_url=${remote_url}
    ...  desired_capabilities=${capabilities}


*** Test Cases ***

Verify Connection
    Open Test App

    Title Should Be  Swag Labs

    [Teardown]  Close Browser
