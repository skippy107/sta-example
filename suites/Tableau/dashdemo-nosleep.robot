*** Settings ***
Documentation	Tableau Dashboard Test Example Script
...
...             This suite of tests shows examples of how to navigate, filter, 
...             mark, and read a Tableau Dashboard.
...
...             Note that all Tableau tests will require a test fixture page
...             to be served from a local web server, such as Jenkins.

Resource	tableau.robot    # this library maps keywords to the Tableau JavaScript API

Suite Setup    Test Launch
Suite Teardown    Close Browser

Test Setup    Go To    ${TEST_FIXTURE_URL}

*** Variables ***				
${TEST_FIXTURE_URL}	http://localhost:8080/userContent/fixture.html
${BROWSER}	chrome		
${VIZ_ID}	tableauViz

# donut test values
${DONUT_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${DONUT_SHEET}    Measure Per Donut
${DONUT_COLUMN}    Donut
${DONUT_PRIMARY}    Energy
${DONUT_MARK_NAME}    SUM(Energy, Fat, Protein, Fibre or Carbs)
${DONUT_MARK_VALUES}    ["Original Glazed","Apple Pie"]   # use array notation for more than one
${DONUT_TOTAL}    3420

# smartphone test values
${SMART_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${SMART_SHEET}    iPhone Bar
${SMART_FILTER_COLUMN}    Component
${SMART_FILTER}    Camera
${SMART_MARK_COLUMN}    Device
${SMART_MARK_NAME}    SUM(Value)
${SMART_MARK_VALUES}    ["Galaxy S 4","Galaxy S 5"]   # use JS array notation for more than one
${SMART_TOTAL}    39.77

# gdp test values
${WORLD_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${WORLD_SHEET}   GDP per capita

*** Keywords ***			
Donut Dashboard Test
	Load Dashboard    '${VIZ_ID}'    '${DONUT_URL}'
	Set Parameter 'Primary Nutrient' to '${DONUT_PRIMARY}'  # there is only one parameter
	Set Marks on '${DONUT_COLUMN}' to ${DONUT_MARK_VALUES} on Sheet '${DONUT_SHEET}'
	Sleep    5s
	Capture Page Screenshot
	${check} =	Sum Marks	'${DONUT_MARK_NAME}'
	Should Be Equal As Numbers	${check}    ${DONUT_TOTAL}
	Unload Dashboard

Smartphone Costs Dashboard Test
	Load Dashboard	'${VIZ_ID}'	'${SMART_URL}'
	Set Filter on '${SMART_FILTER_COLUMN}' to '${SMART_FILTER}' on Sheet '${SMART_SHEET}'	
	Set Marks on '${SMART_MARK_COLUMN}' to ${SMART_MARK_VALUES} on Sheet '${SMART_SHEET}'
	Capture Page Screenshot
	${check} =	Sum Marks	'${SMART_MARK_NAME}'
	Should Be Equal As Numbers	${check}	39.77
	Unload Dashboard
								
World Indicators Dashboard Test
	Load Dashboard	'${VIZ_ID}'	'${WORLD_URL}'
	Set Filter on 'YEAR(Date (year))' to 2008 on Sheet 'GDP per capita'
	Set Filter on 'Region' to 'Europe' on Sheet 'GDP per capita'
	Set Marks on 'Country / Region' to 'Luxembourg' on Sheet 'GDP per capita'
	Capture Page Screenshot
	${check} =	Sum Marks	'AVG(F: GDP per capita (curr $))'
	Should Be Equal As Numbers	${check}	118219
	Unload Dashboard


Test Launch				
	Set Selenium Timeout	10	
	Set Selenium Implicit Wait	10
	Open Browser	${TEST_FIXTURE_URL}	${BROWSER}
	Maximize Browser Window

*** Test Cases ***
First Test
	Donut Dashboard Test

Second Test
	Smartphone Costs Dashboard Test

Third Test
	World Indicators Dashboard Test

