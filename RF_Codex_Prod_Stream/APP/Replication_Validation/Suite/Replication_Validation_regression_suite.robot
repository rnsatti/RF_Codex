*** Settings ***
Suite Setup       Replication_MoveFileToArchive
Default Tags      QAD-41696
Library           DateTime    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson
Library           RequestsLibrary
Resource          ../../CommonResources/Resources.txt
Library           OperatingSystem
Resource          ../Keywords/Replication_Keyword.txt
Resource          ../../CommonResources/Setup_TearDown.txt
Library           XML
Library           RPA.JSON
Library           RPA.Database
Library           RPA.Browser.Selenium
Library           RPA.Desktop
Library           ScreenCapLibrary
Library           String
Library           BuiltIn
Library           String
Library           SSHLibrary
Resource          ../Locators/Replication_locators.txt

*** Test Cases ***
Replication of Enterprise account creation to CRM
    [Tags]    QAD-49844
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
        Comment    Start Video Recording
        Replication_CRM Load URL
        Cache_Clearance
        Compatibility View Setting
        Replication_CRM Login
        Replication_CRM Search Account
        Replication_CRM Validate Enterprise Account Creation
        Comment    Stop Video Recording
    END
    END

Replication of Enterprise Postpaid contract to CRM
    [Tags]    QAD-49845
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
    #Start Video Recording
        Replication_CRM Load URL
        Cache_Clearance
        Compatibility View Setting
        Replication_CRM Login
        Replication_CRM Search For Contract
        Replication_CRM Find And Copy Contract Code
        Compare Contract Code
        Replication_CRM Find And Copy Rate Plan
        Compare RatePlan
    #Stop Video Recording
    END
    END

Replication of Change SIM for Consumer contract
    [Tags]    QAD-49846
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
        Comment    Start Video Recording
        Replication_CRM Load URL
        Cache_Clearance
        Compatibility View Setting
        Replication_CRM Login
        Get Account Code Change Sim
        Replication_CRM Search Account
        Replication_CRM Account Drilldown
        Replication_CRM Services And Installed Assets
        Replication_CRM Fetch Sim Number
        Replication_CRM Logout
        Close Browser
        Close Browser
        Sleep    10s
        Replication_BSCS Change Sim
        Sleep    10s
        Replication_CRM Check New Sim
        Replication_BSCS Compare Sim Number
        Sleep    5s
        Comment    Stop Video Recording
    END
    END

Replication of Mobile postpaid Activation in HPSA
    [Tags]    QAD-49849
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
    #Fetch Contract Code
        Open_BSCS_Browser
        Replication_BSCS Login
        Replication_BSCS ConsumerSalesClick
        Replication_BSCS SearchContract
        Replication_BSCS Search For Network
        Replication_BSCS Fetch Request ID Initial Activation
        Replication_HPSA Login
        Replication_Search With Request ID
        Replication_HSPA Validate CSDB
        Replication_HSPA Validate PCRF
        Replication_HSPA Validate SM
        Replication_HSPA Validate DPI
        Replication_HSPA Validate AES_REST
        Replication_HSPA Validate AIR
        Replication_HSPA Validate CIS
    #Start Video Recording
    END
    END

Replication of Mobile service Activation in HPSA
    [Tags]    QAD-49850
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Log    ${testData['LoadURL']}
    #Fetch Contract Code
        Replication_VariableValueRetreive
        Open_BSCS_Browser
        Replication_BSCS Login
        Replication_BSCS ConsumerSalesClick
        Replication_BSCS SearchContract
        Replication_BSCS Contract Overview Page
        Replication_BSCS Select services
        Replication_BSCS Configure services
        Sleep    30s
        MDSRRTAB Table Check
        Sleep    30s
        Replication_BSCS Search For Network
        Replication_BSCS Fetch Request ID Ref Text Assign Service
        Replication_HPSA Login
        Replication_Search With Request ID
        Replication_HSPA Validate DPI
    #Start Video Recording - on hold need clarification from amit.
    END
    END

Replication of Mobile Change SIM completion in HPSA
    [Tags]    QAD-49851
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
    #Fetch Contract Code
        Open_BSCS_Browser
        Replication_BSCS Login
        Replication_BSCS ConsumerSalesClick
        Replication_BSCS SearchContract
        Replication_BSCS Search For Network
        Replication_BSCS Fetch Request ID Change Port
        Replication_HPSA Login
        Replication_Search With Request ID
        Replication_HSPA Validate CSDB
        Replication_HSPA Validate PCRF
        Replication_HSPA Validate SM
        Replication_HSPA Validate AES_REST1
        Replication_HSPA Validate AES_REST2
    #Start Video Recording
    END
    END

Replication of Smart Offer activation in Enterprise to CRM
    [Tags]    QAD-49848
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
        Comment    Start Video Recording
        Replication_CRM Load URL
        Cache_Clearance
        Compatibility View Setting
        Replication_CRM Login
        Replication_CRM Search For Contract
        Replication_CRM Page Down 1
        Replication_CRM ExternalInfo
        Replication_CRM ForeclosureDetails
        Replication_CRM Validate Smart Offer Activation
        Comment    Stop Video Recording
    END
    END

Replication of Data Bundle activation in Enterprise to CRM
    [Tags]    QAD-49847
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
        Comment    Start Video Recording
        Replication_CRM Load URL
        Cache_Clearance
        Compatibility View Setting
        Replication_CRM Login
        Replication_CRM Search For Contract
        Replication_CRM Page Down 1
        Replication_CRM ExternalInfo
        Replication_CRM Databundle Details
        Replication_CRM Validate DataBundle Activation
        Comment    Stop Video Recording
    END
    END

Network Request : Mobile Deactivation validate completion in HPSA
    [Tags]    QAD-49852
    ${executionname}    Set Variable    @{TEST_TAGS}
    Log    ${executionname}
    @{dict}=    read csv file to associative    ${Replication_CSV_FILE}
    log many    ${dict}
    ${dictlen}=    Get length    ${dict}
    ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    ${dictlen}
        Log    ${executionname}
        IF    "${executionname}" == "${dict[${i}]['JiraID']}" and "${dict[${i}]['Flag']}" == "Y"
        ${testData}    BuiltIn.Set Variable    ${dict[${i}]}
        BuiltIn.Set Global Variable    ${testData}
        Replication_VariableValueRetreive
        Comment    Start Video Recording
        Open_BSCS_Browser
        Replication_BSCS Login
        Replication_BSCS ConsumerSalesClick
        Replication_BSCS SearchContract
        Replication_BSCS change contract status
        Open_BSCS_Browser
        Replication_BSCS Login
        Replication_BSCS ConsumerSalesClick
        Replication_BSCS SearchContract
        Replication_BSCS Fetch Request ID DeActivation
        Replication_HPSA Login
        Replication_Search With Request ID(Deactivation)
        Comment    Stop Video Recording
    END
    END
