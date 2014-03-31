#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <FYX/FYX.h>

@interface Gimbal : CDVPlugin

@property int count;

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appCallbackUrl;

- (void)setAppId:(NSString *)appId appSecret:(NSString *)appSecret callbackUrl:(NSString *)callbackUrl;
- (void)hello:(CDVInvokedUrlCommand*)command;

@end
