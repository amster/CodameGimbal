#import <Cordova/CDV.h>

#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>

#import "Gimbal.h"

#pragma mark - Visit utility class

@interface GimbalVisit : NSObject

@property (strong, nonatomic) NSNumber *rssi;
@property (strong, nonatomic) FYXVisit *visit;

- (id)initWithVisit:(FYXVisit *)theVisit rssi:(NSNumber *)theRssi;

@end

@implementation GimbalVisit

- (id)initWithVisit:(FYXVisit *)theVisit rssi:(NSNumber *)theRssi {
  self = [super init];
  
  self.visit = theVisit;
  self.rssi = theRssi;
  
  return self;
}

- (BOOL)isEqual:(id)anObject {
  GimbalVisit *otherVisit = (GimbalVisit *)anObject;
  return (self.visit && self.visit.transmitter && self.visit.transmitter.identifier) ==
         (otherVisit.visit && otherVisit.visit.transmitter && otherVisit.visit.transmitter.identifier);
}

@end

#pragma mark - Main CODAME Gimbal manager

@implementation Gimbal

// - (Gimbal *)pluginInitialize {
//   self.isServiceStarted = NO;
//   self.serviceStartedError = nil;
// 
//   self.beacons = [[NSMutableArray alloc] init];
//   self.recentlyArrivedBeacons = [[NSMutableArray alloc] init];
//   self.recentlyDepartedBeacons = [[NSMutableArray alloc] init];
// 
//   return self;
// }

- (void)initApp:(CDVInvokedUrlCommand*)command {
  NSArray *cArgs = command.arguments;

  NSString *theAppId = [cArgs objectAtIndex:0];
  NSString *theAppSecret = [cArgs objectAtIndex:1];
  NSString *theCallbackUrl = [cArgs objectAtIndex:2];
  NSString *errorMessage;
  if (theAppId == (id)[NSNull null] || [theAppId length] == 0) {
    errorMessage = @"Missing app ID";
  } else if (theAppSecret == (id)[NSNull null] || [theAppSecret length] == 0) {
    errorMessage = @"Missing app secret";
  } else if (theCallbackUrl == (id)[NSNull null] || [theCallbackUrl length] == 0) {
    errorMessage = @"Missing callback URL";
  }
  
  if (errorMessage) {
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMessage];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  } else {
    // See:
    // http://docs.phonegap.com/en/edge/guide_platforms_ios_plugin.md.html#iOS%20Plugins_threading
    
    __weak Gimbal *blockSafeSelf = self;
    [self.commandDelegate runInBackground:^{
      CDVPluginResult* pluginResult = nil;
      [blockSafeSelf _initApp_:theAppId appSecret:theAppSecret callbackUrl:theCallbackUrl];

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
      [blockSafeSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
  }
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
  GimbalVisit *gv = [[GimbalVisit alloc] initWithVisit:visit rssi:nil];
  
  if (![self.recentlyArrivedBeacons containsObject:gv]) {
    [self.recentlyArrivedBeacons addObject:gv];
    NSLog(@"Gimbal didArrive: %@ (%@)", gv.visit.transmitter.name, gv.visit.transmitter.identifier);
  }
}

- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI {
  GimbalVisit *gv = [[GimbalVisit alloc] initWithVisit:visit rssi:RSSI];
  
  NSUInteger beaconIdx = [self.beacons indexOfObject:gv];
  if (beaconIdx == NSNotFound) {
    [self.beacons addObject:gv];
    NSLog(@"Gimbal receivedSighting: %@ (%@), %.2f power", gv.visit.transmitter.name, gv.visit.transmitter.identifier, gv.rssi);
  } else {
    self.beacons[beaconIdx] = gv;
    NSLog(@"Gimbal receivedSighting: %@ (%@), %.2f power UPDATING", gv.visit.transmitter.name, gv.visit.transmitter.identifier, gv.rssi);
  }
}

- (void)didDepart:(FYXVisit *)visit {
  GimbalVisit *gv = [[GimbalVisit alloc] initWithVisit:visit rssi:nil];
  
  if (![self.recentlyDepartedBeacons containsObject:gv]) {
    [self.recentlyDepartedBeacons addObject:gv];
    NSLog(@"Gimbal didDepart: %@ (%@), dwelled %.2f seconds", gv.visit.transmitter.name, gv.visit.transmitter.identifier, gv.visit.dwellTime);
  }
}

- (void)stopFYXVisitManager:(CDVInvokedUrlCommand*)command {
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  
  [self _stopFYXVisitManager_];
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)_stopFYXVisitManager_ {
  [self.fyxVisitManager stop];
  NSLog(@"FYX monitoring stopped");
}

@end
