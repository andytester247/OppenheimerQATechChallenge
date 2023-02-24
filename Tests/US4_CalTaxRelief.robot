*** Settings ***
Resource   ${CURDIR}/../Resources/common.robot
Resource   ${CURDIR}/../Resources/validationTaxRelief.robot
Test Teardown    REST.POST         ${api_url}/calculator/rakeDatabase

*** Test Cases ***
US4_TC1: Calculator validation tax relief with age: 17 AND Tax paid more than Salary by 1 dollar
    [Tags]    Positive    Smoke     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     501
    [Documentation]    Bug: the tax relief would returned 50 if the calculated would be -1, there is no instruction from the document what do expected but based on the Test application's returns as 50.
    ...    Improvement: add new instruction to state that if Tax is paid more the Salary, will get tax relief according to the Tax Relief Calculation.

US4_TC2: Calculator validation tax relief with age: 17 AND Salary more than Tax paid by 1 dollar
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       501     500
    [Documentation]   To verify the tax relief calculation when Salary is more than Tax paid

US4_TC3: Calculator validation tax relief with age: 0
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    0        ${validGender_m}       50      5
    [Documentation]    Test on age of a new born baby
    ...    Improvement: should add new instruction to state that Tax relief should limit to certain age range

US4_TC4: Calculator validation tax relief with age: 120
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    120        ${validGender_m}       50      5
    [Documentation]    Test on age of a old highlander
    ...    Improvement: should add new instruction to state that Tax relief should limit to certain age range

US4_TC5: Calculator validation tax relief with age: 17 AND Tax paid and Salary has the same amount
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     500
    [Documentation]  There is a bug, there is no description that the 125 would be presented as tax relief

US4_TC6: Calculator validation tax relief with tax relief of 2 Decimal place case1
    [Tags]    Positive     US4    Smoke
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     399.46
    [Documentation]  Test case on Decimal place and normal rounding
    ...              To verify the tax relief calculation when Tax paid with 2 decimal place where normal rounding will not be applied successfully
    ...              Bug: the api's normal rounding failed to round up.

US4_TC7: Calculator validation tax relief with tax relief of 2 Decimal place case2
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     399.51
    [Documentation]  Test case on Decimal place and normal rounding
    ...              To verify the tax relief calculation when Tax paid with 2 decimal place where normal rounding will be applied successfully

US4_TC8: Calculator validation tax relief with tax relief of 2 Decimal place case3
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     399.50
    [Documentation]  Test case on Decimal place and normal rounding
    ...              To verify the tax relief calculation when Tax paid with 2 decimal place where normal rounding will be applied successfully
    ...              Bug: the api's normal rounding failed to round up.

US4_TC9: Calculator validation tax relief with tax relief of 2 Decimal place case4
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     140.341
    [Documentation]  Test case on Decimal place and normal rounding
    ...              To verify the tax relief calculation when Tax paid with 2 decimal place where normal rounding will be applied successfully
    ...              Bug: the api's normal rounding failed to round up.

US4_TC10: Calculator validation tax relief with tax relief of 3 Decimal place
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_m}       500     399.446
    [Documentation]  Test case on Decimal place and normal rounding
    ...              To verify the tax relief calculation when Tax paid with 3 decimal place where normal rounding will applied successfully
    ...              Bug: the api's normal rounding failed to round up.

US4_TC11: Calculator validation tax relief with age: less than 17
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    16      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC12: Calculator validation tax relief with age: 18
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    18      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC13: Calculator validation tax relief with age: 19
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    19      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC14: Calculator validation tax relief with age: 35
    [Tags]    Positive     US4    Smoke
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    35      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC15: Calculator validation tax relief with age: 36
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    36      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC16: Calculator validation tax relief with age: 50
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    50      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC17: Calculator validation tax relief with age: 51
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    51      ${validGender_m}       500     20
    [Documentation]  Test case based on age.

US4_TC18: Calculator validation tax relief with age: 75
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    75      ${validGender_m}       500     20
    [Documentation]  Test case based on age.

US4_TC19: Calculator validation tax relief with age: 76
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    76      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC20: Calculator validation tax relief with age: 77
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    77      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC21: Calculator validation tax relief with age: 78
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    78      ${validGender_m}       1000     20
    [Documentation]  Test case based on age

US4_TC22: Calculator validation tax relief with age: 17 AND gender female
    [Tags]    Positive     US4
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    17      ${validGender_f}       1000     20
    [Documentation]  Test case based on age and gender

US4_TC23: Calculator validation tax relief with age: 78 AND gender female
    [Tags]    Positive     US4    Smoke
    [Template]      Calculator Validation Tax Relief ${age} ${gender} ${salary} ${taxPaid}
    78      ${validGender_f}       1000     20
    [Documentation]  Test case based on age and gender

US4_TC24: Calculator validation tax relief to check natid masking function
    [Template]      validationTaxRelief.Calculator Validation Tax relief to check natId masking function ${array_masking} ${expect}
#    ${array_user4masking}       'natid': '1'  Bug ## disabled:::Should return success with no masking from 1st natid instead of out of bound error.
    ${array_user0masking}       'natid': '1234'
    ${array_user1masking}       'natid': '1234$'
    ${array_user2masking}       'natid': '1234$$'
    ${array_user3masking}       'natid': '1234$$$$$$$$$$$$$$$'
    [Tags]    Positive    Smoke
    [documentation]  Should return success with no masking from 1st to 4th characters
    ...              Should return success with masking from 5th onwards
    ...              Bug: Should return success with no masking from 1st natid
    ...              Improvement: single natid character should be allow or new instruction should be added to indiciate the minimum number of characters for natid.