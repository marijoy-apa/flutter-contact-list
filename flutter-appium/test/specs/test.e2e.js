const { expect, browser, $ } = require('@wdio/globals')

const find = require('appium-flutter-finder');
const assert = require('assert'); 

describe('Launch app and search ', () => {
    it('Verify delete icons displayed in each contact list', async () => {
        const button = find.byText('Triad Error');
        assert.strictEqual(await driver.getElementText(find.byText('Emergency List')), 'Emergency List');
        // await driver.elementSendKeys(find.byText('Search'), 'Triad')
        await driver.sendKeys(find.byText('Search'), 'Triad');
        
        // await driver.elementClick(button);


        // await driver.execute('flutter:waitFor', find.byText('Edit'));
        // await driver.elementClick(find.byValueKey('Edit'));

        // await driver.findElement(FlutterBy.VALUE_KEY)

    })
})

