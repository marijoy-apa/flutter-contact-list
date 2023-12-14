const { expect, browser, $ } = require('@wdio/globals')

const find = require('appium-flutter-finder');
const assert = require('assert');
const { timeout } = require('async');

describe('Create new contact', () => {

    it('Verify Add to emergency contacts is clickable', async () => {

        const addButton = find.byType('FloatingActionButton');
        assert.strictEqual(await driver.getElementText(find.byText('Emergency List')), 'Emergency List');
        await driver.elementClick(addButton);

        //click 'Add to emergency contacts'
        await driver.elementClick(find.byText('Add to emergency contacts'));
        driver.executeScript("flutter:waitFor", find.byText('Remove from emergency contacts'));
        assert.strictEqual(await driver.getElementText(find.byText('Remove from emergency contacts')), 'Remove from emergency contacts')
    });
    it('Verify Remove from emergency contacts is clickable', async () => {
        await driver.elementClick(find.byText('Remove from emergency contacts'));
        driver.executeScript("flutter:waitFor", find.byText('Add to emergency contacts'));
        assert.strictEqual(await driver.getElementText(find.byText('Add to emergency contacts')), 'Add to emergency contacts')

    });
    it('Clicking Add phone will add another field for phone dropdown', async () => {
        await driver.elementClick(find.byText('Add phone'));
        driver.executeScript("flutter:waitFor", find.byValueKey('numType-dropdown-button1'));
        assert.strictEqual(await driver.getElementText(find.byValueKey('numType-1')), 'Phone')
    });
    it('Clicking the dropdown should display the options for number type', async () => {
        await driver.elementClick(find.byValueKey('numType-dropdown-button1'));

        assert.strictEqual(await driver.getElementText(find.byText('Mobile')), 'Mobile')
        assert.strictEqual(await driver.getElementText(find.byText('Work')), 'Work')
        assert.strictEqual(await driver.getElementText(find.byText('Main')), 'Main')
        assert.strictEqual(await driver.getElementText(find.byText('Fax')), 'Fax')
        assert.strictEqual(await driver.getElementText(find.byText('Pager')), 'Pager')
        assert.strictEqual(await driver.getElementText(find.byText('Custom')), 'Custom')
        assert.strictEqual(await driver.getElementText(find.byText('Other')), 'Other')

    });
    it('Clicking a numtype option will update the textfield to the selected numType', async () => {
        await driver.elementClick(find.byText('Custom'));
        assert.strictEqual(await driver.getElementText(find.byValueKey('numType-1')), 'Custom')
    });
    it('Clicking cancel button should exit the create contact page', async () => {
        await driver.elementClick(find.byText('Cancel'));
        assert.strictEqual(await driver.getElementText(find.byText('Emergency List')), 'Emergency List')
    });
})
describe('Contact Details page', () => {
    it('Should be able to navigate to contact details page', async () => {
        driver.executeScript("flutter:waitFor", find.byText('Contacts'));

        await driver.elementClick(find.byText('Emergency List'));
        await driver.elementClick(find.byText('Contacts'));
        driver.executeScript("flutter:waitFor", find.byText('John'));
        await driver.elementClick(find.byValueKey('listItem'));


        driver.executeScript("flutter:waitFor", find.byText('Edit'));
        assert.strictEqual(await driver.getElementText(find.byText('Message')), 'Message')
        assert.strictEqual(await driver.getElementText(find.byText('Call')), 'Call')
        assert.strictEqual(await driver.getElementText(find.byText('Video')), 'Video')
        assert.strictEqual(await driver.getElementText(find.byText('Mail')), 'Mail')
    });


    it('Remove from emergency contacts button should be clickable', async () => {
        await driver.elementClick(find.byText('Remove from emergency contacts'));
        driver.executeScript("flutter:waitFor", find.byText('Add to emergency contacts'));
        assert.strictEqual(await driver.getElementText(find.byText('Add to emergency contacts')), 'Add to emergency contacts')

    });

    it('Add to emergency contacts button should be clickable', async () => {
        await driver.elementClick(find.byText('Add to emergency contacts'));
        driver.executeScript("flutter:waitFor", find.byText('Remove from emergency contacts'));
        assert.strictEqual(await driver.getElementText(find.byText('Remove from emergency contacts')), 'Remove from emergency contacts')
    });
})