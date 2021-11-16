*** Settings ***
Documentation	Tableau Dashboard Test Example Script
...
...             This suite of tests shows examples of how to navigate, filter, 
...             mark, and read a Tableau Dashboard.
...
...             Note that all Tableau tests will require a test fixture page
...             to be served from a local web server, such as Jenkins.

Resource	tableau.robot    # this library maps keywords to the Tableau JavaScript API

Suite Setup	Test Launch
Suite Teardown	Close Browser

*** Variables ***				
${TEST_FIXTURE_URL}	http://localhost:8080/userContent/tableau/fixture.html
${BROWSER}	chrome		
${SRC_VIZ_ID}	srcTableauViz
${TRG_VIZ_ID}	trgTableauViz

# donut test values
${DONUT_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${DONUT_SHEET}    Measure Per Donut
${DONUT_COLUMN}    Donut
${DONUT_PRIMARY}    Energy
${DONUT_MARK_NAME}    SUM(Energy, Fat, Protein, Fibre or Carbs)
${DONUT_MARK_VALUES}    ["Original Glazed","Apple Pie"]   # use array notation for more than one

# gdp test values
${WORLD_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${WORLD_SHEET}   GDP per capita
${WORLD_FILTER_COLUMN}    Region
${WORLD_FILTER2_COLUMN}    YEAR(Date (year))
${WORLD_FILTER_VALUES}    Europe
${WORLD_FILTER2_VALUES}    2008
${WORLD_MARK_COLUMN}   Country / Region 
${WORLD_MARK_VALUES}    Luxembourg
${WORLD_MARK_NAME}    AVG(F: GDP per capita (curr $))

# smartphone test values
${SMART_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${SMART_SHEET}	Components
${SMART_FILTER_COLUMN}    Component
${SMART_MARK_COLUMN}    Component
${SMART_FILTER}    Camera
${SMART_MARK_NAME}    SUM(Value)
${SMART_MARK_VALUES}    ["Galaxy S 4","Galaxy S 5"]   # use array notation for more than one

*** Keywords ***			
Donut Dashboard Test
	Load Source Dashboard    '${SRC_VIZ_ID}'    '${DONUT_URL}'
	Load Target Dashboard    '${TRG_VIZ_ID}'    '${DONUT_URL}'
	Sleep    7s
	Set Source Parameter 'Primary Nutrient' to '${DONUT_PRIMARY}'  # there is only one parameter
	Set Target Parameter 'Primary Nutrient' to '${DONUT_PRIMARY}'  # there is only one parameter
	Sleep    3s
	Set Source Marks on '${DONUT_COLUMN}' to ${DONUT_MARK_VALUES} on Sheet '${DONUT_SHEET}'
	Sleep    3s
	Set Target Marks on '${DONUT_COLUMN}' to ${DONUT_MARK_VALUES} on Sheet '${DONUT_SHEET}'
	Sleep    3s
	Capture Page Screenshot
	${src_check} =	Sum Source Marks	'${DONUT_MARK_NAME}'
	${src_result} =    Evaluate    ${src_check}/2    # Dashboard will also trigger marks, so must div/2
	${trg_check} =	Sum Target Marks	'${DONUT_MARK_NAME}'
	${trg_result} =    Evaluate    ${trg_check}/2    # Dashboard will also trigger marks, so must div/2
	Should Be Equal As Numbers	${src_result}    ${trg_result}
	Unload Source Dashboard
	Unload Target Dashboard

Smartphone Costs Dashboard Test
	Load Source Dashboard	'${SRC_VIZ_ID}'	'${SMART_URL}'
	Load Target Dashboard	'${TRG_VIZ_ID}'	'${SMART_URL}'
	Sleep	5
	Set Source Filter on ${SMART_FILTER_COLUMN} to '${SMART_FILTER}' on Sheet '${SMART_SHEET}'	
	Sleep	5
	Set Source Marks on '${SMART_MARK_COLUMN} to ${SMART_MARK_VALUES} on Sheet '${SMART_SHEET}'
	Sleep	5
	Set Target Filter on ${SMART_FILTER_COLUMN} to '${SMART_FILTER}' on Sheet '${SMART_SHEET}'	
	Sleep	5
	Set Target Marks on '${SMART_MARK_COLUMN} to ${SMART_MARK_VALUES} on Sheet '${SMART_SHEET}'
	Sleep	5
	Capture Page Screenshot
	${src_check} =	Sum Source Marks	'${SMART_MARK_NAME}'
	${trg_check} =	Sum Target Marks	'${SMART_MARK_NAME}'
	Should Be Equal As Numbers	${src_check}	${trg_check}
	Unload Source Dashboard
	Unload Target Dashboard
								
World Indicators Dashboard Test
	Load Source Dashboard	'${SRC_VIZ_ID}'	'${WORLD_URL}'
	Load Target Dashboard	'${TRG_VIZ_ID}'	'${WORLD_URL}'
	Sleep	5
	Set Source Filter on '${WORLD_FILTER_COLUMN}' to '${WORLD_FILTER_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3
	Set Source Filter on '${WORLD_FILTER2_COLUMN}' to '${WORLD_FILTER2_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3		
	Set Source Marks on '${WORLD_MARK_COLUMN}' to '${WORLD_MARK_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3		
	Set Target Filter on '${WORLD_FILTER_COLUMN}' to '${WORLD_FILTER_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3
	Set Target Filter on '${WORLD_FILTER2_COLUMN}' to '${WORLD_FILTER2_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3		
	Set Target Marks on '${WORLD_MARK_COLUMN}' to '${WORLD_MARK_VALUES}' on Sheet '${WORLD_SHEET}'
	Sleep	3		
	Capture Page Screenshot
	${src_check} =	Sum Source Marks	'${WORLD_MARK_NAME}'
	${trg_check} =	Sum Target Marks	'${WORLD_MARK_NAME}'
	Should Be Equal As Numbers	${src_check}	${trg_check}
	Unload Source Dashboard
	Unload Target Dashboard


Test Launch				
	Set Selenium Timeout	10	
	Set Selenium Implicit Wait	10
	Open Browser	${TEST_FIXTURE_URL}	 ${BROWSER}
	Maximize Browser Window

*** Test Cases ***
First Test
	Donut Dashboard Test

#Second Test
#	Smartphone Costs Dashboard Test

#Third Test
#	World Indicators Dashboard Test

