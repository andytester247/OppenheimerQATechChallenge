*** Settings ***
Resource   ${CURDIR}/../Resources/common.robot
Test Teardown    REST.POST         ${api_url}/calculator/rakeDatabase

*** Test Cases ***
US2_TC1: insertMultiple API Call with array of Multiple valid person details
    [Tags]    Positive    Smoke     US2
    [Template]      Post Request on CalculatorInsertMultiple ${array_data} ${expect}
    ${array_users}      ${statusCode_202}
US2_TC2: insertMultiple API Call with an empty array
    [Tags]    Positive     US2
    [Template]      Post Request on CalculatorInsertMultiple ${array_data} ${expect}
    ${emptyArray}      ${statusCode_202}
US2_TC3: insertMultiple API Call with 2 set of array of same person details
    [Tags]    Positive     US2
    [Template]      Post Request on CalculatorInsertMultiple ${array_data} ${expect}
    ${array_samedetails}      ${statusCode_202}
US2_TC4: insertMultiple API Call with 1 invalid person details
    [Tags]    Negative     US2
    [Template]      Post Request on CalculatorInsertMultiple ${array_data} ${expect}
    ${array_invalidDetails}      ${statusCode_500}