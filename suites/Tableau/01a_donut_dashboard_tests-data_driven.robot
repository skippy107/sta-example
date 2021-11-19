*** Settings ***
Documentation	Data Driven Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters read from an input file
...

Library     String
Library     Collections

Resource	resource/tableau.robot        # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

*** Variables ***				
${SETUP_FILE}    resource/donut_test_setup.tsv
${DATA_FILE}    resource/donut_test_data.tsv

*** Keywords ***			
Test Setup
    ${source}    ${target}=    Read Test Settings    ${SETUP_FILE}
	Set Suite Variable    ${SRC_URL}    ${source}
	Set Suite Variable    ${TRG_URL}    ${target}
	Load Dashboards

Dashboard Test
    [Documentation]    This generic test makes changes to source and target dashboards based on
	...                parameters passed
    [Arguments]    ${sheet}	${parameter}	${parameterValue}	${filterColumn}	${filterValue}	${filter2Column}	${filter2Value}	${markColumn}	${markValues}	${markName}

    # make settings to source
	Run Keyword If    '${parameter}' != ''     Set Source Parameter ${parameter} to ${parameterValue}
	Run Keyword If    '${sheet}' != ''    Switch To Source Sheet    ${sheet}
	Run Keyword If    '${filterColumn}' != ''    Set Source Filter    ${filterColumn}    ${filterValue}
	Run Keyword If    '${filter2Column}' != ''    Set Source Filter    ${filter2Column}    ${filter2Value}
	Run Keyword If    '${markColumn}' != ''    Select Source Marks    ${markColumn}    ${markValues}

    # make settings to target
	Run Keyword If    '${parameter}' != ''     Set Target Parameter ${parameter} to ${parameterValue}
	Run Keyword If    '${sheet}' != ''    Switch To Target Sheet    ${sheet}
	Run Keyword If    '${filterColumn}' != ''    Set Target Filter    ${filterColumn}    ${filterValue}
	Run Keyword If    '${filter2Column}' != ''    Set Target Filter    ${filter2Column}    ${filter2Value}
	Run Keyword If    '${markColumn}' != ''    Select Target Marks    ${markColumn}    ${markValues}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${markName}

	${trg_result} =	Sum Target Marks	${markName}

    Run Keyword and Continue on Failure    Should Be Equal As Numbers	${src_result}    ${trg_result}

*** Test Cases ***
Run Dashboard Tests
    [Tags]    donut     data-driven
    [Documentation]  This test case iterates through the test data file 
	...              and calls the Dashboard Test keyword for each row

    [Setup]    Test Setup
	[Teardown]    Unload Dashboards

    @{data}=      Read Test Data    ${DATA_FILE}
    FOR    ${line}    IN    @{data}
	        @{args}=    Split String    ${line}   separator=\t 
            Run Keyword and Continue on Failure    Dashboard Test    @{args}
	END

