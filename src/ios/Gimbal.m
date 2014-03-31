#import <Cordova/CDV.h>

#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>

#import "Gimbal.h"

@implementation Gimbal

- (void)initApp:(CDVInvokedUrlCommand*)command {
  NSArray *cArgs = command.arguments;
  CDVPluginResult* pluginResult = nil;

  NSString *theAppId = [cArgs objectAtIndex:0];
  NSString *theAppSecret = [cArgs objectAtIndex:1];
  NSString *theCallbackUrl = [cArgs objectAtIndex:2];
  
  if (theAppId == (id)[NSNull null] || [theAppId length] == 0) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing app ID"];
    NSLog(@"Returning error: 0");
  } else if (theAppSecret == (id)[NSNull null] || [theAppSecret length] == 0) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing app secret"];
    NSLog(@"Returning error: 1");
  } else if (theCallbackUrl == (id)[NSNull null] || [theCallbackUrl length] == 0) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing callback URL"];
    NSLog(@"Returning error: 2");
  } else {
    [self _initApp_:theAppId appSecret:theAppSecret callbackUrl:theCallbackUrl];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    NSLog(@"Returning success.");
  }
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)_initApp_:(NSString *)theAppId appSecret:(NSString *)theAppSecret callbackUrl:(NSString *)theCallbackUrl {
  self.appId = theAppId;
  self.appSecret = theAppSecret;
  self.appCallbackUrl = theCallbackUrl;
  
  [FYX setAppId:self.appId appSecret:self.appSecret callbackUrl:self.appCallbackUrl];
  
  [self startMonitoring];
}

- (void)startMonitoring {
  [FYX startService:self];
}

- (void)serviceStarted {
  self.isServiceStarted = YES;
  NSLog(@"FYX service initialized");
  
  [self initFYXVisitManager];
}

- (void)initFYXVisitManager {
  self.fyxVisitManager = [FYXVisitManager new];
  self.fyxVisitManager.delegate = self;
}

- (void)startFYXVisitManager:(CDVInvokedUrlCommand*)command {
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  
  [self _startFYXVisitManager_];
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)_startFYXVisitManager_ {
  [self.fyxVisitManager start];
  NSLog(@"FYX monitoring started");
}

- (void)startServiceFailed:(NSError *)error {
  self.serviceStartedError = error;
}

- (void)didArrive:(FYXVisit *)visit {
   NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI {
   NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
}
- (void)didDepart:(FYXVisit *)visit {
   NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
   NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
}
@end
