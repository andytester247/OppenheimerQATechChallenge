*** Settings ***
Resource   ${CURDIR}/../Resources/common.robot
Test Teardown    Close Browser

*** Test Cases ***
US5_TC1: Should able to dispense tax relief: Chrome
    [Tags]    Positive      BrowserCompatibility        US5
    [Template]      Dispense Tax Relief ${BROWSER} ${expect_Cash_Dispensed_Text} ${expect_Cash_Dispensed_Color}
    Chrome      ${Cash_dispensed}       ${color_code}
    [Documentation]  Should able to display tax relief successfully when the Cash dispensed button clicked via Chrome Browser

US5_TC2: Should able to dispense tax relief: Firefox
    [Tags]    Positive    Smoke     BrowserCompatibility        US5
    [Template]      Dispense Tax Relief ${BROWSER} ${expect_Cash_Dispensed_Text} ${expect_Cash_Dispensed_Color}
    Firefox      ${Cash_dispensed}       ${color_code}
    [Documentation]  Should able to display tax relief successfully when the Cash dispensed button clicked via Firefox Browser

US5_TC3: Should able to dispense tax relief: Edge
    [Tags]    Positive      BrowserCompatibility        US5
    [Template]      Dispense Tax Relief ${BROWSER} ${expect_Cash_Dispensed_Text} ${expect_Cash_Dispensed_Color}
    Edge      ${Cash_dispensed}       ${color_code}
    [Documentation]  Should able to display tax relief successfully when the Cash dispensed button clicked via Edge Browser