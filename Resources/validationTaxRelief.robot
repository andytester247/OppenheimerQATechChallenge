*** Settings ***
Library    REST
*** Variables ***
${api_url}=       http://localhost:8080

***Keywords***
assert valid result
    Integer   response status  202
    String    response body    Alright

Calculator Validation Tax relief to check natId masking function ${array} ${expect}
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${response}=    REST.POST  ${api_url}/calculator/insertMultiple  ${array}  headers=&{headers}
    assert valid result
    ${response}=    REST.GET  ${api_url}/calculator/taxRelief  headers=&{headers}
    Integer   response status  200
    ${resArray}=    Array    response body
    ${targetfield1}=  Convert To String  ${resArray}[-1][-1]
    Should Contain Any    ${targetfield1}  ${expect}