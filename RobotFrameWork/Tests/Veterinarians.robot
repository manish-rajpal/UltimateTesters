*** Settings ***
Documentation        UI testing in PetClinic by Robot Framework
...                  this is to test funcitionalities of Veterinarians -- Feng
Resource             ../Resource/Keywords_Vet.robot
Library              SeleniumLibrary
Test Setup          Generate Tests
Test Teardown       End the test

*** Variables ***
${BROWSER}      chrome
${URL}          http://localhost:4200


*** Test Cases ***
User Can Access The Web
    [Documentation]         Web users can access the web
    [Tags]                  access
    Go To Web


*** Test Cases ***
Verify Veterinarians Access and Query For All
    [Documentation]         users can access the Veterinarians to query and add pets
    [Tags]                  veterinarians
    Go To Web
    Click Veterinarians
    All Query

*** Test Cases ***
Add Vets From All Qurey
    [Documentation]         users can add pets
    [Tags]                  adding
    Go To Web
    Click Veterinarians
    All Query
    Click Add Vet
    Create New Pet          Joe     Biden
    Confirm To Add New Pet      Joe Biden

Add Pet In Veterinarians Navigation
    [Documentation]        users can add pet in Veterinarians
    [Tags]                 quick adding
    Go To Web
    Click Veterinarians
    Quick Add Pet
    Create New Pet              Barack      Obama
    Confirm To Add New Pet          Barack Obama

Cancel Adding New Vet
    [Documentation]         users can cancel adding pets before comfirmation
    [Tags]                  cancel adding
    Go To Web
    Click Veterinarians
    All Query
    Click Add Vet
    Create New Pet          Bill     Clinton
    Cancel To Add New Pet       Bill Clinton

Edit Pet's Information
    [Documentation]         users can edit pet's information
    [Tags]                  edit
    Go To Web
    Click Veterinarians
    All Query
    Edit Pet                Barack Obama       Donald      Trump       dentistry
    Confirm to Edit         Donald Trump

Pet's Information Cancel
    [Documentation]         users can cancel editing pets
    [Tags]                  cancel editing
    Go To Web
    Click Veterinarians
    All Query
    Edit Pet                Joe Biden       Antony      Blinken       dentistry
    Cancel Editing          Joe Biden

Delete Specific Pet By Name
    [Documentation]         users can delete pets by pet's name
    [Tags]                  delete
    Go To Web
    Click Veterinarians
    All Query
    Delete Pet              Donald Trump