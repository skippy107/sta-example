*** Settings ***
Library           OperatingSystem

*** Test Cases ***
GetEnvironmentVariablesTest
    [Tags]    system
    ${ComputerName}=    Get Environment Variable    COMPUTERNAME
    ${OperatingSystem}=    Get Environment Variable    OS
    ${TestUserName}=    Get Environment Variable    USERNAME
    ${SystemDir}=    Get Environment Variable    WINDIR
    ${ProcessorLevel}=    Get Environment Variable    PROCESSOR_LEVEL
    Log    ${ComputerName}
    Log    ${OperatingSystem}
    Log    ${TestUserName}
    Log    ${SystemDir}
    Log    ${ProcessorLevel}