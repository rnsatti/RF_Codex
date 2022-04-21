*** Settings ***
Suite Setup       Selfcare_MoveFileToArchive
Library           DateTime    #Test Teardown    Close Browser    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson    #Suite Setup    Selfcare_MoveFileToArchive    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson
Resource          ../../CommonResources/Resources.txt
Library           OperatingSystem
Resource          ../Keywords/Selfcare_Keyword.txt
Library           XML
Library           RPA.JSON
Library           RPA.Database
Library           RPA.Browser.Selenium
Library           RPA.Desktop
Resource          ../../ResourceData/Selfcare/Selfcare_Locators.txt
Library           ScreenCapLibrary
Library           String
Library           BuiltIn
Library           SSHLibrary
Library           OperatingSystem
Library           CSVLibrary
Resource          ../../CommonResources/Setup_TearDown.txt

*** Test Cases ***
Selfcare Login
    [Tags]    QAD-56626
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Close Browser
        Stop Video Recording
    END
    END

Selfcare Consumer TC_Verify_AddCreditCard
    [Tags]    QAD-45357
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Settings Tab
        Settings Tab_Payments
        Add Credit Card
        Verify Add Credit Card
        Close Browser
        Stop Video Recording
    END
    END

Selfcare TC_Verify_PostpaidRemoveCreditCard
    [Tags]    QAD-46623
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Settings Tab
        Settings Tab_Payments
        Verify Saved Card
        Selfcare Logout
        Close Browser
        Stop Video Recording
    END
    END

Selfcare Consumer TC_Verify_AddFriend
    [Tags]    QAD-45359
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Settings Tab
        Settings Tab_Payments
        Settings Tab_Payments_Add Friends or Family_Postpaid
        Close Browser
        Stop Video Recording
    END
    END

Selfcare Consumer TC_Verify_RemoveFriend
    [Tags]    QAD-41101
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Settings Tab
        Settings Tab_Payments
        Remove Friends or Family_Postpaid
    #Selfcare Logout
        Close Browser
        Stop Video Recording
    END
    END

Selfcare TC_Verify_DeactivateAutoPayment
    [Tags]    QAD-46624
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Settings Tab
        Settings Tab_Payments
        Verify AutoPayment De-activated
        Close Browser
        Stop Video Recording
    END
    END

Usage history by filter By All
    [Tags]    QAD-56627
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Selfcare Login
        Check Usage History
        Close Browser
        Stop Video Recording
    END
    END

Selfcare Username & Change Password
    [Tags]    QAD-56628
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${SELFCARE_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData}
        Selfcare_VariableValueRetreive
        Start Video Recording
        Close Browser
        Stop Video Recording
    END
    END
