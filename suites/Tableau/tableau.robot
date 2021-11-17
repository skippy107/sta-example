*** Settings ***
Documentation	Tableau Keyword Library
Library	SeleniumLibrary
#Library	Screenshot

				
*** Keywords ***
Check Parameter
    [Arguments]    ${parm}
	${type} =   Run Keyword And Return Status    Evaluate    type(${parm}).__name__
	${newparm} =    Set Variable If    ${type} == ${False}    '${parm}'    ${parm}     
	[Return]    ${newparm}

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
	${eid} =    Check Parameter    ${eid}     
	${url} =    Check Parameter    ${url}     
	Execute Javascript	if (!srcViz) {
		...                initializeSourceViz(${eid},${url});
		...                srcListenToMarksSelection();
		...             }
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Load Target Dashboard
	[Arguments]	${eid}	${url}
	${eid} =    Check Parameter    ${eid}     
	${url} =    Check Parameter    ${url}     
	Execute Javascript	if (!trgViz) {
		...                initializeTargetViz(${eid},${url});
		...                trgListenToMarksSelection();
		...             }
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Unload Source Dashboard
	Execute Javascript	srcRemoveMarksSelectionEventListener(); 
	...                 srcViz.dispose();
	...                 srcViz = false; 

Unload Target Dashboard
	Execute Javascript	trgRemoveMarksSelectionEventListener(); 
	...                 trgViz.dispose();
	...                 trgViz = false; 

Switch To Source Sheet
	[Arguments]	${sheet}
	${sheet} =    Check Parameter    ${sheet}     
	Execute Javascript	srcSwitchToSheet(${sheet});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Switch To Target Sheet
	[Arguments]	${sheet}
	${sheet} =    Check Parameter    ${sheet}     
	Execute Javascript	trgSwitchToSheet(${sheet});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Source Filter
	[Arguments]	${filter}	${value}	 # see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Target Filter
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add To Source Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add To Target Filter	
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Filter Source Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${range} =    Check Parameter    ${range}     
	Execute Javascript	srcFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Filter Target Range				
	[Arguments]	${filter}	${range}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${range} =    Check Parameter    ${range}     
	Execute Javascript	trgFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove From Source Filter				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcRemoveValueFromFilter(${filter},${value});

Remove From Target Filter				
	[Arguments]	${filter}	${value}	 # see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgRemoveValueFromFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Source Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	${filter} =    Check Parameter    ${filter}     
	Execute Javascript	srcClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Target Filter				
	[Arguments]	${filter}	# see tableau docs for possible formatting of the value parameter	
	${filter} =    Check Parameter    ${filter}     
	Execute Javascript	trgClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcSelectValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcAddValueToSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove Source Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcRemoveFromSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Source Marks				
	Execute Javascript	srcClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgSelectValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgAddValueToSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove Target Marks				
	[Arguments]	${filter}	${value}	# see tableau docs for possible formatting of the value parameter
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgRemoveFromSelection(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Target Marks				
	Execute Javascript	trgClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Sum Source Marks				
	[Arguments]	${field}
	${field} =    Check Parameter    ${field}     
	${result}=	Execute Javascript	return srcTotalSelectedMarks(${field});
	[Return]	${result}

Sum Target Marks				
	[Arguments]	${field}
	${field} =    Check Parameter    ${field}     
	${result}=	Execute Javascript	return trgTotalSelectedMarks(${field});
	[Return]	${result}

Set Source Parameter ${parameter_name} to ${parameter_value}
	${parameter_name} =    Check Parameter    ${parameter_name}     
	${parameter_value} =    Check Parameter    ${parameter_value}     
	Execute Javascript   srcSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Target Parameter ${parameter_name} to ${parameter_value}
	${parameter_name} =    Check Parameter    ${parameter_name}     
	${parameter_value} =    Check Parameter    ${parameter_value}     
	Execute Javascript   trgSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Source Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	${filter_name} =    Check Parameter    ${filter_name}     
	${filter_value} =    Check Parameter    ${filter_value}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript  srcSwitchAndFilter(${sheet_name},${filter_name},${filter_values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}
            
Set Target Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
	${filter_name} =    Check Parameter    ${filter_name}     
	${filter_value} =    Check Parameter    ${filter_value}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript  trgSwitchAndFilter(${sheet_name},${filter_name},${filter_values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Source Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	${column_name} =    Check Parameter    ${column_name}     
	${mark_values} =    Check Parameter    ${mark_values}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript    srcSwitchAndSelect(${sheet_name},${column_name},${mark_values});
	Sleep    1s

Select Target Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
	${column_name} =    Check Parameter    ${column_name}     
	${mark_values} =    Check Parameter    ${mark_values}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript    trgSwitchAndSelect(${sheet_name},${column_name},${mark_values});
	Sleep    1s
