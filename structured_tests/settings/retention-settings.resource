*** Settings ***

Documentation     Custom Variables for the Retention Prospects tests
...
...    This file shows how to programmatically include a resource file
...    by defining the file name in a variable.
...

Resource          profiles/${Profile}.txt

*** Variables ***

# Retention Prospect Test Variables
#
# Credentials
#
${Username}    TestUser
${Password}    TestPassword

# Test Criteria Constants 
#
${NewID}    NEW
${EnrolledSeasonalID}    ID-012345
${EnrolledProspectID}    ID-678901

# Support for different profiles - Local, Remote 
#
${Profile}    Local

# Browser Settings
#
${Selenium.Browser.Name}    chrome
${Selenium.Browser.Version}    57
${Selenium.Timeout}        30.0


