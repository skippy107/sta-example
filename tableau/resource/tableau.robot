*** Settings ***
Documentation	Tableau Keyword Library
Library	SeleniumLibrary
#Library	Screenshot

				
*** Keywords ***
Check Parameter
    [Documentation]    Checks the variable type of ${parm} and returns the value enclosed
	...                in quotes if it is not a legal Python type.  This function is intended
	...                to be used on all parameters passed to the Tableau Javascript API so
	...                that they can be properly formatted
    [Arguments]    ${parm}
	${type} =   Run Keyword And Return Status    Evaluate    type(${parm}).__name__
	${newparm} =    Set Variable If    ${type} == ${False}    '${parm}'    ${parm}     
	[Return]    ${newparm}

Tableau Ready
    [Documentation]    Returns the state of the Tableau visualizations.  Intended to be
	...                used in a loop after each asynchronous Tableau API call to wait
	...                until the visualization is ready for the next command.
	...
	...                Example:
	...
    ...                Execute Javascript	srcRevertAll();
	...                ${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	...                [Return]    ${tr}
	...
    ${tr} =    Execute Javascript    if (srcViz) {
                ...                      srcViz.refreshDataAsync(); 
                ...                  }
	            ...                  if (trgViz) { 
                ...                      trgViz.refreshDataAsync(); 
                ...                  }
			    ...                  return tbusy;
    Should Not Be Equal    ${tr}    ${TRUE}
    [Return]    not ${tr}

Source Revert All 
    [Documentation]    Reverts source visualization to default view
    Execute Javascript	srcRevertAll();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	[Return]    ${tr}

Target Revert All 
    [Documentation]    Reverts target visualization to default view
    Execute Javascript	trgRevertAll();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	[Return]    ${tr}

Load Source Dashboard
    [Documentation]    Loads the source visualization specified in ${url} into the 
	...                text fixture at the div with ID ${eid} 
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
    [Documentation]    Loads the target visualization specified in ${url} into the 
	...                text fixture at the div with ID ${eid} 
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
    [Documentation]    Unloads the source visualization
	Execute Javascript	srcRemoveMarksSelectionEventListener(); 
	...                 srcViz.dispose();
	...                 srcViz = false; 

Unload Target Dashboard
    [Documentation]    Unloads the target visualization
	Execute Javascript	trgRemoveMarksSelectionEventListener(); 
	...                 trgViz.dispose();
	...                 trgViz = false; 

Switch To Source Sheet
    [Documentation]    Switches to the sheet named ${sheet} in the source visualization
	[Arguments]	${sheet}
	${sheet} =    Check Parameter    ${sheet}     
	Execute Javascript	srcSwitchToSheet(${sheet});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Switch To Target Sheet
    [Documentation]    Switches to the sheet named ${sheet} in the target visualization
	[Arguments]	${sheet}
	${sheet} =    Check Parameter    ${sheet}     
	Execute Javascript	trgSwitchToSheet(${sheet});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Source Filter
    [Documentation]    Sets the filter named ${filter} to ${value} in the source visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Target Filter
    [Documentation]    Sets the filter named ${filter} to ${value} in the target visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgFilterValue(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add To Source Filter	
    [Documentation]    Adds ${value} to the filter named ${filter} in the source visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add To Target Filter	
    [Documentation]    Adds ${value} to the filter named ${filter} in the target visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgAddValueToFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Filter Source Range				
    [Documentation]    Sets the filter named ${filter} to ${range} in the source visualization
	...                See the Tableau API documentation for possible formatting of the range parameter
	[Arguments]	${filter}	${range}
	${filter} =    Check Parameter    ${filter}     
	${range} =    Check Parameter    ${range}     
	Execute Javascript	srcFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Filter Target Range				
    [Documentation]    Sets the filter named ${filter} to ${range} in the target visualization
	...                See the Tableau API documentation for possible formatting of the range parameter
	[Arguments]	${filter}	${range}
	${filter} =    Check Parameter    ${filter}     
	${range} =    Check Parameter    ${range}     
	Execute Javascript	trgFilterRangeOfValues(${filter},${range});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove From Source Filter				
    [Documentation]    Removes ${value} from the filter named ${filter} in the source visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	srcRemoveValueFromFilter(${filter},${value});

Remove From Target Filter				
    [Documentation]    Removes ${value} from the filter named ${filter} in the target visualization
	...                See the Tableau API documentation for possible formatting of the value parameter
	[Arguments]	${filter}	${value}
	${filter} =    Check Parameter    ${filter}     
	${value} =    Check Parameter    ${value}     
	Execute Javascript	trgRemoveValueFromFilter(${filter},${value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Source Filter				
    [Documentation]    Clears the filter named ${filter} in the source visualization
	[Arguments]	${filter}
	${filter} =    Check Parameter    ${filter}     
	Execute Javascript	srcClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Target Filter				
    [Documentation]    Clears the filter named ${filter} in the target visualization
	[Arguments]	${filter}
	${filter} =    Check Parameter    ${filter}     
	Execute Javascript	trgClearFilter(${filter});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Source Marks				
    [Documentation]    Selects ${values} from the column named ${mark} in the source visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}	
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	srcSelectValue(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add Source Marks				
    [Documentation]    Adds ${values} to the column named ${mark} in the source visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}	
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	srcAddValueToSelection(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove Source Marks				
    [Documentation]    Removes ${values} from the column named ${mark} in the source visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}	
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	srcRemoveFromSelection(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Source Marks				
    [Documentation]    Clears all selections from the column named ${mark} in the source visualization
	Execute Javascript	srcClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Target Marks				
    [Documentation]    Selects ${values} from the column named ${mark} in the target visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	trgSelectValue(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Add Target Marks				
    [Documentation]    Adds ${values} to the column named ${mark} in the target visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}	
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	trgAddValueToSelection(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Remove Target Marks				
    [Documentation]    Removes ${values} from the column named ${mark} in the target visualization
	...                See the Tableau API documentation for possible formatting of the values parameter
	[Arguments]    ${mark}    ${values}	
	${mark} =    Check Parameter    ${mark}     
	${values} =    Check Parameter    ${values}     
	Execute Javascript	trgRemoveFromSelection(${mark},${values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Clear Target Marks				
    [Documentation]    Clears all selections from the column named ${mark} in the target visualization
	Execute Javascript	trgClearSelection();
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Sum Source Marks				
    [Documentation]    Sums all values from selected marks for ${field} in the source visualization
	[Arguments]	${field}
	${field} =    Check Parameter    ${field}     
	${result}=	Execute Javascript	return srcTotalSelectedMarks(${field});
	[Return]	${result}

Sum Target Marks				
    [Documentation]    Sums all values from selected marks for ${field} in the target visualization
	[Arguments]	${field}
	${field} =    Check Parameter    ${field}     
	${result}=	Execute Javascript	return trgTotalSelectedMarks(${field});
	[Return]	${result}

Set Source Parameter ${parameter_name} to ${parameter_value}
    [Documentation]    Sets the parameter named ${parameter_name} to ${parameter_value} in the source visualization
	${parameter_name} =    Check Parameter    ${parameter_name}     
	${parameter_value} =    Check Parameter    ${parameter_value}     
	Execute Javascript   srcSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Target Parameter ${parameter_name} to ${parameter_value}
    [Documentation]    Sets the parameter named ${parameter_name} to ${parameter_value} in the target visualization
	${parameter_name} =    Check Parameter    ${parameter_name}     
	${parameter_value} =    Check Parameter    ${parameter_value}     
	Execute Javascript   trgSetParameter(${parameter_name},${parameter_value});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Set Source Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
    [Documentation]    Switches to ${sheet} and sets the filter named ${filter_name} to ${filter_values} in the source visualization
	...                See the Tableau API documentation for possible formatting of the filter_values parameter
	${filter_name} =    Check Parameter    ${filter_name}     
	${filter_value} =    Check Parameter    ${filter_value}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript  srcSwitchAndFilter(${sheet_name},${filter_name},${filter_values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}
            
Set Target Filter on ${filter_name} to ${filter_values} on Sheet ${sheet_name}	
    [Documentation]    Switches to ${sheet} and sets the filter named ${filter_name} to ${filter_values} in the target visualization
	...                See the Tableau API documentation for possible formatting of the filter_values parameter
	${filter_name} =    Check Parameter    ${filter_name}     
	${filter_value} =    Check Parameter    ${filter_value}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript  trgSwitchAndFilter(${sheet_name},${filter_name},${filter_values});
	${tr} =    Wait Until Keyword Succeeds    7s    1s    Tableau Ready
	#Sleep    500ms
	[Return]    ${tr}

Select Source Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
    [Documentation]    Switches to ${sheet} and selects ${mark_values} from the column named ${column_name} in the source visualization
	...                See the Tableau API documentation for possible formatting of the mark_values parameter
	${column_name} =    Check Parameter    ${column_name}     
	${mark_values} =    Check Parameter    ${mark_values}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript    srcSwitchAndSelect(${sheet_name},${column_name},${mark_values});
	Sleep    1s

Select Target Marks on ${column_name} to ${mark_values} on Sheet ${sheet_name}	
    [Documentation]    Switches to ${sheet} and selects ${mark_values} from the column named ${column_name} in the target visualization
	...                See the Tableau API documentation for possible formatting of the mark_values parameter
	${column_name} =    Check Parameter    ${column_name}     
	${mark_values} =    Check Parameter    ${mark_values}     
	${sheet_name} =    Check Parameter    ${sheet_name}     
	Execute Javascript    trgSwitchAndSelect(${sheet_name},${column_name},${mark_values});
	Sleep    1s
