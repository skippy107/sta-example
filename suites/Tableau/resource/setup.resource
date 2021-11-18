*** Settings ***
Documentation	Setup and Teardown Keywords for Tableau tests

Resource	../resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API

*** Variables ***
${TEST_FIXTURE_URL}	http://localhost:8080/userContent/tableau/fixture.html
${BROWSER}	 chrome		
${SRC_VIZ_ID}	srcTableauViz
${TRG_VIZ_ID}	trgTableauViz

*** Keywords ***
Test Launch				
	Set Selenium Timeout	10	
	Set Selenium Implicit Wait	10
	Open Browser	${TEST_FIXTURE_URL}	 ${BROWSER}
	Maximize Browser Window

Unload Dashboards
	Unload Source Dashboard
	Unload Target Dashboard

Load Dashboards
	Load Source Dashboard    ${SRC_VIZ_ID}    ${SRC_URL}
	Load Target Dashboard    ${TRG_VIZ_ID}    ${TRG_URL}

Revert Dashboards
    Source Revert All
	Target Revert All
