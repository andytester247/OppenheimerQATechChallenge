*** Settings ***
Library    REST
Library    Collections
Library    String
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime
*** Variables ***
${api_url}=       http://localhost:8080

# US1 Variables
${validBirthday}=           24121984
${validGender_m}=           m
${validGender_f}=           f
${invalidGender_g}=         g
${CAPPEDGender}=            F
${FullwordGender}=          FEMALE
${validName}=               Peter Parker
${validNatId}=              123456
${validSalary}=             4500
${validTaxPaid}=            1200
${longCharSupport_name}=    mandydfsmdflkasejflk;jwe;lifjfkmwe;lfmwel;kfw;'lekf;'lawkf;lwekf;'aksf;awksf;leefwasefaesfawesf
${longCharSupport_natid}=   ttew12345678901234567890qwertyuiopsadfjhklxzcmv,n,m
${empty_value}=

${NegValue_Natid}=                      -123456
${MixChars_Natid}=                      123CHAT
${SpecialChar_Natid}=                   1256@@!!

${invalidDate_Birthday}=                40141980
${invalidDateFormat_birthday}=          24DEC1984
${invalidDateNegValue_birthday}=        -24121984
${invalidDateSpecialChar_birthday}=     24&*!1984

${invalidNegValue_salary}=              -5000
${invalidMixValue_salary}=              SGD5000
${invalidSpecialChar_salary}=           50&*!!

${invalidNegValue_taxPaid}=             -1200
${invalidMixValue_taxPaid}=             SGD1200
${invalidSpecialChar_taxPaid}=          10&*!!


# US2 Variables
${statusCode_200}=          200
${statusCode_202}=          202
${statusCode_500}=          500
${array_users}=             [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "12345", "salary": "1000", "tax": "80"},{"birthday": "24091984", "gender": "f", "name": "Jane", "natid": "123456", "salary": "2000", "tax": "160"}]
${emptyArray}=              []
${array_samedetails}=       [{"birthday": "24121984", "gender": "m", "name": "med", "natid": "1234", "salary": "1000", "tax": "80"},{"birthday": "24121984", "gender": "m", "name": "med", "natid": "1234", "salary": "1000", "tax": "80"}]
${array_invalidDetails}=    [{"gender": "m", "name": "andy", "salary": "1000", "tax": "80"},{"birthday": "24091984", "gender": "f", "name": "Jane", "natid": "11231", "salary": "2000", "tax": "160"}]

# US3 Variables
${chooseFileInput}=         /html/body/div/div[2]/div/div[1]/div[2]/input

# US4 Variables
${array_user0masking}=      [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "1234", "salary": "1000", "tax": "80"}]
${array_user1masking}=      [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "12345", "salary": "1000", "tax": "80"}]
${array_user2masking}=      [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "123456", "salary": "1000", "tax": "80"}]
${array_user3masking}=      [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "1234567891234567890", "salary": "1000", "tax": "80"}]
${array_user4masking}=      [{"birthday": "24121984", "gender": "m", "name": "andy", "natid": "1", "salary": "1000", "tax": "80"}]

# US5 Variables
${Cash_dispensed}=         Cash dispensed
${Cash_dispensed_button_webElementLocator}=       /html/body/div/div[2]/div/a[2]
${Cash_dispensed_text_WebElementLocator}=         /html/body/div/div/div/main/div/div/div
${color_code}=          .*220, 53, 69.*
***Keywords***
assert valid result
    Integer   response status  ${statusCode_202}
    String    response body    Alright

assert Internal Server Error
    Integer   response status  ${statusCode_500}
    String    response body error   Internal Server Error

# with arguments multiple parameter
Post Request on CalculatorInsert ${birthday} ${gender} ${name} ${natid} ${salary} ${taxPaid} ${expect}
    ${headers}=      Create Dictionary       Content-Type=application/json;charset=UTF-8      accept=*/*
    ${body}=         Create Dictionary   birthday=${birthday}  gender=${gender}   name=${name}   natid=${natid}   salary=${salary}     tax=${taxPaid}
    REST.POST        ${api_url}/calculator/insert    ${body}     headers=&{headers}
    IF    ${expect} == ${statusCode_202}
        assert valid result
    ELSE
        assert Internal Server Error
    END
    get CalculatorTaxRelief       ${name}     ${expect}


Post Request on CalculatorInsertMultiple ${array_data} ${expect}
    ${headers}=     Create Dictionary  Content-Type=application/json
    ${response}=    REST.POST  ${api_url}/calculator/insertMultiple  ${array_data}  headers=&{headers}
    IF    ${expect} == ${statusCode_202}
        assert valid result
    ELSE
        assert Internal Server Error
    END

Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    Open Browser    ${api_url}   ${BROWSER}
    Maximize Browser Window
    Execute JavaScript  window.scrollTo(0,200)
    ${newPathfile}=    Join Path    ${CURDIR}/../Resources/TestData    ${file}
    Choose File    xpath=${chooseFileInput}    ${newPathfile}

    ${resArray}=        get TaxRelief
    ${resArray}=    Array    response body
    ${hasContent} =   Run Keyword And Return Status     Convert To List    ${resArray}[-1][-1]

    IF    ${hasContent}
        ${targetfield}=  Convert To String  ${resArray}[-1][-1]
        Should Contain Any    ${targetfield}  ${expectNatIdFromCVS}
        Should Contain Any    ${targetfield}  ${expectReliefFromCVS}
    ELSE
        Should Be Empty     ${resArray}[-1]
    END


Dispense Tax Relief ${BROWSER} ${expect_Cash_Dispensed_Text} ${expect_Cash_Dispensed_Color}
    Open Browser    ${api_url}   ${BROWSER}
    Wait Until Element Is Visible    xpath=${Cash_dispensed_button_webElementLocator}      timeout=5
    ${Cash_dispensedButton}=    Get WebElement    xpath=${Cash_dispensed_button_webElementLocator}
    ${actualButton_color}=    Call Method    ${Cash_dispensedButton}    value_of_css_property   background-color
    Should Match Regexp    ${actualButton_color}    ${expect_Cash_Dispensed_Color}

    Click Button    ${Cash_dispensedButton}
    ${actualCashDispendTxt}=    Get WebElement    xpath=${Cash_dispensed_text_WebElementLocator}
    Element Should Contain    ${actualCashDispendTxt}    ${expect_Cash_Dispensed_Text}


Calculator Validation Tax relief ${age} ${gender} ${salary} ${taxPaid}
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${decimalplace}=    Set Variable    2
    ${currDate}=        Get Current Date
    ${curryear}=        Get Substring    ${currDate}    0  4
    ${newbirthday}=     calculate birthday with currentDate by age     ${curryear}  ${age}
    REST.POST   ${api_url}/calculator/insert  {"birthday": "${newbirthday}", "gender": "${gender}", "name": "user", "natid": "11325", "salary": "${salary}", "tax": "${taxpaid}"}  headers=&{headers}
    Integer   response status       ${statusCode_202}

    ${resArray}=        get TaxRelief
    ${targetfield}=  Convert To String  ${resArray}[-1][-1]
    Log To Console   ${targetfield}

    ${salary}=    Convert To Number    ${salary}    ${decimalplace}
    ${taxpaid}=   Convert To Number    ${taxpaid}   ${decimalplace}
    ${relief}=    calculate tax relief by salary, taxpaid, age and gender  ${salary}  ${taxpaid}  ${age}  ${gender}  ${decimalplace}
    Log To Console   ${relief}
    Should Contain Any    ${targetfield}  relief': '${relief}

# helper for Get Request - Calculator TaxRelief
get TaxRelief
    ${headers}=      Create Dictionary       Content-Type=application/json;charset=UTF-8      accept=*/*
    ${response}=    REST.GET  ${api_url}/calculator/taxRelief  headers=&{headers}
    Integer   response status  ${statusCode_200}
    ${resArray}=    Array    response body
    RETURN      ${resArray}

get CalculatorTaxRelief
       [Arguments]  ${name}     ${expect}
       ${resArray}=        get TaxRelief
       IF    ${expect} == 500
            Should Be Empty     ${resArray}[-1]
       ELSE
            ${hasContent} =   Run Keyword And Return Status     Convert To List    ${resArray}[-1][-1]
            #Assertion with the content(name)
            IF    ${hasContent}
                ${targetfield}=  Convert To String  ${resArray}[-1][-1]
                Should Contain Any    ${targetfield}  ${name}
            ELSE
                Should Be Empty     ${resArray}[-1]
            END
       END

# helper for US4
calculate birthday with currentDate by age
    [Arguments]  ${arg1}  ${arg}
    ${year}=    Set Variable    ${${arg1} - ${arg}}
    ${arg}=    Set Variable    ${${arg} * 365.25}
    ${currDate}=  Get Current Date
    ${date1}=   Subtract Time From Date    ${currDate}    ${arg} days     result_format=%d%m%y
    ${day}=     Get Substring    ${date1}    0  2
    ${mth}=     Get Substring    ${date1}    2  4
    ${newbirthday}=     Catenate  SEPARATOR=      ${day}    ${mth}
    ${newbirthday}=     Catenate  SEPARATOR=      ${newbirthday}    ${year}
    # Log To Console   ${newbirthday}
    ${newbirthday}=     Convert To String    ${newbirthday}
    RETURN     ${newbirthday}

# helper for US4
calculate tax relief by salary, taxpaid, age and gender
    [Arguments]  ${salary1}  ${taxpaid1}  ${age1}  ${gender1}  ${decimalplace}

    ${taxrelief}=   Evaluate  ${salary1} - ${taxpaid1}
    IF    0 < ${age1} < 19
        ${taxrelief}=   Evaluate  ${taxrelief}*1
    ELSE IF    18 < ${age1} < 36
        ${taxrelief}=   Evaluate  ${taxrelief}*0.8
    ELSE IF    35 < ${age1} < 51
        ${taxrelief}=   Evaluate  ${taxrelief}*0.5
    ELSE IF    50 < ${age1} < 76
        ${taxrelief}=   Evaluate  ${taxrelief}*0.367
    ELSE IF    75 < ${age1}
        ${taxrelief}=   Evaluate  ${taxrelief}*0.05
    END

    # set to 2 decimal places only
    ${taxrelief}=    Convert To String    ${taxrelief}
    ${Ptax}=    Evaluate    "${taxrelief}".split(".")
    # convert if there is more than 2 decimal
    ${len}=    Get Length    ${Ptax[1]}

    ${taxrelief}=    Convert To Number    ${taxrelief}    ${decimalplace}
    # rounding
    ${taxrelief}=    Evaluate    round($taxrelief)

    IF    "${gender1}" == "f"
        ${taxrelief}=      Evaluate  ${taxrelief}+ 500.00
        ${taxrelief}=    Convert To Number    ${taxrelief}    2
    END
    IF    0 < ${taxrelief} < 50
        ${taxrelief}=     Set Variable  50
    ELSE IF  0 > ${taxrelief}
        ${taxrelief}=     Set Variable  50
    ELSE IF  0== ${taxrelief}
         ${taxrelief}=    Set Variable  125
    END

    RETURN     ${taxrelief}

