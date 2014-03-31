var exec = require('cordova/exec');
function Gimbal() { /* Don't add anything here. Only add prototypes. */ }

Gimbal.prototype.callGenericCallback = function (callback, isSuccessful, args) {
  if (callback) {
    callback.apply(this, [isSuccessful].concat(args));
  }
}
Gimbal.prototype.callGenericFailureCallback = function (callback, args) {
  this.callGenericCallback(callback, false, args);
}
Gimbal.prototype.callGenericSuccessCallback = function (callback, args) {
  this.callGenericCallback(callback, true, args);
}
Gimbal.prototype.initApp = function (theAppId, theAppSecret, theCallbackUrl, resultCallback) {
  var t = this;
  return cordova.exec(
      function (parm) { console.log('*** p1: ' + parm); t.callGenericSuccessCallback(resultCallback, parm); },
      function (error) { console.log('*** e1: ' + error); t.callGenericFailureCallback(resultCallback, error); },
      "Gimbal", "initApp", [theAppId, theAppSecret, theCallbackUrl]
      );
};

module.exports = new Gimbal();
