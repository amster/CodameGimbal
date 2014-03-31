#import <Cordova/CDV.h>
#import "Gimbal.h"
#import <FYX/FYX.h>

@implementation Gimbal

- (void)setAppId:(NSString *)theAppId appSecret:(NSString *)theAppSecret callbackUrl:(NSString *)theCallbackUrl {
  self = [super init];
  
  self.appId = theAppId;
  self.appSecret = theAppSecret;
  self.appCallbackUrl = theCallbackUrl;
  
  [FYX setAppId:self.appId appSecret:self.appSecret callbackUrl:self.appCallbackUrl];
  
  return self;
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
