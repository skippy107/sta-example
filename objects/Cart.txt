*** Settings ***

Documentation     Defines all resources and keywords 
...               handling the cart object
...

*** Variables ***

${Cart.NumberOfItems}    0

*** Keywords ***

AddItem
    [Arguments]    ${Item Number}

    ${ret}    Evaluate    ${Cart.NumberOfItems} + 1
    Set Test Variable    ${Cart.NumberOfItems}  ${ret}

    Log    Item added to cart successfully.

Empty
    ${Cart.NumberofItems} =    Set Variable    0
    Log    Cart emptied successfully.

ItemCount
    [Return]    ${Cart.NumberOfItems}


