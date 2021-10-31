*** Settings ***

Documentation     Custom Variables for the Delivery tests
...
...    This file shows how to programmatically include a resource file
...    by defining the file name in a variable.
...

Resource          profiles/${Profile}.txt

*** Variables ***

# Delivery Test Variables

${CustomerType}    None
#
# Credentials
#
${RegUsername}    RegUser
${RegPassword}    RegPassword

${VIPUsername}    VIPUser
${VIPPassword}    VIPPassword

# Test Criteria Constants 
#
${ItemNumberOfSomeBook}    12345678-908765

${Threshold}    ${10}
${AboveThreshold}    ${10}
${BelowThreshold}    ${10}

# Support for different profiles - Local, Remote, Cloud 
#
${Profile}    Local

# Browser Settings
#
${Selenium.Browser.Name}    chrome
${Selenium.Browser.Version}    57
${Selenium.Timeout}        30.0


