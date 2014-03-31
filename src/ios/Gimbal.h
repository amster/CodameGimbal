/*
 * A light wrapper around the Qualcomm Gimbal FYX libraries.
 * This REQUIRES you install your FYX libraries per these
 * instructions:
 *
 * https://gimbal.com/doc/ios_proximity_quickstart.html
 */

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <FYX/FYX.h>

@interface Gimbal : CDVPlugin

@property int count;

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appCallbackUrl;

- (id)initWithAppId:(NSString *)appId appSecret:(NSString *)appSecret callbackUrl:(NSString *)callbackUrl;
- (void)hello:(CDVInvokedUrlCommand*)command;

@end
