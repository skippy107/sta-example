*** Settings ***
Documentation	Setup and Teardown Keywords for Tableau tests

Library     OperatingSystem
Library     String
Library     Collections

Resource	../resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API

*** Variables ***
${TEST_FIXTURE_URL}	http://localhost:8080/userContent/tableau/fixture.html
${BROWSER}	 chrome		
${SRC_VIZ_ID}	srcTableauViz
${TRG_VIZ_ID}	trgTableauViz

# Operating System uses the root Robot Folder regardless of what folder the test starts in
# use this variable to set the relative path correctly
${FILE_PREFIX}    tests/tableau/

*** Keywords ***
Suite Launch				
    [Documentation]     Opens the browser and sets Selenium timeouts for all tests
	Set Selenium Timeout	10	
	Set Selenium Implicit Wait	10
	Open Browser	${TEST_FIXTURE_URL}    ${BROWSER}
	Maximize Browser Window

Unload Dashboards
    [Documentation]     Unloads all dashboards
	Unload Source Dashboard
	Unload Target Dashboard

Load Dashboards
    [Documentation]     Navigates to the test fixture and loads all dashboards
    Go To    ${TEST_FIXTURE_URL}
	Load Source Dashboard    ${SRC_VIZ_ID}    ${SRC_URL}
	Load Target Dashboard    ${TRG_VIZ_ID}    ${TRG_URL}

Revert Dashboards
    [Documentation]     Reverts all dashboards to default view
    Source Revert All
	Target Revert All

Read Test Data
    [Documentation]     Reads test data from [${filename}] and returns a list with the file contents
    [Arguments]    ${filename}
    ${contents}=   Get File    ${FILE_PREFIX}${filename}
    @{data}=      Split to lines    ${contents}
	# remove header row from data
	Remove From List    ${data}    0
	[Return]    @{data}

Read Test Settings
    [Documentation]     Reads test settings from [${filename}] and returns the settings in separate variables
    [Arguments]    ${filename}
    ${contents}=   Get File    ${FILE_PREFIX}${filename}
    @{data}=      Split to lines    ${contents}
	# remove header row from data
	Remove From List    ${data}    0
	FOR    ${line}    IN    @{data}
	        ${pre}    ${post}=    Split String    ${line}    separator=\t
	END
	[Return]    ${pre}    ${post}