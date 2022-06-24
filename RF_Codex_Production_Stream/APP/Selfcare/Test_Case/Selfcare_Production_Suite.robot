*** Settings ***
Suite Setup       Open_DatabaseConnection    #Suite Setup    Selfcare_MoveFileToArchive
Suite Teardown    Close_DatabaseConnection
Test Setup        Selfcare_VariableSetup_Testcase
Library           DateTime    #Test Teardown    Close Browser    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson    #Suite Setup    Selfcare_MoveFileToArchive    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson
Resource          ../../CommonResources/Resources.txt
Library           OperatingSystem
Resource          ../Keywords/Selfcare_Keyword.txt
Library           XML
Library           RPA.JSON
Library           RPA.Database
Library           RPA.Browser.Selenium
Library           RPA.Desktop
Resource          ../Keywords/Selfcare_Locators.txt
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
    Selfcare_VariableValueRetreive
    #Start Video Recording
    Selfcare Login
    Close Browser
    #Stop Video Recording

Selfcare Consumer TC_Verify_AddCreditCard
    [Tags]    QAD-45357
    #Start Video Recording
    Selfcare Login
    Settings Tab
    Settings Tab_Payments
    Add Credit Card
    Verify Add Credit Card
    Close Browser
    #Stop Video Recording

Selfcare TC_Verify_PostpaidRemoveCreditCard
    [Tags]    QAD-46623
    #Start Video Recording
    Selfcare Login
    Settings Tab
    Settings Tab_Payments
    Verify Saved Card
    Selfcare Logout
    Close Browser
    #Stop Video Recording

Selfcare Consumer TC_Verify_AddFriend
    [Tags]    QAD-45359
    #Start Video Recording
    Selfcare Login
    Settings Tab
    Settings Tab_Payments
    Settings Tab_Payments_Add Friends or Family_Postpaid
    Close Browser
    #Stop Video Recording

Selfcare Consumer TC_Verify_RemoveFriend
    [Tags]    QAD-41101
    #Start Video Recording
    Selfcare Login
    Settings Tab
    Settings Tab_Payments
    Remove Friends or Family_Postpaid
    #Selfcare Logout
    Close Browser
    #Stop Video Recording

Selfcare TC_Verify_DeactivateAutoPayment
    [Tags]    QAD-46624
    #Start Video Recording
    Selfcare Login
    Settings Tab
    Settings Tab_Payments
    Verify AutoPayment De-activated
    Close Browser
    #Stop Video Recording

Usage history by filter By All
    [Tags]    QAD-56627
    #Start Video Recording
    Selfcare Login
    Check Usage History
    Close Browser
    #Stop Video Recording
