*** Settings ***
Documentation	Smartphone Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

Test Setup        Load Dashboards
Test Teardown        Unload Dashboards


*** Variables ***				
# smartphone test values
${SRC_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${TRG_URL}	https://public.tableau.com/views/SmartphoneCostBreakdown/Overview
${SHEET}	 iPhone Bar

${DATATYPE}   Datatype
${COST}   Cost ($)
${COMPONENT}    Component
${DEVICE}    Device

${CAMERA}    Camera
${DEVICE_LIST_1}    ["Galaxy S 4","Galaxy S 5"]   

${ELECTRONICS}    ["Core Electronics","Memory"]
${DEVICE_LIST_2}    ["iPhone 5S","iPhone 6"]   

${SENSORS}    ["Power","Sensors"]
${DEVICE_LIST_3}    ["iPhone 3G","iPhone 3GS"]   

${TOTAL_COST}    ATTR(DisplayValue)

*** Keywords ***			
Camera Costs
    [Documentation]    This keyword will verify camera costs for specific phone models

	Set Source Parameter ${DATATYPE} to ${COST}
	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${COMPONENT}    ${CAMERA}
	Select Source Marks    ${DEVICE}    ${DEVICE_LIST_1}

	Set Target Parameter ${DATATYPE} to ${COST}
	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${COMPONENT}    ${CAMERA}
	Select Target Marks    ${DEVICE}    ${DEVICE_LIST_1}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${TOTAL_COST}

	${trg_result} =	Sum Target Marks	${TOTAL_COST}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target


Electronics Costs
    [Documentation]    This keyword will verify electronics for specific phone models

	Set Source Parameter ${DATATYPE} to ${COST}
	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${COMPONENT}    ${ELECTRONICS}
	Select Source Marks    ${DEVICE}    ${DEVICE_LIST_2}

	Set Target Parameter ${DATATYPE} to ${COST}
	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${COMPONENT}    ${ELECTRONICS}
	Select Target Marks    ${DEVICE}    ${DEVICE_LIST_2}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${TOTAL_COST}

	${trg_result} =	Sum Target Marks	${TOTAL_COST}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target

Sensor Costs
    [Documentation]    This keyword will verify sensor costs for specific phone models

	Set Source Parameter ${DATATYPE} to ${COST}
	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${COMPONENT}    ${SENSORS}
	Select Source Marks    ${DEVICE}    ${DEVICE_LIST_3}

	Set Target Parameter ${DATATYPE} to ${COST}
	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${COMPONENT}    ${SENSORS}
	Select Target Marks    ${DEVICE}    ${DEVICE_LIST_3}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${TOTAL_COST}

	${trg_result} =	Sum Target Marks	${TOTAL_COST}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target


*** Test Cases ***
Camera Test
    [Tags]    smartphone     keyword-driven     camera
    [Documentation]  This test case calls the Camera Costs keyword
	Run Keyword and Continue on Failure    Camera Costs
Electronics Test
    [Tags]    smartphone     keyword-driven     electronics
    [Documentation]  This test case calls the Electronics Costs keyword
	Run Keyword and Continue on Failure    Electronics Costs
Sensor Test
    [Tags]    smartphone     keyword-driven     sensor
    [Documentation]  This test case calls the Sensor Costs keyword
	Run Keyword and Continue on Failure    Sensor Costs
