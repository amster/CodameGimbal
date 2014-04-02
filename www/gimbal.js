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
      function (parm) {
        t.startFYXVisitManager(function(){
          t.callGenericSuccessCallback(resultCallback, parm); 
        });
      },
      function (error) { t.callGenericFailureCallback(resultCallback, error); },
      "Gimbal", "initApp", [theAppId, theAppSecret, theCallbackUrl]
      );
};
Gimbal.prototype.getBeacons = function (resultCallback) {
  var t = this;
  return cordova.exec(
      resultCallback,
      function (error) { t.callGenericFailureCallback(resultCallback, error); },
      "Gimbal", "getBeacons", []
      );
};
Gimbal.prototype.startFYXVisitManager = function (resultCallback) {
  var t = this;
  return cordova.exec(
      function (parm) {
        t.callGenericSuccessCallback(resultCallback, parm);
      },
      function (error) {
        t.callGenericSuccessCallback(resultCallback, parm);
      },
      "Gimbal", "startFYXVisitManager", []
      );
};
Gimbal.prototype.stopFYXVisitManager = function () {
  var t = this;
  return cordova.exec(
      function (parm) { },
      function (error) { },
      "Gimbal", "stopFYXVisitManager", []
      );
};

module.exports = new Gimbal();
