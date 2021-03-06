Gimbal Wrapper
==============

A light wrapper around the Qualcomm Gimbal FYX libraries. This *requires* you install your FYX libraries per these instructions:

* [Proximity iOS Quick Start](https://gimbal.com/doc/ios_proximity_quickstart.html)

Stuck? See also: [Gimbal XCode Project Help](https://gimbal.com/doc/proximity/ios_adding_frameworks_and_libraries.html)

You will need your beacons configured in a standard Gimbal mode, not iBeacon mode. Register and manage your beacons with:

* [Gimbal.com home page](https://gimbal.com)
* [Gimbal Beacon Manager App](https://itunes.apple.com/us/app/gimbal-beacon-manager/id785688563?mt=8)

Usage
-----

    // Initialize the Gimbal manager, start monitoring with the
    // FYX visit manager
    var theAppId = 'Your app ID',
        theAppSecret = 'Your app secret',
        theCallbackUrl = 'Your app callback URL',
        optionalResultCallback = function (result) { /* Do something */ };
    window.Gimbal.initApp(theAppId,
                          theAppSecret,
                          theCallbackUrl,
                          optionalResultCallback);
                        
    // Start monitoring for beacons
    window.Gimbal.startFYXVisitManager();
