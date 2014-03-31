#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <FYX/FYX.h>

@interface Gimbal : CDVPlugin

@property int count;

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appCallbackUrl;

- (void)initApp:(CDVInvokedUrlCommand*)command;
- (void)_initApp_:(NSString *)theAppId appSecret:(NSString *)theAppSecret callbackUrl:(NSString *)theCallbackUrl;

@end
