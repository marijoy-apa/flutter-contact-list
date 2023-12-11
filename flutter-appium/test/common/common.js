const find = require('appium-flutter-finder');
const assert = require('assert');


class Common {
    async isPresent(){
        try {
            driver.findElement()
            return true
        } catch(error) {
            console.log(error);
            return false;
        }
    }
}

