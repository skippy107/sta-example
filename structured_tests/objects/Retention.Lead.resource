*** Settings ***

Resource          ../adapters/SeleniumLibrary.resource

Documentation     Defines all resources and keywords 
...               handling the lead object
...

*** Variables ***

${ChangeFields Key}    TAB

# For the purpose of this example the ID values are arbitrary
#
# When using a web driver the ID value is the locator
#
${New Lead Button ID}    someID
${New Lead Title ID}    someOtherID
${Lead TextBox ID}    anotherID
${Search Button ID}    yetAnotherID
${Save Button ID}    andYetAnotherID
${LeadType TextBox ID}    theNextToLastID
${LeadOwner TextBox ID}    theLastID

*** Keywords ***

Lead.Create
#   Click Button ${New Lead Button ID}
#   Wait For Object To Appear    ${New Lead Title ID}
    No Operation
    Log    New lead created successfully.

Lead.Retrieve
    [Arguments]    ${LeadID}

#   Input Text    ${Lead TextBox ID} ${LeadID}
#   Click Button ${Search Button ID}
#   Wait Until Page Contains    ${LeadID}
    No Operation
    Log    Lead ${LeadID} retrieved successfully.

Lead.Save
#   Click Button ${Save Button ID}
#   Wait For Object To Appear    ${New Lead Title ID}
    No Operation
    Log    Lead saved successfully.

Lead.SetType
    [Arguments]    ${LeadType}

#   Input Text    ${LeadType TextBox ID}    ${LeadType}
#   Send Keys    ${ChangeFields Key}
#   Wait Until Page Contains    ${LeadType}
    No Operation
    Log    Lead type set to ${LeadType} 

Lead.CheckOwner
    [Arguments]    ${LeadOwner}

#   Element Should Contain     ${LeadOwner TextBox ID}    ${LeadOwner}
    No Operation
    Log    Lead ownership successfully validated.

