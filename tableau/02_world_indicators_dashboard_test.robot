*** Settings ***
Documentation	World Indicators Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot    # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

Test Setup        Load Dashboards
Test Teardown        Unload Dashboards

*** Variables ***				
# gdp test values
${SRC_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${TRG_URL}	https://public.tableau.com/views/WorldIndicators/GDPpercapita
${SHEET}   GDP per capita
${REGION}    Region
${YEAR}    YEAR(Date (year))
${COUNTRY_REGION}   Country / Region 

${REGION_LIST_1}    Europe
${YEAR_LIST_1}    2008
${COUNTRY_REGION_LIST_1}    ["Luxembourg","Italy"]

${REGION_LIST_2}    Asia
${YEAR_LIST_2}    [2004,2008]
${COUNTRY_REGION_LIST_2}    ["Japan","Singapore"]

${REGION_LIST_3}    The Americas
${YEAR_LIST_3}    2002
${COUNTRY_REGION_LIST_3}    ["Bermuda","United States"]

${GDP_PER_CAPITA}    AVG(F: GDP per capita (curr $))

*** Keywords ***			
Europe GDP
    [Documentation]    This test will verify Europe GDP for a specific country and year

	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${REGION}    ${REGION_LIST_1}
	Set Source Filter    ${YEAR}      ${YEAR_LIST_1}
	Select Source Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_1}

	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${REGION}    ${REGION_LIST_1}
	Set Target Filter    ${YEAR}      ${YEAR_LIST_1}
	Select Target Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_1}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${GDP_PER_CAPITA}

	${trg_result} =	Sum Target Marks	${GDP_PER_CAPITA}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target

Asia GDP
    [Documentation]    This test will verify Asia GDP for a specific country and year

	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${REGION}    ${REGION_LIST_2}
	Set Source Filter    ${YEAR}      ${YEAR_LIST_2}
	Select Source Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_2}

	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${REGION}    ${REGION_LIST_2}
	Set Target Filter    ${YEAR}      ${YEAR_LIST_2}
	Select Target Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_2}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${GDP_PER_CAPITA}

	${trg_result} =	Sum Target Marks	${GDP_PER_CAPITA}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target

Americas GDP
    [Documentation]    This test will verify Americas GDP for a specific country and year

	Switch To Source Sheet    ${SHEET}
	Set Source Filter    ${REGION}    ${REGION_LIST_3}
	Set Source Filter    ${YEAR}      ${YEAR_LIST_3}
	Select Source Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_3}

	Switch To Target Sheet    ${SHEET}
	Set Target Filter    ${REGION}    ${REGION_LIST_3}
	Set Target Filter    ${YEAR}      ${YEAR_LIST_3}
	Select Target Marks    ${COUNTRY_REGION}    ${COUNTRY_REGION_LIST_3}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${GDP_PER_CAPITA}

	${trg_result} =	Sum Target Marks	${GDP_PER_CAPITA}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target

*** Test Cases ***
Europe GDP Indicator Test
    [Tags]    gdp     eruope    keyword-driven
    [Documentation]  This test case calls the Europe GDP Keyword
	Run Keyword and Continue on Failure    Europe GDP

Asia GDP Indicator Test
    [Tags]    gdp     asia    keyword-driven
    [Documentation]  This test case calls the Asia GDP Keyword
	Run Keyword and Continue on Failure    Asia GDP

Americas GDP Indicator Test
    [Tags]    gdp     americas    keyword-driven
    [Documentation]  This test case calls the Americas GDP Keyword
	Run Keyword and Continue on Failure    Americas GDP

