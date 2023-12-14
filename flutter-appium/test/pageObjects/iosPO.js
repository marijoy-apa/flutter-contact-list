class PO {
    search = '//*[@name="Search"]'
    contactList = '//*[@name="deleteBtn"]/parent::*/XCUIElementTypeOther'
    renderPage = '//*[@name="deleteBtn"]/parent::*|//*[@name="No Contacts"]'

    deleteBtn = '//*[@name="deleteBtn"]'
    emergencyBtn = `//*[contains(@name,"emergencyBtn")]`
    createCntctBtn = `//*[@name="addContactBtn"]`
    contactsTabBtn = `//*[contains(@name,"contactsTabBtn")]`
    emergencyTabBtn = `//*[contains(@name,"emergencyListBtn")]`
    clearBtn = `//*[@name="clearBtn"]`
    noSearchResult = `//*[@name="noSearchResult"]`
    checkSpellingLabel = '//*[@name="Check the spelling or try a new search."]'

    firstNameTF = '//XCUIElementTypeTextField[@name="First Name"]'
    lastNameTF = '//XCUIElementTypeTextField[@name="Last Name"]'
    cancelBtn = `//*[@name="Cancel"]`
    doneBtn = `//*[@name="Done"]`
    addPhoto = `//*[@name="Add photo"]`
    phoneDropdown = `//*[@name="Phone" and @value="Phone"]`
    phoneTF = '//XCUIElementTypeTextField[@name="Phone"]'
    mobileTF = '//XCUIElementTypeTextField[@name="Mobile"]'
    notesTF = `//*[@name="Notes"]/following-sibling::*[1]`

    addPhoneBtn = `//*[@name="Add phone"]`
    cameraCapture = `//*[@name="Shutter"]`
    confirmCapture = `//*[@name="Done"]`

    allowCalls = `//*[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]`
    endCalls = `//*[@name="End call"]`

    callContactName = `//android.widget.TextView[@resource-id="com.google.android.dialer:id/contactgrid_contact_name"]`


    addToEmergencyContacts = `//*[@name="Add to emergency contacts"]`
    removeFromEmergencyContacts = `//*[@name="Remove from emergency contacts"]`
    field(name) {
        var xpath = `//*[@name="${name}"]`
        return xpath;
    }
    text(name) {
        var xpath = `//*[@value="${name}"]`
        return xpath;
    }
}
module.exports = new PO();
