*** Settings ***
#
# The settings file defines suite level variables which
# can be used by any tests in the file
#
Resource    settings/FreeDelivery.Settings.robot

# The import file maps the Given/When/Then keywords to
# object resources
#
Resource          imports/FreeDelivery.robot


Suite Setup     FreeDelivery.SuiteSetup
Suite Teardown    FreeDelivery.SuiteTeardown

Test Setup    FreeDelivery.TestSetup
Test Teardown    FreeDelivery.TestTeardown


Documentation    *Eligibility Tests*
...    
...     This test suite consists of different eligibility tests related to ${SUITE NAME}
...    
...     For this example we have a single keyword to test the business rule below
...     but you can add more as needed.  Use the tagging feature of Robot Framework
...     to group tests together by sub-function.
...    
...    *Business Rule:*
...    
...       Free delivery is offered to VIP customers once they reach  
...       a certain number of books in their cart. Regular customers 
...       and VIP customers below this threshold do not recieve free delivery.
...     
...    *Examples:*
...     
...        | =Type=  | =Number of Books= | =Free Delivery?= |
...        | VIP     | Above Threshold | Yes |
...        | VIP     | At Threshold    | Yes |
...        | VIP     | Below Threshold | No |
...        | Regular | Above Threshold | No |
...        | Regular | At Threshold    | No |
...        | Regular | Below Threshold | No |
...     


*** Keywords ***

FreeDeliveryEligibility

    [Arguments]    ${Customer Type}    ${Number of Books}    ${Free Flag}

    Given A customer of type    ${Customer Type}

    When the number of books in the shopping cart is    ${Number of Books}

    Then free delivery is    ${Free Flag}

#
# The custom keyword FreeDeliveryEligibility represents the implementation of
# the Business Rule.  The custom keyword defined above is called by the 
# test cases below, each one testing the boundaries of the Business
# Rule
#
# Note how the custom keyword uses a behavior driven style and the
# test case uses a data driven style

| *Test Case*         | *Keyword to Run*        | *Cust Type*| *Number of Books* | *Free Delivery?* |
| VIP Above Threshold | FreeDeliveryEligibility |  VIP       | ${AboveThreshold} | ${TRUE} |
| VIP At Threshold    | FreeDeliveryEligibility |  VIP       | ${Threshold}      | ${TRUE} |
| VIP Below Threshold | FreeDeliveryEligibility |  VIP       | ${BelowThreshold} | ${FALSE} |
| Reg Above Threshold | FreeDeliveryEligibility |  Regular   | ${AboveThreshold} | ${FALSE} |
| Reg At Threshold    | FreeDeliveryEligibility |  Regular   | ${Threshold}      | ${FALSE} |
| Reg Below Threshold | FreeDeliveryEligibility |  Regular   | ${BelowThreshold} | ${FALSE} |

