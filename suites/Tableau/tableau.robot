*** Settings ***
Documentation	Tableau Keyword Library
Library	SeleniumLibrary
#Library	Screenshot

				
*** Keywords ***
Tableau Ready
    ${tr} =    Execute Javascript    return tbusy;
    Should Not Be Equal    ${tr}    ${TRUE}
    [Return]    not ${tr}

Load Dashboard
	[Arguments]	${eid}	${url}
	Execute Javascript	if (!viz) {initializeViz(${eid},${url}); listenToMarksSelection();}
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Old Load Dashboard
	[Arguments]	${eid}	${url}
	Execute Javascript	if (!viz) {initializeViz(${eid},${url}); listenToMarksSelection()};

Unload Dashboard
	Execute Javascript	removeMarksSelectionEventListener(); viz.dispose();viz = false; 

Switch To Sheet
	[Arguments]	${sheet}
	Execute Javascript	switchToSheet(${sheet});

Set Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	filterValue(${filter},${value});

Add To Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	addValueToFilter(${filter},${value});

Filter Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	filterRangeOfValues(${filter},${range});

Remove From Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	removeValueFromFilter(${filter},${value});

Clear Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	Execute Javascript	clearFilter(${filter});

Select Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	selectValue(${filter},${value});

Add Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	addValueToSelection(${filter},${value});

Remove Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	removeFromSelection(${filter},${value});

Clear Marks				
	Execute Javascript	clearSelection();

Sum Marks				
	[Arguments]	${field}
	${result}=	Execute Javascript	return totalSelectedMarks(${field});
	[Return]	${result}

Set Parameter ${parameter_name} to ${parameter_value}
	Execute Javascript   workbook.changeParameterValueAsync(${parameter_name},${parameter_value}).then(console.log("parameter changed."));
	Sleep    1s

Set Marks on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript    if (activeSheet.getSheetType() !== "worksheet") {activeSheet.getWorksheets().get(${sheet_name}).selectMarksAsync(${filter_name}, ${filter_values}, "REPLACE").then(console.log("marks selected."))} else { activeSheet.selectMarksAsync(${filter_name}, ${filter_values}, "REPLACE").then(console.log("marks selected."))}
	Sleep    1s

Set Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript    if (activeSheet.getSheetType() !== "worksheet") {activeSheet.getWorksheets().get(${sheet_name}).applyFilterAsync(${filter_name}, ${filter_values}, "REPLACE").then(console.log("filter set."))} else {activeSheet.applyFilterAsync(${filter_name}, ${filter_values}, "REPLACE").then(console.log("filter set."))}
	Sleep    1s
