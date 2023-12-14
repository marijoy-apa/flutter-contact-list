const assert = require('assert');
let PO;
let platform;
let attribute;
if (browser.capabilities['platformName'] === 'iOS') {
    PO = require('../pageObjects/iosPO');
    attribute = 'name';
    platform = 'iOS';
} else {
    PO = require('../pageObjects/contactsPO');
    attribute = 'content-desc';
    platform = 'android';
}


class ContactsPage {

    async searchForContact(contact) {
        const searchElement = await driver.$(PO.search);
        await searchElement.click();
        await this.pause(1000)
        await searchElement.setValue(contact)
        await this.pause(1000)
    }

    async setText(xpath, input) {
        const element = await driver.$(xpath);
        await element.click();
        await this.pause(500)
        await element.setValue(input)
        await this.pause(500)
    }
    async clickOn(xpath) {
        const element = await driver.$(xpath);
        await element.click();
    }

    async clearSearchResult() {
        const clearElement = await driver.$(PO.clearBtn);
        await clearElement.click();
        await this.waitXpathToNotExist(PO.clearBtn, 3000);
    }

    async clearTextField(xpath) {
        const clearElement = await driver.$(xpath);
        await this.setText(xpath, '');
    }

    async pause(milliseconds) {
        await new Promise(resolve => setTimeout(resolve, milliseconds));
    }

    async waitXpathToNotExist(xpath, milliseconds) {
        const element = await driver.$(xpath);
        await driver.waitUntil(async () => {
            return !(await element.isExisting());
        }, {
            timeout: milliseconds,
            timeoutMsg: 'Element still exists after the timeout',
            interval: 200,
        });
    }
    async waitXpathToExist(xpath, milliseconds) {
        const xpathExpression = xpath;
        const element = await driver.$(xpathExpression);
        await element.waitForDisplayed({ milliseconds });

    }

    async verifyXpathDisplayed(xpath) {
        const element = await driver.$(xpath);
        assert.strictEqual(await element.isDisplayed(), true, `Element with xpath ${xpath} should be displayed`)
    }

    async verifyXpathNotDisplayed(xpath) {
        const element = await driver.$(xpath);
        assert.strictEqual(await element.isExisting(), false, `Element with xpath ${xpath} should not exist`)
    }
    async emptyContactListPage() {
        await this.waitXpathToExist(PO.renderPage, 20000)
        const element = await driver.$$(PO.deleteBtn);
        var length = element.length;
        console.log(length)
        if (length != 0) {
            for (let index = element.length; index > 0; index--) {
                const xpath = `(${PO.deleteBtn})[${index}]`;
                (await driver.$(xpath)).click();
                await this.pause(1000);
            }
        }
    }

    async getXpathLength(xpath) {
        const element = await driver.$$(xpath);
        var length = element.length;
        return length;
    }

    async getAttributeValue(xpath, attribute) {
        const element = await driver.$(xpath);
        var attributeValue = await element.getAttribute(attribute);
        console.log(attributeValue)
        return attributeValue;
    }

    async createContactWithMultipleNumber() {
        await this.clickOn(PO.createCntctBtn);
        await this.clickOn(PO.field('Add phone'));
        await this.setText(PO.firstNameTF, 'Sangrea');

        await this.clickOn(PO.phoneDropdown)
        await this.clickOn(PO.field('Mobile'));
        await this.setText(PO.phoneTF, '32423423');

        await this.setText(PO.mobileTF, '0890898');
        await this.clickOn(PO.doneBtn);
    }

    async createNewContact(firstName, isEmergency) {
        await this.clickOn(PO.createCntctBtn);

        if (isEmergency == true) {
            await driver.hideKeyboard();
            await this.clickOn(PO.addToEmergencyContacts);
        }
        await this.setText(PO.firstNameTF, firstName);
        await this.setText(PO.phoneTF, '32423423');

        await this.clickOn(PO.doneBtn);
    }
    async verifyText(xpath, text) {
        var element = await driver.$(xpath);
        var gettext = await element.getText();
        console.log(gettext);
        assert.ok(gettext.trim().includes(text), 'Text should be the same')
    }


}
module.exports = new ContactsPage();

