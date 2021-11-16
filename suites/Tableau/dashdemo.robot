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
${DONUT_SHEET}   Measure Per Donut
${DONUT_PRIMARY}   Primary Nutrient
${DONUT_PRIMARY_VALUE}   Energy
${DONUT_MARK_COLUMN}    Donut
${DONUT_MARK_NAME}    SUM(Energy, Protein, Fat, Fibre or Carbs)
${DONUT_MARK_VALUES}    ["Original Glazed","Apple Pie"]   # use array notation for more than one

# gdp test values
${WORLD_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${WORLD_SHEET}   GDP per capita
${WORLD_FILTER_COLUMN}    Region
${WORLD_FILTER_VALUES}    Europe
${WORLD_FILTER2_COLUMN}    YEAR(Date (year))
${WORLD_FILTER2_VALUES}    ${2008}
${WORLD_MARK_COLUMN}   Country / Region 
${WORLD_MARK_VALUES}    Luxembourg
${WORLD_MARK_NAME}    AVG(F: GDP per capita (curr $))

# smartphone test values
${SMART_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${SMART_SHEET}	 iPhone Bar
${SMART_FILTER_COLUMN}    Component
${SMART_FILTER_VALUES}    Camera
${SMART_MARK_COLUMN}    Device
${SMART_MARK_VALUES}    ["Galaxy S 4","Galaxy S 5"]   # use array notation for more than one
${SMART_MARK_NAME}    ATTR(DisplayValue)

*** Keywords ***			
Donut Dashboard Test
	Load Source Dashboard    '${SRC_VIZ_ID}'    '${DONUT_URL}'
	Load Target Dashboard    '${TRG_VIZ_ID}'    '${DONUT_URL}'

    Set Source Parameter '${DONUT_PRIMARY}' to '${DONUT_PRIMARY_VALUE}'
    Switch To Source Sheet    '${DONUT_SHEET}'
	Select Source Marks  '${DONUT_MARK_COLUMN}'  ${DONUT_MARK_VALUES} 

    Set Target Parameter '${DONUT_PRIMARY}' to '${DONUT_PRIMARY_VALUE}'
    Switch To Target Sheet    '${DONUT_SHEET}'
	Select Target Marks  '${DONUT_MARK_COLUMN}'  ${DONUT_MARK_VALUES} 

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	'${DONUT_MARK_NAME}'

	${trg_result} =	Sum Target Marks	'${DONUT_MARK_NAME}'

	Should Be Equal As Numbers	${src_result}    ${trg_result}

	Unload Source Dashboard
	Unload Target Dashboard

Smartphone Costs Dashboard Test
	Load Source Dashboard	'${SRC_VIZ_ID}'	'${SMART_URL}'
	Load Target Dashboard	'${TRG_VIZ_ID}'	'${SMART_URL}'

	Set Source Filter on '${SMART_FILTER_COLUMN}' to '${SMART_FILTER_VALUES}' on Sheet '${SMART_SHEET}'	
	Set Source Parameter 'Datatype' to 'Cost ($)'  # there is only one parameter
	Set Source Marks on '${SMART_MARK_COLUMN}' to ${SMART_MARK_VALUES} on Sheet '${SMART_SHEET}'

	Set Target Filter on '${SMART_FILTER_COLUMN}' to '${SMART_FILTER_VALUES}' on Sheet '${SMART_SHEET}'	
	Set Target Parameter 'Datatype' to 'Cost ($)'  # there is only one parameter
	Set Target Marks on '${SMART_MARK_COLUMN}' to ${SMART_MARK_VALUES} on Sheet '${SMART_SHEET}'

	Capture Page Screenshot

	${src_check} =	Sum Source Marks	'${SMART_MARK_NAME}'

	${trg_check} =	Sum Target Marks	'${SMART_MARK_NAME}'

	Should Be Equal As Numbers	${src_check}	${trg_check}

	Unload Source Dashboard
	Unload Target Dashboard
								
World Indicators Dashboard Test
	Load Source Dashboard	'${SRC_VIZ_ID}'	'${WORLD_URL}'
	Load Target Dashboard	'${TRG_VIZ_ID}'	'${WORLD_URL}'

	Set Source Filter on '${WORLD_FILTER_COLUMN}' to '${WORLD_FILTER_VALUES}' on Sheet '${WORLD_SHEET}'
	Set Source Filter on '${WORLD_FILTER2_COLUMN}' to ${WORLD_FILTER2_VALUES} on Sheet '${WORLD_SHEET}'
	Set Source Marks on '${WORLD_MARK_COLUMN}' to '${WORLD_MARK_VALUES}' on Sheet '${WORLD_SHEET}'

	Set Target Filter on '${WORLD_FILTER_COLUMN}' to '${WORLD_FILTER_VALUES}' on Sheet '${WORLD_SHEET}'
	Set Target Filter on '${WORLD_FILTER2_COLUMN}' to ${WORLD_FILTER2_VALUES} on Sheet '${WORLD_SHEET}'
	Set Target Marks on '${WORLD_MARK_COLUMN}' to '${WORLD_MARK_VALUES}' on Sheet '${WORLD_SHEET}'

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

Second Test
	Smartphone Costs Dashboard Test

Third Test
	World Indicators Dashboard Test

