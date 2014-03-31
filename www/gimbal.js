var exec = require('cordova/exec');

/**
 * Constructor
 */
function Gimbal() {
}

Gimbal.prototype.hello = function (message) {
  console.log('hello from the prototype!');
  cordova.exec(function(parm){}, function(error){}, "Gimbal", "hello", [message]);
};

module.exports = new Gimbal();
