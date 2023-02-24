*** Settings ***
Resource   ${CURDIR}/../Resources/common.robot
Test Teardown    REST.POST         ${api_url}/calculator/rakeDatabase

*** Test Cases ***
US1_TC1: Valid Person Details:male gender:
    [Tags]      Positive    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_202}
US1_TC2: Valid Person Details:male gender:
    [Tags]      Positive    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_f}       ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_202}
US1_TC3: Valid Person Details:longCharSupport_name:
    [Tags]      Positive    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${longCharSupport_name}      ${validNatId}    ${validSalary}    ${validTaxPaid}     ${statusCode_202}
US1_TC4: Valid Person Details:longCharSupport_natid:
    [Tags]      Positive    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${longCharSupport_natid}  ${validSalary}    ${validTaxPaid}     ${statusCode_202}
US1_TC5: Invalid Details:negative natid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if natid is negative
    ${validBirthday}       ${validGender_m}       ${validName}        ${NegValue_Natid}         ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC6: Invalid Details:mixChars natid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if natid is mixed of Chars and numbers
    ${validBirthday}       ${validGender_m}       ${validName}        ${MixChars_Natid}         ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC7: Invalid Details:empty birthday:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${empty_value}         ${validGender_m}       ${validName}        ${validNatId}          ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC8: Invalid Details:empty gender:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if gender value is empty
    ${validBirthday}       ${empty_value}         ${validName}        ${validNatId}          ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC9: Invalid Details:empty name:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if name value is empty
    ${validBirthday}       ${validGender_m}       ${empty_value}      ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC10: Invalid Details:empty natid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if natid value is empty
    ${validBirthday}       ${validGender_m}       ${validName}        ${empty_value}            ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC11: Invalid Details:empty salary:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}             ${empty_value}    ${validTaxPaid}     ${statusCode_500}
US1_TC12: Invalid Details:empty tax paid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}             ${validSalary}    ${empty_value}      ${statusCode_500}
US1_TC13: Invalid Details:nonSingleChar_gender:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${FullwordGender}       ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC14: Invalid Details:invalidChar_gender:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if gender value is neither m or f
    ${validBirthday}       ${invalidGender_g}      ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC15: Invalid Details:Charbigcapped_gender:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if gender value is in CAPPED
    ${validBirthday}       ${CAPPEDGender}         ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC16: Invalid Details:invalidDate_birthday:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${invalidDate_Birthday}       ${validGender_m}      ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC17: Invalid Details:invalidDateFormat_birthday:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${invalidDateFormat_birthday}     ${validGender_m}   ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC18: Invalid Details:NegValue_birthday:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${invalidDateNegValue_birthday}     ${validGender_m}     ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC19: Invalid Details:SpecialChar_birthday:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${invalidDateSpecialChar_birthday}  ${validGender_m}     ${validName}        ${validNatId}             ${validSalary}    ${validTaxPaid}     ${statusCode_500}
US1_TC20: Invalid Details:NegValue_salary:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if salary value is negative
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${invalidNegValue_salary}    ${validTaxPaid}    ${statusCode_500}
US1_TC21: Invalid Details:MixValue_salary:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${invalidMixValue_salary}    ${validTaxPaid}    ${statusCode_500}
US1_TC23: Invalid Details:SpecialChar_salary:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${invalidSpecialChar_salary}   ${validTaxPaid}  ${statusCode_500}
US1_TC24: Invalid Details:NegValue_taxPaid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    [Documentation]     Bug encounter: expecting error if taxPaid value is negative
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${validSalary}   ${invalidNegValue_taxPaid}     ${statusCode_500}
US1_TC25: Invalid Details:MixCharsType_taxPaid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${validSalary}    ${invalidMixValue_salary}     ${statusCode_500}
US1_TC26: Invalid Details:SpecialChar_taxPaid:
    [Tags]      Negative    US1
    [Template]      Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${validBirthday}       ${validGender_m}       ${validName}        ${validNatId}   ${validSalary}  ${invalidSpecialChar_taxPaid}   ${statusCode_500}