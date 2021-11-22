*** Settings ***

Resource    ../objects/Retention.App.resource
Resource    ../objects/Retention.Lead.resource

Documentation    Import file for Retention Prospect Tests 
...
...    This file maps high level Given/When/Then keywords to object resources.  
...
...    The object resource files contain the implementation details for the
...    different test methods of each object.
...
...    For the purpose of this example we have two objects, the App
...    object and the Lead object.  
...

*** Keywords ***

A lead with ID
    [Arguments]    ${Lead ID}

    Run Keyword If    '${Lead ID}'=='NEW'    Lead.Create
    Run Keyword If    '${Lead ID}'!='NEW'    Lead.Retrieve    ${Lead ID}

The lead type is
    [Arguments]    ${Lead Type}

    Lead.SetType    ${Lead Type}

The lead is saved
    Lead.Save
    
The lead is transferred to
    [Arguments]    ${Lead Owner}

    Lead.CheckOwner    ${Lead Owner}


