#import <Cordova/CDV.h>
#import "Gimbal.h"
#import <FYX/FYX.h>

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
  NSLog(@"Init'd FYX! %@, %@, %@", self.appId, self.appSecret, self.appCallbackUrl);
}

@end
