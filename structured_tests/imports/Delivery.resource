*** Settings ***

Resource    ../objects/Delivery.App.resource
Resource    ../objects/Delivery.Cart.resource

Documentation    Import file for Delivery Tests 
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
    ${ret} =    Cart.FreeDeliveryTest
    Should Be Equal    ${ret}    ${Free Flag}

