*** Settings ***
#
# The import file is where we indicate which objects are needed for
# the tests in the suite
#
# By using this additional layer of abstraction we allow the technical
# implementation ( mouse clicks and control names ) to be separate from
# the business rules ( Free delivery under certain conditions )
#
# Overall this makes our tests less brittle and more likely to be used
# and maintained in the future
#

Resource    ../objects/App.resource
Resource    ../objects/Cart.resource

Documentation    Import file for ${SUITE NAME} Tests 
...
...    This file maps high level Given/When/Then keywords to object resources.  
...
...    The object resource files contain the implementation details for the
...    different test methods of each object.
...
...    For the purpose of this example we have two objects, the App
...    object and the Cart object.  
...

*** Keywords ***
#
#    Map the Given/When/Then statements to lower level sequences
#    of steps

A customer of type
    [Arguments]    ${Customer Type}

    Run Keyword If    '${Customer Type}'=='VIP'
    ...    App.Login    ${VIPUsername}    ${VIPPassword}

    Run Keyword If    '${Customer Type}'=='Regular'
    ...    App.Login    ${RegUsername}    ${RegPassword}

    ${ret}    Set Variable If
    ...    '${Customer Type}'=='VIP'    VIP    Regular

    Set Test Variable   ${CustomerType}    ${ret}


The number of books in the shopping cart is
    [Arguments]    ${Number of Books}

    Cart.Empty

    ${ref}    Set Variable    ${Number of Books}

    Repeat Keyword    ${ref} times    Cart.AddItem    ${ItemNumberOfSomeBook}


Free delivery is 
    [Arguments]    ${Free Flag}

    ${ic} =    Cart.ItemCount

    ${ret}    Set Variable If    '${CustomerType}'=='VIP' and ${ic}>=${Threshold}
    ...    ${TRUE}    ${FALSE}

    Should Be Equal    ${ret}    ${Free Flag}


####################################################################
#
# Always define Suite Setup/Teardown and Test Setup/Teardown
#

SuiteSetup
    App.Open 

SuiteTeardown
    App.Close

TestSetup
    App.Init

TestTeardown
    No Operation

