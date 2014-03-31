#import <Cordova/CDV.h>
#import "Gimbal.h"

@implementation Gimbal

- (void)hello:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    NSString* message = [command.arguments objectAtIndex:0];

    NSLog(@"Inside Gimbal iOS! Your message: \"%@\"", message);
    
    // if (message != nil && [message length] > 0) {
    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    // } else {
    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    // }

    [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK, roundtrip."];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
