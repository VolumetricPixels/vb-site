if(process.env.NODETIME_ACCOUNT_KEY) {
    require('nodetime').profile({
        accountKey: process.env.NODETIME_ACCOUNT_KEY,
        appName: 'Volumetric Bans'
    });
}
require('coffee-script');
module.exports = require('./lib/application');
