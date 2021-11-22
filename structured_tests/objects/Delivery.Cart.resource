*** Settings ***

Resource          ../adapters/SeleniumLibrary.resource

Documentation     Defines all resources and keywords 
...               handling the cart object
...
...    For example purposes, the web driver commands are commented out
...  

*** Variables ***

${Cart.NumberOfItems}    ${0}
${Cart.ItemCount Label ID}    anID
${Cart.Search TextBox ID}    someID
${Cart.Search Button ID}    someOtherID
${Cart.ReturnShopping Link ID}    yetAnotherID

*** Keywords ***

Cart.AddItem
    [Arguments]    ${Item Number}
#    Input Text    ${Cart.Search TextBox ID}    ${Item Number}
#    Click Button    ${Cart.Search Button ID}
#    Wait For Element    ${Cart.ReturnShopping Link ID}
#    Click Button    ${Cart.ReturnShopping Link ID}
#    Wait For Element    ${Cart.Search Button ID}
    ${ret}    Evaluate    ${Cart.NumberOfItems} + 1
    Set Test Variable    ${Cart.NumberOfItems}  ${ret}
    No Operation
    Log    Item added to cart successfully.

Cart.Empty
#    Click Button    ${Cart.Empty Button ID}
#    Wait For Element    ${Cart.ItemCount Label ID}
#    Should Be Equal As Numbers    0   Cart.ItemCount
    ${Cart.NumberofItems} =    Set Variable    ${0}
    Log Variables
    Log    Cart emptied successfully.

Cart.ItemCount
#   Return     Get Text From Element    ${Cart.ItemCount Label ID}
    [Return]    ${Cart.NumberOfItems}
    No Operation

Cart.FreeDeliveryTest
    Log Variables
    Run Keyword If    '${CustomerType}'=='VIP' and ${Cart.NumberOfItems}>=${Threshold}
    ...    Return from Keyword    ${TRUE}
    [Return]    ${FALSE}

