*** Settings ***

Resource    ../../settings/retention-settings.txt
Resource    ../../imports/Retention.txt

Suite Setup    App.Open
Suite Teardown    App.Close
Test Setup    App.Init


Documentation    *Retention Prospect Handling*
...    
...     This test suite consists of all tests related to Retention Prospects
...    
...     For this example we have a single test case to test the business rule below
...     but you can add more as needed.  Use the tagging feature of Robot Framework
...     to group tests together by sub-function.
...    
...    *Business Rule:*
...    
...         New leads that are Retention Prospects will be owned by the AZ 
...         Member Retention Queue. Previously enrolled leads which become Retention 
...         Prospects will be owned by the Seasonal Captive Agent.
...     
...    *Examples:*
...     
...        | =Lead Status= | =Lead Type= | =Lead Owner= |
...        | New           |  Retention Prospect | AZ Member Retention Queue |
...        | New           |  Seasonal Customer  | Default |
...        | Enrolled      |  Retention Prospect | Seasonal Captive Agent |
...        | Enrolled      |  Seasonal Customer  | Default |
...     


*** Keywords ***

RetentionTest 
    [Arguments]    ${Lead ID}    ${Lead Type}    ${Lead Owner}

    Given A lead with ID    ${Lead ID}
    And The lead type is    ${Lead Type}

    When The lead is saved

    Then The lead is transferred to    ${Lead Owner}
#
# The custom keyword RetentionTest represents the implementation of
# the Business Rule.  The custom keyword defined above is called by the 
# test cases below, each one testing the boundaries of the Business
# Rule
#
# Note how the custom keyword uses a behavior driven style and the
# test case uses a data driven style

| *Test Case*  |         | *Lead ID*     | *Lead Type*           | *Lead Owner*              |
| New Lead/Retention     | RetentionTest | ${NewID}              | Retention Prospect | AZ Member Retention Queue |
| New Lead/Non Retention | RetentionTest | ${NewID}              | Seasonal Customer  | Default                   |
| Enrolled/Retention     | RetentionTest | ${EnrolledProspectID} | Retention Prospect | Seasonal Captive Agent    |
| Enrolled/Non Retention | RetentionTest | ${EnrolledSeasonalID} | Seasonal Customer  | Default                   |

