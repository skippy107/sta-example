*** Settings ***
Documentation	Donut Dashboard Test Example
...
...             This test shows how to compare a source and target version of a dashboard
...             after setting different filters and parameters
...

Resource	resource/tableau.robot        # this library maps keywords to the Tableau JavaScript API
Resource	resource/setup.resource       # this library contains the keyword definitions for Test setup and teardowns

*** Variables ***				
# donut test values
${SRC_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${TRG_URL}    https://public.tableau.com/views/DonutDashboard/DonutDashboard
${DONUT_SHEET}   Measure Per Donut
${DONUT_PRIMARY}   Primary Nutrient
${DONUT_PRIMARY_VALUE}   Energy
${DONUT_PRIMARY_VALUE2}   Fibre
${DONUT_PRIMARY_VALUE3}   Protein
${DONUT_MARK_COLUMN}    Donut
${DONUT_MARK_VALUES}    ["Original Glazed","Apple Pie"]   
${DONUT_MARK_NAME}    SUM(Energy, Fat, Protein, Fibre or Carbs)

*** Keywords ***			
Calorie Amounts Test
    [Documentation]    This test will verify calorie counts

    Set Source Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE}
	Switch To Source Sheet    ${DONUT_SHEET}
	Select Source Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

    Set Target Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE}
	Switch To Target Sheet    ${DONUT_SHEET}
	Select Target Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${DONUT_MARK_NAME}

	${trg_result} =	Sum Target Marks	${DONUT_MARK_NAME}

	Should Be Equal As Numbers	${src_result}    ${trg_result}

Fibre Amounts Test
    [Documentation]    This test will verify fibre counts

    Set Source Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE2}
	Switch To Source Sheet    ${DONUT_SHEET}
	Select Source Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

    Set Target Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE2}
	Switch To Target Sheet    ${DONUT_SHEET}
	Select Target Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${DONUT_MARK_NAME}

	${trg_result} =	Sum Target Marks	${DONUT_MARK_NAME}

	Should Be Equal As Numbers	${src_result}    ${trg_result}

Protein Amounts Test
    [Documentation]    This test will verify protein counts

    Set Source Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE3}
	Switch To Source Sheet    ${DONUT_SHEET}
	Select Source Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

    Set Target Parameter ${DONUT_PRIMARY} to ${DONUT_PRIMARY_VALUE3}
	Switch To Target Sheet    ${DONUT_SHEET}
	Select Target Marks       ${DONUT_MARK_COLUMN}    ${DONUT_MARK_VALUES}

	Capture Page Screenshot

	${src_result} =	Sum Source Marks	${DONUT_MARK_NAME}

	${trg_result} =	Sum Target Marks	${DONUT_MARK_NAME}

	Should Be Equal As Numbers	${src_result}    ${trg_result}

*** Test Cases ***
Fibre Test
    [Documentation]  This test case calls the Fibre Amounts Test
    [Teardown]    Revert Dashboards
	Fibre Amounts Test

Calorie Test
    [Documentation]  This test case calls the Calorie Amounts Test
    [Setup]    ${NONE}
    [Teardown]    Revert Dashboards
	Calorie Amounts Test

Protein Test
    [Documentation]  This test case calls the Protein Amounts Test
    [Setup]    ${NONE}
	Protein Amounts Test

	 

