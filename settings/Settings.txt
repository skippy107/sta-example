*** Settings ***
Documentation     A resource file to setup all variables.
Resource          profiles/${Profile}.txt

*** Variables ***
${Profile}    Local
${Selenium.Browser.Name}    chrome
${Selenium.Browser.Version}    57
${Selenium.Timeout}        30.0
