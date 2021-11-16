*** Settings ***
Documentation	Tableau Keyword Library
Library	SeleniumLibrary
#Library	Screenshot

				
*** Keywords ***
Tableau Ready
    ${tr} =    Execute Javascript    if (srcViz) {
                ...                      srcViz.refreshDataAsync(); 
                ...                  }
	            ...                  if (trgViz) { 
                ...                      trgViz.refreshDataAsync(); 
                ...                  }
				...                  return tbusy;
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
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Switch To Target Sheet
	[Arguments]	${sheet}
	Execute Javascript	trgSwitchToSheet(${sheet});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Set Source Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Set Target Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Add To Source Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Add To Target Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Filter Source Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Filter Target Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Remove From Source Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcRemoveValueFromFilter(${filter},${value});

Remove From Target Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgRemoveValueFromFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Clear Source Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	Execute Javascript	srcClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Clear Target Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	Execute Javascript	trgClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Select Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcSelectValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Add Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcAddValueToSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Remove Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	srcRemoveFromSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Clear Source Marks				
	Execute Javascript	srcClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Select Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgSelectValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Add Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgAddValueToSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Remove Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	Execute Javascript	trgRemoveFromSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Clear Target Marks				
	Execute Javascript	trgClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Sum Source Marks				
	[Arguments]	${field}
	${result}=	Execute Javascript	return srcTotalSelectedMarks(${field});
	[Return]	${result}

Sum Target Marks				
	[Arguments]	${field}
	${result}=	Execute Javascript	return trgTotalSelectedMarks(${field});
	[Return]	${result}

Set Source Parameter ${parameter_name} to ${parameter_value}
	Execute Javascript   srcSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Set Target Parameter ${parameter_name} to ${parameter_value}
	Execute Javascript   trgSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Set Source Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript  srcSwitchToSheet(${sheet_name});srcFilterValue(${filter_name},${filter_values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}
            
Set Target Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	Execute Javascript  trgSwitchToSheet(${sheet_name}); trgFilterValue(${filter_name},${filter_values},"REPLACE");   
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	Sleep    500ms
	[Return]    ${tr}

Set Source Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	Execute Javascript    srcSwitchToSheet(${sheet_name}); srcWbSheet.selectMarksAsync(${column_name}, ${mark_values}, "REPLACE");
	Sleep    1s

Set Target Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	Execute Javascript    trgSwitchToSheet(${sheet_name}); trgWbSheet.selectMarksAsync(${column_name}, ${mark_values}, "REPLACE");
	Sleep    1s
