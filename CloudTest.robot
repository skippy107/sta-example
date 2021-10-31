*** Settings ***

Library  Selenium2Library
Library  SauceLabs

Test Setup  Open test browser
Test Teardown  Close test browser

*** Variables ***
${UID}
${KEY}

${BROWSER}  chrome
${REMOTE_URL}  http://${UID}:${KEY}@ondemand.saucelabs.com:80/wd/hub

${DESIRED_CAPABILITIES}  browserName:chrome,version:57

${LOGIN_FAIL_MSG}  Invalid username or password

*** Test Cases ***

Incorrect username or password
    [Tags]  Login
    Go to  https://saucelabs.com/login

    Page Should Contain Element  name=username
    Page Should Contain Element  name=password

    Input text  name=username  Notanonymous
    Input text  name=password  secret

    Click button  id=submit

    Wait Until Page Contains  ${LOGIN_FAIL_MSG}

*** Keywords ***

Open test browser
    Open browser  about:  ${BROWSER}
    ...  remote_url=${REMOTE_URL}
    ...  desired_capabilities=${DESIRED_CAPABILITIES}

Close test browser
    Run keyword if  '${REMOTE_URL}' != ''
    ...  Report Sauce status
    ...  ${SUITE_NAME} | ${TEST_NAME}
    ...  ${TEST_STATUS}  ${TEST_TAGS}  ${REMOTE_URL}
    Close all browsers

