*** Settings ***
Resource   ${CURDIR}/../Resources/common.robot
Test Teardown    REST.POST    ${api_url}/calculator/rakeDatabase

*** Test Cases ***
US3_TC1: Should failed to upload to portal with csv with no header
    [Tags]    Negative      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    listusers_noheader.csv    Chrome        ${EMPTY}        ${EMPTY}
    [Teardown]      Close Browser
    [Documentation]  Should not able to upload to portal when the csv file has no header

US3_TC2: Should failed to upload to portal with incorrect file format e.g: .PDF
    [Tags]    Negative      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.pdf    Chrome        ${EMPTY}        ${EMPTY}
    [Teardown]      Close Browser
    [Documentation]  Should failed to upload to portal when a different file format is in used.
    ...              Improvment: It should display error message/code to indicate incorrect file format.
    ...              covering Chrome browser with different supported file formats

US3_TC3: Should failed to upload to portal with incorrect file format e.g: .txt
    [Tags]    Negative      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.txt    Chrome        ${EMPTY}        ${EMPTY}
    [Teardown]      Close Browser
    [Documentation]  Should failed to upload to portal when a different file format is in used.
    ...              Improvment: It should display error message/code to indicate incorrect file format.
    ...              covering Chrome browser with different supported file formats

US3_TC4: Should failed to upload to portal with incorrect file format e.g: .xlsx
    [Tags]    Negative      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.xlsx    Chrome        ${EMPTY}        ${EMPTY}
    [Teardown]      Close Browser
    [Documentation]  Should failed to upload to portal when a different file format is in used.
    ...              Improvment: It should display error message/code to indicate incorrect file format.
    ...              covering Chrome browser with different supported file formats

US3_TC5: Should failed to upload to portal with incorrect file format e.g: .xls
    [Tags]    Negative      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.xls      Chrome        ${EMPTY}        ${EMPTY}
    [Teardown]      Close Browser
    [Documentation]  Should failed to upload to portal when a different file format is in used.
    ...              Improvment: It should display error message/code to indicate incorrect file format.
    ...              covering Chrome browser with different supported file formats

US3_TC6: Should able to upload to portal with csv with valid content: Chrome
    [Tags]    Positive    Smoke     BrowserCompatibility        US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.csv    Chrome      '1123$'           '495.00'
    [Teardown]      Close Browser
    [Documentation]  Should able to upload to portal successfully when the csv file has valid content via Chrome browser

US3_TC7: Should able to upload to portal with csv with valid content: Firefox
    [Tags]    Positive    Smoke     BrowserCompatibility      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.csv    Firefox      '1123$'      '495.00'
    [Teardown]      Close Browser
    [Documentation]  Should able to upload to portal successfully when the csv file has valid content via Firefox browser

US3_TC8: Should able to upload to portal with csv with valid content: Edge
    [Tags]    Positive    Smoke     BrowserCompatibility      US3
    [Template]      Upload file to UI portal ${file} ${BROWSER} ${expectNatIdFromCVS} ${expectReliefFromCVS}
    testfile.csv    Edge      '1123$'      '495.00'
    [Teardown]      Close Browser
    [Documentation]  Should able to upload to portal successfully when the csv file has valid content via Edge browser
