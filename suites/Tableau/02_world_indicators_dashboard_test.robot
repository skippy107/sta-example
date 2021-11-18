*** Settings ***
Documentation	World Indicators Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

*** Variables ***				
# gdp test values
${SRC_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${TRG_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${WORLD_SHEET}   GDP per capita
${WORLD_FILTER_COLUMN}    Region
${WORLD_FILTER_VALUES}    Europe
${WORLD_FILTER2_COLUMN}    YEAR(Date (year))
${WORLD_FILTER2_VALUES}    ${2008}  # needs this notation to be interpreted as a number
${WORLD_MARK_COLUMN}   Country / Region 
${WORLD_MARK_VALUES}    Luxembourg
${WORLD_MARK_NAME}    AVG(F: GDP per capita (curr $))

*** Keywords ***			
GDP Test
    [Documentation]    This test will verify GDP for a specific country and year

	Switch To Source Sheet    ${WORLD_SHEET}
	Set Source Filter    ${WORLD_FILTER_COLUMN}    ${WORLD_FILTER_VALUES}
	Sleep    1s
	Set Source Filter    ${WORLD_FILTER2_COLUMN}      ${WORLD_FILTER2_VALUES}
	Select Source Marks    ${WORLD_MARK_COLUMN}    ${WORLD_MARK_VALUES}

	Switch To Target Sheet    ${WORLD_SHEET}
	Set Target Filter    ${WORLD_FILTER_COLUMN}    ${WORLD_FILTER_VALUES}
	Sleep    1s
	Set Target Filter    ${WORLD_FILTER2_COLUMN}      ${WORLD_FILTER2_VALUES}
	Select Target Marks   ${WORLD_MARK_COLUMN}     ${WORLD_MARK_VALUES}

	Capture Page Screenshot

	${src_check} =	Sum Source Marks	${WORLD_MARK_NAME}

	${trg_check} =	Sum Target Marks	${WORLD_MARK_NAME}

	Should Be Equal As Numbers	${src_check}	${trg_check}

*** Test Cases ***
GDP Indicator Test
    [Documentation]  This test case calls the GDP Test
	GDP Test

