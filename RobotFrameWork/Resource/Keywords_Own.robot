*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Generate Tests
    Open Browser            about:blank     ${BROWSER}

# Access web page
Go To Web
    Load Web
    Verify Page Loaded
Load Web
    Go To                   ${URL}
Verify Page Loaded
    ${GET_TITLE}            Get Title
    Should Be Equal         ${GET_TITLE}        SpringPetclinicAngular
    Page Should Contain                         Welcome to Petclinic

Click Veterinarians
    Page Should Contain Element         xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]     #"Veterinarians" link
    Click Element                       xpath:/html/body/app-root/div[1]/nav/div/ul/li[3]

All Query
    Page Should Contain Element         //*[@routerlink="/vets"]    # click "all" link
    Click Element                       //*[@routerlink="/vets"]

    Page Should Contain                 Veterinarians
    Page Should Contain Element         //*[@id="vets"]
    Element Text Should be              //*[@id="vets"]/thead/tr/th[1]      Name
    Element Text Should be              //*[@id="vets"]/thead/tr/th[2]      Specialties

    # way_1: absoulte xpath
    Page Should Contain Button          xpath:/html/body/app-root/app-vet-list/div/div/div/button[1]
    Element Text Should Be              xpath:/html/body/app-root/app-vet-list/div/div/div/button[1]        Home

    # way_2: locating by element's text
    Page Should Contain Button          xpath://*[contains(text(),"Add Vet")]

    ${linenumber}=          Get Element Count       //*[@id="vets"]/tbody/tr
    Run keyword if          ${linenumber}>0         Verify Edit And Delete

Verify Edit And Delete
    Page Should Contain Element         //*[@id="vets"]/tbody/tr[1]/td[3]/button[1]
    Element Text Should be              //*[@id="vets"]/tbody/tr[1]/td[3]/button[1]     Edit Vet
    Page Should Contain Element         //*[@id="vets"]/tbody/tr[1]/td[3]/button[2]
    Element Text Should be              //*[@id="vets"]/tbody/tr[1]/td[3]/button[2]     Delete Vet


Quick Add Pet
    Page Should Contain Element         //*[@routerlink="/vets/add"]
    Click Element                       //*[@routerlink="/vets/add"]
    Wait Until Page Contains            New Veterinarian
    Page Should Contain Element         //*[@id="vet"]

Click Add Vet
    Click Button                        xpath://*[contains(text(),"Add Vet")]
    Page Should Contain                 New Veterinarian
    Page Should Contain Element         //*[@id="vet"]


Create New Pet
    [Arguments]                         ${firstname}        ${lastname}
    Page Should Contain Textfield       //*[@id="firstName"]
    Input Text                          //*[@id="firstName"]        ${firstname}
    Page Should Contain Textfield       //*[@id="lastName"]
    Input Text                          //*[@id="lastName"]         ${lastname}
    Page Should Contain List            //*[@id="specialties"]
    Click Element                       //*[@id="specialties"]
    # count how many options in the selecting list
    ${value_number}=        Get Element Count       //*[@id="specialties"]/option
    # get random number
    ${value}=               Evaluate        random.randint(0,${value_number}-1)
    ${value_str}=           Convert To String       ${value}
    # select randomly
    Select From List By Value           //*[@id="specialties"]     ${value_str}: Object

Confirm To Add New Pet
    [Arguments]             ${name}
    Click Button                        xpath://*[contains(text(), "Save Vet")]   # "Sava Vet" button
    Wait Until Page Contains            Veterinarians
    Wait Until Page Contains Element            //*[@id="vets"]/tbody
    Element Should Contain              //*[@id="vets"]/tbody   ${name}

Cancel To Add New Pet
    [Arguments]             ${name}
    Click Button                        //*[@id="vet"]/div[5]/div/button[1]     # "Back" button
    Wait Until Page Contains            Veterinarians
    Wait Until Page Contains Element            //*[@id="vets"]/tbody
    Element Should Not Contain          //*[@id="vets"]/tbody   ${name}

Edit Pet
    [Arguments]             ${name}        ${new_firstname}     ${new_lastname}     ${specialist}
    Click Button                        xpath=//td[contains(text(), "${name}")]/parent::tr/td[3]/button[1]
                                                                    #/parent::tr  look for parent element
    Wait Until Page Contains            Edit Veterinarian
    Clear Element Text                  //*[@id="firstName"]
    Input Text                          //*[@id="firstName"]        ${new_firstname}
    Clear Element Text                  //*[@id="lastName"]
    Input Text                          //*[@id="lastName"]         ${new_lastname}
    Click Element                       //*[@id="spec"]/div/div[2]/div
    Click Element                      //span[contains(text(), ${specialist})]/parent::mat-option//mat-pseudo-checkbox
    Press Keys                         None     ESC

Confirm to Edit
    [Arguments]                         ${newname}
    Click Button                        //button[contains(text(),"Save Vet")]
    Sleep                               10
    Element Should Contain              //*[@id="vets"]/tbody       ${newname}

Cancel Editing
    [Arguments]                         ${name}
    Click Button                        //button[contains(text(),"Back")]
    Sleep                               10
    Element Should Contain              //*[@id="vets"]/tbody       ${name}

Delete Pet
    [Arguments]                         ${name_to_delete}
    Click Button                        xpath=//td[contains(text(), "${name_to_delete}")]/parent::tr/td[3]/button[2]
    Wait Until Page Contains Element        //*[@id="vets"]/tbody
    Element Should Not Contain          //*[@id="vets"]/tbody           ${name_to_delete}

End the test
    # locating by attributes
    Click Link                          //*[@title="home page"]
    Wait Until Page Contains            Welcome to Petclinic
    Close Browser
