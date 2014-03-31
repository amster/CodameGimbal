var exec = require('cordova/exec');

/**
 * Constructor
 */
function Gimbal() {
}

Gimbal.prototype.hello = function (message) {
  return cordova.exec(function(parm){}, function(error){}, "Gimbal", "hello", [message]);
};
Gimbal.prototype.initApp = function (theAppId, theAppSecret, theCallbackUrl) {
  return cordova.exec(function(parm){}, function(error){}, "Gimbal", "initApp", [theAppId, theAppSecret, theCallbackUrl]);
};

module.exports = new Gimbal();
