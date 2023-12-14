const { expect, browser, $ } = require('@wdio/globals')

const find = require('appium-flutter-finder');
const assert = require('assert');

const ContactsPage = require('../common/common');
const PO = require('../pageObjects/contactsPO');

describe('Create new contact Page', () => {

    it('Create New Contacts Page UI should display correctly', async () => {
        await ContactsPage.waitXpathToExist(PO.createCntctBtn, 10000)
        await ContactsPage.pause(1000);

        await ContactsPage.emptyContactListPage();
        await ContactsPage.clickOn(PO.createCntctBtn);

        await ContactsPage.waitXpathToExist(PO.firstNameTF, 3000);
        await ContactsPage.verifyXpathDisplayed(PO.firstNameTF);
        await ContactsPage.verifyXpathDisplayed(PO.lastNameTF);
        await ContactsPage.verifyXpathDisplayed(PO.phoneTF);
        await ContactsPage.verifyXpathDisplayed(PO.phoneDropdown);
        await ContactsPage.verifyXpathDisplayed(PO.cancelBtn);
        await ContactsPage.verifyXpathDisplayed(PO.doneBtn);
        await ContactsPage.verifyXpathDisplayed(PO.addPhoto);
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
        await ContactsPage.verifyXpathDisplayed(PO.addPhoneBtn);
    })

    it('Clicking Add Phone will add phone fields', async () => {
        await ContactsPage.clickOn(PO.addPhoneBtn);

        await ContactsPage.pause(1000)

        const phoneDrpdwn = await driver.$$(PO.phoneDropdown);
        const phoneTxtFld = await driver.$$(PO.phoneTF);

        assert.strictEqual(phoneDrpdwn.length, 2, 'Expected phone dropdown should be 2');
        assert.strictEqual(phoneTxtFld.length, 2, 'Expected phone textField should be 2');
    })

    it('Should be able to toggle Add to emergency contacts', async () => {
        await ContactsPage.clickOn(PO.addToEmergencyContacts);

        await ContactsPage.waitXpathToExist(PO.removeFromEmergencyContacts, 2000)
        await ContactsPage.verifyXpathDisplayed(PO.removeFromEmergencyContacts);
    })

    it('Should be able to toggle Remove from emergency contacts', async () => {
        await ContactsPage.clickOn(PO.removeFromEmergencyContacts);

        await ContactsPage.waitXpathToExist(PO.addToEmergencyContacts, 2000)
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
    })

    it('Select Number Type dialog should pops up when clicking the Number dropdown', async () => {
        await ContactsPage.clickOn(PO.phoneDropdown);

        await ContactsPage.waitXpathToExist(PO.field('Mobile'), 2000)
        await ContactsPage.verifyXpathDisplayed(PO.field('Mobile'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Work'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Main'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Fax'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Pager'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Custom'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Other'));

    })

    it('Should be able to change the numType', async () => {
        await ContactsPage.clickOn(PO.field('Mobile'));

        await ContactsPage.waitXpathToNotExist(PO.field('Custom'), 2000)
        await ContactsPage.verifyXpathDisplayed(PO.mobileTF)
        await ContactsPage.verifyXpathDisplayed(PO.field('Mobile'))
    })

    it('Clicking Add photo should be able to capture an image', async () => {
        await ContactsPage.clickOn(PO.addPhoto);
        await ContactsPage.clickOn(PO.cameraCapture);
        await ContactsPage.waitXpathToExist(PO.confirmCapture, 20000);
        await ContactsPage.clickOn(PO.confirmCapture);
        await ContactsPage.waitXpathToExist(PO.field('Change photo'), 4000);
        await ContactsPage.verifyXpathDisplayed(PO.field('Change photo'));
    })
    it('Clicking Cancel button should exit the create new contacts page', async () => {
        await ContactsPage.clickOn(PO.cancelBtn);
        await ContactsPage.waitXpathToNotExist(PO.field('Change photo'), 20000);
        await ContactsPage.verifyXpathNotDisplayed(PO.field('Change photo'))
    })
    it('New Contact should not be created when First Name is empty', async () => {
        await ContactsPage.clickOn(PO.createCntctBtn);
        await ContactsPage.clickOn(PO.doneBtn);
        await ContactsPage.pause(2000)
        await ContactsPage.verifyXpathDisplayed(PO.doneBtn)

        await ContactsPage.setText(PO.firstNameTF, 'Elsa');
        await ContactsPage.clickOn(PO.doneBtn);

        await ContactsPage.pause(2000)
        await ContactsPage.verifyXpathDisplayed(PO.doneBtn);
        await ContactsPage.clickOn(PO.cancelBtn);
    })

    it('New Contact should not be created when phone field is empty', async () => {
        await ContactsPage.clickOn(PO.createCntctBtn);

        await ContactsPage.setText(PO.phoneTF, '0890898');
        await ContactsPage.clickOn(PO.doneBtn);

        await ContactsPage.pause(2000)
        await ContactsPage.verifyXpathDisplayed(PO.doneBtn)
    })

    it('New Contact should be created when First Name and phone field are populated', async () => {
        await ContactsPage.setText(PO.firstNameTF, 'Elsa');
        await ContactsPage.clickOn(PO.doneBtn);

        await ContactsPage.waitXpathToNotExist(PO.doneBtn, 10000);
        await ContactsPage.clickOn(PO.contactList);

        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);
        await ContactsPage.verifyXpathNotDisplayed(PO.contactList)
        await ContactsPage.verifyXpathDisplayed(PO.field('Elsa '));
        await ContactsPage.verifyXpathDisplayed(PO.field('0890898'));
        await ContactsPage.clickOn(PO.field('Contacts'));
    })
    it('New Contact should be created when all fields are populated', async () => {
        await ContactsPage.emptyContactListPage();

        await ContactsPage.clickOn(PO.createCntctBtn);
        await ContactsPage.setText(PO.notesTF, 'Test Note please ignore.');

        await ContactsPage.setText(PO.phoneTF, '0890898');
        await ContactsPage.setText(PO.firstNameTF, 'Luna');
        await ContactsPage.setText(PO.lastNameTF, 'Moon');
        await ContactsPage.clickOn(PO.addPhoto);
        await ContactsPage.clickOn(PO.cameraCapture);
        await ContactsPage.waitXpathToExist(PO.confirmCapture, 20000);
        await ContactsPage.clickOn(PO.confirmCapture);
        await ContactsPage.waitXpathToExist(PO.field('Change photo'), 4000);
        await ContactsPage.verifyXpathDisplayed(PO.field('Change photo'));

        await ContactsPage.clickOn(PO.addToEmergencyContacts);

        await ContactsPage.clickOn(PO.doneBtn);

        await ContactsPage.waitXpathToNotExist(PO.doneBtn, 10000);
        await ContactsPage.clickOn(PO.contactList);

        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);
        await ContactsPage.verifyXpathNotDisplayed(PO.contactList)

        await ContactsPage.verifyXpathDisplayed(PO.field('Luna Moon'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Test Note please ignore.'));
        await ContactsPage.verifyXpathDisplayed(PO.field('0890898'));
        await ContactsPage.verifyXpathDisplayed(PO.removeFromEmergencyContacts);
        await ContactsPage.clickOn(PO.field('Contacts'));


    })
})

describe('Contact details page screen', () => {

    it('Contact details page UI validation', async () => {

        await ContactsPage.clickOn(PO.contactList);

        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);

        await ContactsPage.verifyXpathDisplayed(PO.field('Message'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Call'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Video'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Mail'));

        await ContactsPage.verifyXpathDisplayed(PO.field('Phone'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Notes'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Edit'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Contacts'));

    })

    it('I should be able to make phone call directly for contacts with one number', async () => {
        await ContactsPage.clickOn(PO.field('Call'));
        await ContactsPage.clickOn(PO.allowCalls);
        await ContactsPage.waitXpathToExist(PO.endCalls, 10000);
        await ContactsPage.verifyXpathDisplayed(PO.endCalls);
        await ContactsPage.clickOn(PO.endCalls);

        await ContactsPage.clickOn(PO.field('Contacts'));
        await ContactsPage.waitXpathToExist(PO.contactList);


    })

    it('Multiple numbers should be displayed for contacts with multiple numbers', async () => {
        await ContactsPage.emptyContactListPage();
        await ContactsPage.createContactWithMultipleNumber();
        await ContactsPage.clickOn(PO.contactList);
        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);
        await ContactsPage.verifyXpathDisplayed(PO.field('Phone'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Mobile'));
        await ContactsPage.verifyXpathDisplayed(PO.field('32423423'));
        await ContactsPage.verifyXpathDisplayed(PO.field('0890898'));
        await ContactsPage.clickOn(PO.field('Contacts'));

        await ContactsPage.clickOn(PO.contactList);
        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);


    })
    it('Add/Remove emergency contacts should be clickable in Contact details page', async () => {
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
        await ContactsPage.clickOn(PO.addToEmergencyContacts);

        await ContactsPage.waitXpathToNotExist(PO.addToEmergencyContacts, 4000)
        await ContactsPage.verifyXpathDisplayed(PO.removeFromEmergencyContacts);

        await ContactsPage.clickOn(PO.removeFromEmergencyContacts);

        await ContactsPage.waitXpathToExist(PO.addToEmergencyContacts, 2000)
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
    })

    it('Phone number selection should pop up when clicking Call button with multiple contact number', async () => {
        await ContactsPage.clickOn(PO.field('Call'));

        await ContactsPage.waitXpathToExist(PO.field("0890898 (Mobile)"), 4000)
        await ContactsPage.verifyXpathDisplayed(PO.field("0890898 (Mobile)"));
        await ContactsPage.verifyXpathDisplayed(PO.field("32423423 (Phone)"));
    })

    it('Selecting a number should call the number', async () => {
        await ContactsPage.clickOn(PO.field("0890898 (Mobile)"));
        await ContactsPage.waitXpathToExist(PO.endCalls, 10000);
        await ContactsPage.verifyXpathDisplayed(PO.endCalls);
        await ContactsPage.verifyText(PO.callContactName, '0890898')
        await ContactsPage.clickOn(PO.endCalls);
    })

    it('Should be able to navigate to edit page when clicking Edit button', async () => {
        await ContactsPage.clickOn(PO.field("Edit"));
        await ContactsPage.waitXpathToExist(PO.field('Cancel'), 10000);
        await ContactsPage.verifyXpathDisplayed(PO.field("Add phone"));
    })

})

describe('Edit Contact page', () => {

    it('Edit contact page UI should properly displayed', async () => {
        await ContactsPage.verifyXpathDisplayed(PO.text('Sangrea'));
        await ContactsPage.verifyXpathDisplayed(PO.text('0890898'));
        await ContactsPage.verifyXpathDisplayed(PO.text('32423423'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Cancel'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Save'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Add photo'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Add phone'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Notes'));
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
        await ContactsPage.verifyXpathDisplayed(PO.phoneDropdown);
    })

    it('Clicking Add Phone will add phone fields', async () => {
        await ContactsPage.clickOn(PO.addPhoneBtn);
        await ContactsPage.pause(1000)

        const phoneDrpdwn = await driver.$$(PO.phoneDropdown);
        assert.strictEqual(phoneDrpdwn.length, 2, 'Expected phone dropdown should be 2');
    })

    it('Should be able to toggle Add to emergency contacts', async () => {
        await ContactsPage.clickOn(PO.addToEmergencyContacts);

        await ContactsPage.waitXpathToExist(PO.removeFromEmergencyContacts, 2000)
        await ContactsPage.verifyXpathDisplayed(PO.removeFromEmergencyContacts);
    })

    it('Should be able to toggle Remove from emergency contacts', async () => {
        await ContactsPage.clickOn(PO.removeFromEmergencyContacts);

        await ContactsPage.waitXpathToExist(PO.addToEmergencyContacts, 2000)
        await ContactsPage.verifyXpathDisplayed(PO.addToEmergencyContacts);
    })

    it('Select Number Type dialog should pops up when clicking the Number dropdown', async () => {
        await ContactsPage.clickOn(`(${PO.field('Phone')})[2]`);

        await ContactsPage.waitXpathToExist(PO.field('Main'), 2000)
        await ContactsPage.verifyXpathDisplayed(PO.field('Mobile'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Work'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Main'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Fax'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Pager'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Custom'));
        await ContactsPage.verifyXpathDisplayed(PO.field('Other'));

    })

    it('Should be able to change the numType', async () => {
        await ContactsPage.clickOn(PO.field('Mobile'));

        await ContactsPage.waitXpathToNotExist(PO.field('Custom'), 2000)
        await ContactsPage.verifyXpathDisplayed(PO.mobileTF)
        await ContactsPage.verifyXpathDisplayed(PO.field('Mobile'))
    })

    it('Clicking Add photo should be able to capture an image', async () => {
        await ContactsPage.clickOn(PO.addPhoto);
        await ContactsPage.clickOn(PO.cameraCapture);
        await ContactsPage.waitXpathToExist(PO.confirmCapture, 20000);
        await ContactsPage.clickOn(PO.confirmCapture);
        await ContactsPage.waitXpathToExist(PO.field('Change photo'), 4000);
        await ContactsPage.verifyXpathDisplayed(PO.field('Change photo'));
    })
    it('Clicking Cancel button should exit the create new contacts page', async () => {
        await ContactsPage.clickOn(PO.cancelBtn);
        await ContactsPage.waitXpathToNotExist(PO.field('Change photo'), 20000);
        await ContactsPage.verifyXpathNotDisplayed(PO.field('Change photo'))
    })
    it('Contact should not be updated when First Name is empty', async () => {
        await ContactsPage.clickOn(PO.field('Edit'));
        await ContactsPage.clickOn(PO.field('Save'));

        await ContactsPage.waitXpathToExist(PO.field('Cancel'), 10000);

        await ContactsPage.verifyXpathDisplayed(PO.field('Save'))
        await ContactsPage.verifyXpathDisplayed(PO.text('Sangrea'));
        await ContactsPage.clearTextField(PO.text('Sangrea'));

        await ContactsPage.clickOn(PO.field('Save'));
        await ContactsPage.pause(2000)
        await ContactsPage.verifyXpathDisplayed(PO.field('Save'));
    })

    it('Contact should not be updated when phone field is empty', async () => {
        await ContactsPage.clearTextField(PO.text('0890898'));
        await ContactsPage.clearTextField(PO.text('32423423'));

        await ContactsPage.setText(PO.firstNameTF, 'New Sangrea');
        await ContactsPage.clickOn(PO.field('Save'));
        await ContactsPage.pause(2000)
        await ContactsPage.verifyXpathDisplayed(PO.field('Save'));
    })
    it('Should be able to update contact when there are changes made in fields', async () => {
        await driver.hideKeyboard();
        await ContactsPage.clickOn(PO.addToEmergencyContacts);

        await ContactsPage.setText(PO.phoneTF, '12312321');
        await ContactsPage.setText(PO.notesTF, 'Edit test note. Please ignore');
        await ContactsPage.clickOn(PO.field('Save'));

        await ContactsPage.waitXpathToNotExist(PO.field('Save'), 10000);
        await ContactsPage.clickOn(PO.contactList);

        await ContactsPage.waitXpathToNotExist(PO.contactList, 10000);
        await ContactsPage.verifyXpathNotDisplayed(PO.contactList)

        await ContactsPage.waitXpathToExist(PO.field('New Sangrea '), 10000);

        await ContactsPage.verifyXpathDisplayed(PO.field('New Sangrea '));
        await ContactsPage.verifyXpathDisplayed(PO.field('Edit test note. Please ignore'));
        await ContactsPage.verifyXpathDisplayed(PO.field('12312321'));
        await ContactsPage.verifyXpathDisplayed(PO.removeFromEmergencyContacts);
        await ContactsPage.clickOn(PO.field('Contacts'));
    })
})

describe('Contact List page', () => {

    it('Delete icons should be displayed in each contact list', async () => {
        await ContactsPage.emptyContactListPage();
        await ContactsPage.createNewContact('Abegail', false);
        await ContactsPage.createNewContact('Bea', true);
        await ContactsPage.createNewContact('Caryl', true);

        assert.strictEqual(await ContactsPage.getXpathLength(PO.deleteBtn), 3, 'Delete button should be 3')
    })

    it('Emergency icons should be displayed in each contact list', async () => {
        assert.strictEqual(await ContactsPage.getXpathLength(PO.emergencyBtn), 3, 'Emergency button should be 3')
    })

    it('Emergency icon should change when emergency icon is toggled', async () => {
        await ContactsPage.clickOn(PO.emergencyTabBtn);
        await ContactsPage.clickOn(PO.contactsTabBtn);

        //adding to emergency 
        var icon = await ContactsPage.getAttributeValue(PO.emergencyBtn, 'content-desc');
        assert.strictEqual(icon, 'emergencyBtn-false', 'Emergency button should be false initially')
        await ContactsPage.clickOn(PO.emergencyBtn);
        await ContactsPage.pause(1000);
        icon = await ContactsPage.getAttributeValue(PO.emergencyBtn, 'content-desc');
        assert.strictEqual(icon, 'emergencyBtn-true', 'Emergency button should be updated to true')

        //removing from emergency
        await ContactsPage.clickOn(PO.emergencyBtn);
        await ContactsPage.pause(500);
        icon = await ContactsPage.getAttributeValue(PO.emergencyBtn, 'content-desc');
        assert.strictEqual(icon, 'emergencyBtn-false', 'Emergency button should be updated to false')

    })

    it('Contact item should be deleted when I click the delete button', async () => {
        const name = await ContactsPage.getAttributeValue(`(${PO.contactList})[1]`, 'content-desc');
        await ContactsPage.verifyXpathDisplayed(PO.field(name));
        await ContactsPage.clickOn(`(${PO.deleteBtn})[1]`)
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathNotDisplayed(PO.field(name));
    })
    it('I should be able to search invalid keyword', async () => {
        await ContactsPage.searchForContact('hello');
        await ContactsPage.verifyXpathDisplayed(PO.checkSpellingLabel);
        await ContactsPage.clearSearchResult();
    })

    it('I should be able to search valid keyword', async () => {
        await ContactsPage.searchForContact('Caryl');
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathDisplayed(PO.field('Caryl '))
        await ContactsPage.clearSearchResult();
    })
})

describe('Emergency List page', () => {

    it('Delete icons should be displayed in each emergency list', async () => {
        await ContactsPage.createNewContact('Abegail', false);
        await ContactsPage.createNewContact('Ann', true);

        await ContactsPage.clickOn(PO.emergencyTabBtn);
        await ContactsPage.pause(5000)
        assert.strictEqual(await ContactsPage.getXpathLength(PO.deleteBtn), 3, 'Delete button should be 3')
    })

    it('Only emergency contacts should be displayed in the emergency list', async () => {
        assert.strictEqual(await ContactsPage.getXpathLength(PO.emergencyBtn), 3, 'Emergency button should be 3')
        var icon = await ContactsPage.getAttributeValue(PO.emergencyBtn, 'content-desc');
        assert.strictEqual(icon, 'emergencyBtn-true', 'Emergency button should be to true')
        icon = await ContactsPage.getAttributeValue(`(${PO.emergencyBtn})[2]`, 'content-desc');
        assert.strictEqual(icon, 'emergencyBtn-true', 'Emergency button should be to true')
    })

    it('Contact item should be removed in Emergency list when I click its emergency icon', async () => {
        const name = await ContactsPage.getAttributeValue(`(${PO.contactList})[1]`, 'content-desc');
        await ContactsPage.verifyXpathDisplayed(PO.field(name));
        await ContactsPage.clickOn(`(${PO.emergencyBtn})[1]`)
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathNotDisplayed(PO.field(name));
    })

    it('Contact item should be removed in Emergency/Contact list when I click the delete button', async () => {
        const name = await ContactsPage.getAttributeValue(`(${PO.contactList})[1]`, 'content-desc');
        await ContactsPage.verifyXpathDisplayed(PO.field(name));
        await ContactsPage.clickOn(`(${PO.deleteBtn})[1]`)
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathNotDisplayed(PO.field(name));

        await ContactsPage.clickOn(PO.contactsTabBtn);
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathNotDisplayed(PO.field(name));
        await ContactsPage.clickOn(PO.emergencyTabBtn);
        await ContactsPage.pause(500);
    })

    it('I should be able to search invalid keyword', async () => {
        await ContactsPage.searchForContact('hello');
        await ContactsPage.verifyXpathDisplayed(PO.checkSpellingLabel);
        await ContactsPage.clearSearchResult();
    })

    it('I should be able to search valid keyword', async () => {
        await ContactsPage.searchForContact('Caryl');
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathDisplayed(PO.field('Caryl '))
        await ContactsPage.clearSearchResult();
    })

    it('No Emergency Contacts should display when Emergency Contact is empty', async () => {
        await ContactsPage.clickOn(PO.emergencyBtn);
        await ContactsPage.pause(500);
        await ContactsPage.verifyXpathDisplayed(PO.field('No Emergency Contacts'));
        await ContactsPage.verifyXpathDisplayed(PO.field("Emergency Contacts you've added will appear here"))
    })

    it('No Contacts should display when Emergency Contact is empty', async () => {
        await ContactsPage.clickOn(PO.contactsTabBtn);
        await ContactsPage.clickOn(PO.deleteBtn);
        await ContactsPage.pause(1000)
        await ContactsPage.clickOn(PO.deleteBtn);
        await ContactsPage.pause(1000)
        await ContactsPage.clickOn(PO.deleteBtn);
        await ContactsPage.pause(1000)
        await ContactsPage.verifyXpathDisplayed(PO.field('No Contacts'));
        await ContactsPage.verifyXpathDisplayed(PO.field("Contacts you've added will appear here"))
    })
})
