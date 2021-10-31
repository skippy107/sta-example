*** Settings ***

Documentation     Test settings for the ${SUITE NAME} test suite
#
# The settings file includes the global variables used by any test 
# cases in the current test suite
#
#  Variable Naming Conventions
#
#  ALL CAPS           Robot Framework variable
#  TitleCaseNoSpaces  Suite level variable
#  Title Case Spaces  Keyword Argument
#  lowercase          Keyword level variable
#

#
# Optionally you can import specific settings based on a specific value
#
#Resource          profiles/${Profile}.txt  ## Profile variable defined below
#

*** Variables ***
#
#${Profile}    Local   ## Other profile choices might be Remote, Sandbox, etc.

${CustomerType}    None

${ItemNumberOfSomeBook}    12345678-908765

${Threshold}    10
${AboveThreshold}    11
${BelowThreshold}    9

#
# Credentials
 
${RegUsername}    RegUser
${RegPassword}    RegPassword

${VIPUsername}    VIPUser
${VIPPassword}    VIPPassword

# Custom browser Settings for this test suite
#
${Selenium.Timeout}        30.0


