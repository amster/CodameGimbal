#import <Cordova/CDV.h>
#import "Gimbal.h"
#import <FYX/FYX.h>

@implementation Gimbal

- (void)initApp:(CDVInvokedUrlCommand*)command {
  CDVPluginResult* pluginResult = nil;
  NSString* theAppId = [command.arguments objectAtIndex:0];
  NSString* theAppSecret = [command.arguments objectAtIndex:1];
  NSString* theCallbackUrl = [command.arguments objectAtIndex:2];
  
  if (theAppId == nil) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing app ID"];
  } else if (theAppSecret == nil) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing app secret"];
  } else if (theCallbackUrl == nil) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing callback URL"];
  } else {
    [self _initApp_:theAppId appSecret:theAppSecret callbackUrl:theCallbackUrl];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
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

- (void)hello:(CDVInvokedUrlCommand*)command {
  self.count += 1;
  
  CDVPluginResult* pluginResult = nil;
  NSString* message = [command.arguments objectAtIndex:0];

  NSLog(@"[%d] Inside Gimbal iOS! Your message: \"%@\"", self.count, message);
  
  // if (message != nil && [message length] > 0) {
  //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
  // } else {
  //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  // }

  [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK, roundtrip."];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
