*** Settings ***
Documentation	Tableau Keyword Library
Library	SeleniumLibrary
#Library	Screenshot

				
*** Keywords ***
Tableau Ready
    ${tr} =    Execute Javascript    return tbusy;
    Should Not Be Equal    ${tr}    ${TRUE}
    [Return]    not ${tr}

Load Source Dashboard
	[Arguments]	${eid}	${url}
	Execute Javascript	if (!srcViz) {initializeSourceViz(${eid},${url}); srcListenToMarksSelection();}
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Load Target Dashboard
	[Arguments]	${eid}	${url}
	Execute Javascript	if (!trgViz) {initializeTargetViz(${eid},${url}); trgListenToMarksSelection();}
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Unload Source Dashboard
	Execute Javascript	srcRemoveMarksSelectionEventListener(); srcViz.dispose();srcViz = false; 

Unload Target Dashboard
	Execute Javascript	trgRemoveMarksSelectionEventListener(); trgViz.dispose();trgViz = false; 

Switch To Source Sheet
	[Arguments]	${sheet}
	Execute Javascript	srcSwitchToSheet(${sheet});

Switch To Target Sheet
	[Arguments]	${sheet}
	Execute Javascript	trgSwitchToSheet(${sheet});

Set Source Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcFilterValue(${filter},${value});

Set Target Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgFilterValue(${filter},${value});

Add To Source Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcAddValueToFilter(${filter},${value});

Add To Target Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgAddValueToFilter(${filter},${value});

Filter Source Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcFilterRangeOfValues(${filter},${range});

Filter Target Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgFilterRangeOfValues(${filter},${range});

Remove From Source Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcRemoveValueFromFilter(${filter},${value});

Remove From Target Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgRemoveValueFromFilter(${filter},${value});

Clear Source Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	Execute Javascript	srcClearFilter(${filter});

Clear Target Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	Execute Javascript	trgClearFilter(${filter});

Select Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcSelectValue(${filter},${value});

Add Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcAddValueToSelection(${filter},${value});

Remove Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcRemoveFromSelection(${filter},${value});

Clear Source Marks				
	Execute Javascript	srcClearSelection();

Select Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgSelectValue(${filter},${value});

Add Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgAddValueToSelection(${filter},${value});

Remove Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgRemoveFromSelection(${filter},${value});

Clear Target Marks				
	Execute Javascript	trgClearSelection();

Sum Source Marks				
	[Arguments]	${field}
	${result}=	Execute Javascript	return srcTotalSelectedMarks(${field});
	[Return]	${result}

Sum Target Marks				
	[Arguments]	${field}
	${result}=	Execute Javascript	return trgTotalSelectedMarks(${field});
	[Return]	${result}

Set Source Parameter ${parameter_name} to ${parameter_value}
	Execute Javascript   srcWorkbook.changeParameterValueAsync(${parameter_name},${parameter_value}).then(console.log("parameter changed."));
	Sleep    1s

Set Target Parameter ${parameter_name} to ${parameter_value}
	Execute Javascript   trgWorkbook.changeParameterValueAsync(${parameter_name},${parameter_value}).then(console.log("parameter changed."));
	Sleep    1s

Set Source Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript  srcSwitchToSheet(${sheet_name}); srcFilterValue(${filter_name},${filter_values},"REPLACE");   
	Sleep    1s
            
Set Target Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript  trgSwitchToSheet(${sheet_name}); trgFilterValue(${filter_name},${filter_values},"REPLACE");   
	Sleep    1s
            

Set Source Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	Execute Javascript    srcSwitchToSheet(${sheet_name}); srcWbSheet.selectMarksAsync(${column_name}, ${mark_values}, "REPLACE");
	Sleep    1s

Set Target Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	Execute Javascript    trgSwitchToSheet(${sheet_name}); trgWbSheet.selectMarksAsync(${column_name}, ${mark_values}, "REPLACE");
	Sleep    1s
