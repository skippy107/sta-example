*** Settings ***
Documentation	World Indicators Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

*** Variables ***				
# smartphone test values
${SRC_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${TRG_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${SMART_SHEET}	 iPhone Bar
${SMART_PRIMARY}   Datatype
${SMART_PRIMARY_VALUE}   Cost ($)
${SMART_FILTER_COLUMN}    Component
${SMART_FILTER_VALUES}    Camera
${SMART_MARK_COLUMN}    Device
${SMART_MARK_VALUES}    ["Galaxy S 4","Galaxy S 5"]   
${SMART_MARK_NAME}    ATTR(DisplayValue)

*** Keywords ***			
Costs Test
    [Documentation]    This test will verify costs for a specific component and phone model

	Set Source Parameter ${SMART_PRIMARY} to ${SMART_PRIMARY_VALUE}  # there is only one parameter
	Switch To Source Sheet    ${SMART_SHEET}
	Set Source Filter    ${SMART_FILTER_COLUMN}    ${SMART_FILTER_VALUES}
	Select Source Marks    ${SMART_MARK_COLUMN}    ${SMART_MARK_VALUES}

	Set Target Parameter ${SMART_PRIMARY} to ${SMART_PRIMARY_VALUE}  # there is only one parameter
	Switch To Target Sheet    ${SMART_SHEET}
	Set Target Filter    ${SMART_FILTER_COLUMN}    ${SMART_FILTER_VALUES}
	Select Target Marks    ${SMART_MARK_COLUMN}    ${SMART_MARK_VALUES}

	Capture Page Screenshot

	${src_check} =	Sum Source Marks	${SMART_MARK_NAME}

	${trg_check} =	Sum Target Marks	${SMART_MARK_NAME}

	Should Be Equal As Numbers	${src_check}	${trg_check}

*** Test Cases ***
Smartphone Costs Test
    [Documentation]  This test case calls the Costs Test
	Costs Test
