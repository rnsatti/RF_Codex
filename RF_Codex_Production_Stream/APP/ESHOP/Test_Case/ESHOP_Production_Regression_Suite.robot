*** Settings ***
Suite Setup       Open_DatabaseConnection
Suite Teardown    Close_DatabaseConnection
Test Setup        ESHOP_VariableSetup_Testcase
Library           OperatingSystem    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson    #Suite Setup    ESHOP_MoveFileToArchive    #Suite Teardown    XrayResultsUpload    #Test Teardown    TestStatusUpdateJson
Library           RPA.Browser.Selenium
Library           ScreenCapLibrary
Library           String
Library           BuiltIn
Library           CSVLibrary
Resource          ../../CommonResources/Setup_TearDown.txt
Resource          ../Keywords/ESHOP_Keyword.txt
Resource          ../Config/Resources.txt
Resource          ../Locators/Eshop_Locators.txt
Library           DatabaseLibrary

*** Test Cases ***
ESHOP Latest ZTE AXON 10 PRO 5G
    [Tags]    QAD-11111
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Latest SAMSUNG Galaxy S22 Ultra 5G
    [Tags]    QAD-22222
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Latest Huawei Mate 20X 5G
    [Tags]    QAD-33333
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Best Seller Apple iPhone 12 Pro
    [Tags]    QAD-44444
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Best Seller Apple iPhone 13 Pro Max
    [Tags]    QAD-55555
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Best Seller Samsung Galaxy A52s
    [Tags]    QAD-66666
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers

ESHOP Best Seller AirPods Pro
    [Tags]    QAD-77777
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers
    Comment    Stop Video Recording

ESHOP Best Seller Watch Series 7 GPS
    [Tags]    QAD-88888
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers
    Comment    Stop Video Recording

ESHOP Load Personal Postpaid Power Plan
    [Tags]    QAD-99999
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Home    ${home_mobile_plan}    ${home_postpaid}
    ESHOP_Select_Postpaid_Plan    ${power_plan_125}    ${glide_bullet_2}
    ESHOP_Your_Cart
    ESHOP_Order_Summary
    ESHOP_Close_Browsers
    Comment    Stop Video Recording

ESHOP Go Personal Prepaid Plan
    [Tags]    QAD-12222
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Prepaid_Plan    ${Rate_Plan}
    ESHOP_Close_Browsers
    Comment    Stop Video Recording

ESHOP Latest Samsung Galaxy Note20 Ultra 5G
    [Tags]    QAD-13333
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Check_Product    ${Product_Name}
    ESHOP_Close_Browsers
    Comment    Stop Video Recording

ESHOP Acquire Postpaid Plan With Preferred Contract
    [Tags]    QAD-14444
    Comment    Start Video Recording
    ESHOP_Open_Browser    ${Eshop_URL}
    ESHOP_Home    ${home_mobile_plan}    ${home_postpaid}
    ESHOP_Select_Postpaid_Plan    ${power_plan_125}    ${glide_bullet_2}
    ESHOP_Your_Cart
    ESHOP_Order_Summary
    ESHOP_Close_Browsers
    Comment    Stop Video Recording
