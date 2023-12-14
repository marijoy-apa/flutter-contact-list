class PO {
    search = '//*[@hint="Search"]'
    contactList = '//*[@content-desc="deleteBtn"]/parent::*'
    renderPage = '//*[@content-desc="deleteBtn"]/parent::*|//*[@content-desc="No Contacts"]'

    deleteBtn = '//*[@content-desc="deleteBtn"]'
    emergencyBtn = `//*[contains(@content-desc,"emergencyBtn")]`
    createCntctBtn = `//*[@content-desc="addContactBtn"]`
    contactsTabBtn = `//*[contains(@content-desc,"contactsTabBtn")]`
    emergencyTabBtn = `//*[contains(@content-desc,"emergencyListBtn")]`
    clearBtn = `//*[@content-desc="clearBtn"]`
    noSearchResult = `//*[@content-desc="noSearchResult"]`
    checkSpellingLabel = '//*[@content-desc="Check the spelling or try a new search."]'

    firstNameTF = '//*[@hint="First Name"]'
    lastNameTF = '//*[@hint="Last Name"]'
    cancelBtn = `//*[@content-desc="Cancel"]`
    doneBtn = `//*[@content-desc="Done"]`
    addPhoto = `//*[@content-desc="Add photo"]`
    phoneDropdown = `//*[@content-desc="Phone"]`
    phoneTF = '//*[@hint="Phone"]'
    mobileTF = '//*[@hint="Mobile"]'
    notesTF = `//*[@content-desc="Notes"]/following-sibling::*[1]`

    addPhoneBtn = `//*[@content-desc="Add phone"]`
    cameraCapture = `//*[@content-desc="Shutter"]`
    confirmCapture = `//*[@content-desc="Done"]`

    allowCalls = `//*[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]`
    endCalls = `//*[@content-desc="End call"]`

    callContactName = `//android.widget.TextView[@resource-id="com.google.android.dialer:id/contactgrid_contact_name"]`


    addToEmergencyContacts = `//*[@content-desc="Add to emergency contacts"]`
    removeFromEmergencyContacts = `//*[@content-desc="Remove from emergency contacts"]`
    field(name) {
        var xpath = `//*[@content-desc="${name}"]`
        return xpath;
    }
    text(name) {
        var xpath = `//*[@text="${name}"]`
        return xpath;
    }
}
module.exports = new PO();
