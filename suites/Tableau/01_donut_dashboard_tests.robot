*** Settings ***
Documentation	Donut Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot        # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

Test Setup        Load Dashboards
Test Teardown        Unload Dashboards

*** Variables ***				
# donut test values
${SRC_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${TRG_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${SHEET}   Measure Per Donut

${PRIMARY_NUTRIENT}   Primary Nutrient
${ENERGY}   Energy
${CARBS}   Carbs (& Sugars)
${PROTEIN}   Protein
${DONUT}    Donut

${DONUT_LIST_1}    ["Original Glazed","Apple Pie"]   
${DONUT_LIST_2}    ["Festive Truffle","Caramel Crunch"]   
${DONUT_LIST_3}    ["Chocolate Custard","Strawberry Gloss"]   

${NUTRITION}    SUM(Energy, Fat, Protein, Fibre or Carbs)

*** Keywords ***			
Calorie Amounts Test
    [Documentation]    This test will verify calorie counts

    Set Source Parameter ${PRIMARY_NUTRIENT} to ${ENERGY}
	Switch To Source Sheet    ${SHEET}
	Select Source Marks       ${DONUT}    ${DONUT_LIST_1}

    Set Target Parameter ${PRIMARY_NUTRIENT} to ${ENERGY}
	Switch To Target Sheet    ${SHEET}
	Select Target Marks       ${DONUT}    ${DONUT_LIST_1}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${NUTRITION}

	${trg_result} =	Sum Target Marks	${NUTRITION}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target


Carbohydrate Amounts Test
    [Documentation]    This test will verify carbohydrate counts

    Set Source Parameter ${PRIMARY_NUTRIENT} to ${CARBS}
	Switch To Source Sheet    ${SHEET}
	Select Source Marks       ${DONUT}    ${DONUT_LIST_2}

    Set Target Parameter ${PRIMARY_NUTRIENT} to ${CARBS}
	Switch To Target Sheet    ${SHEET}
	Select Target Marks       ${DONUT}    ${DONUT_LIST_2}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${NUTRITION}

	${trg_result} =	Sum Target Marks	${NUTRITION}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target


Protein Amounts Test
    [Documentation]    This test will verify protein counts

    Set Source Parameter ${PRIMARY_NUTRIENT} to ${PROTEIN}
	Switch To Source Sheet    ${SHEET}
	Select Source Marks       ${DONUT}    ${DONUT_LIST_3}

    Set Target Parameter ${PRIMARY_NUTRIENT} to ${PROTEIN}
	Switch To Target Sheet    ${SHEET}
	Select Target Marks       ${DONUT}    ${DONUT_LIST_3}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${NUTRITION}

	${trg_result} =	Sum Target Marks	${NUTRITION}

    Run Keyword If    ${src_result} == 0 or ${trg_result} == 0
	    ...           Fail    No data available in one or both dashboards 

    Run Keyword If    ${src_result} != ${trg_result} and ${src_result} != 0 and ${trg_result} != 0  
	    ...           Fail    Data mismatch between source and target


*** Test Cases ***
Carbohydrate Test
    [Tags]    donut     keyword-driven    carbs
    [Documentation]  This test case calls the Carbohydrate Amounts Test
	Run Keyword and Continue on Failure    Carbohydrate Amounts Test

Calorie Test
    [Tags]    donut     keyword-driven    calorie    dev
    [Documentation]  This test case calls the Calorie Amounts Test
	Run Keyword and Continue on Failure    Calorie Amounts Test

Protein Test
    [Tags]    donut     keyword-driven    protein
    [Documentation]  This test case calls the Protein Amounts Test
	Run Keyword and Continue on Failure    Protein Amounts Test

	 

