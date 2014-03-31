#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <FYX/FYX.h>

@interface Gimbal : CDVPlugin <FYXServiceDelegate, FYXVisitDelegate>

@property int count;

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appSecret;
@property (strong, nonatomic) NSString *appCallbackUrl;
@property BOOL isServiceStarted;
@property (strong, nonatomic) NSError *serviceStartedError;

@property (strong, nonatomic) NSMutableArray *beacons;
@property (strong, nonatomic) NSMutableArray *recentlyArrivedBeacons;
@property (strong, nonatomic) NSMutableArray *recentlyDepartedBeacons;

@property (nonatomic) FYXVisitManager *fyxVisitManager;

- (void)initApp:(CDVInvokedUrlCommand*)command;
- (void)_initApp_:(NSString *)theAppId appSecret:(NSString *)theAppSecret callbackUrl:(NSString *)theCallbackUrl;

- (void)startFYXVisitManager:(CDVInvokedUrlCommand*)command;
- (void)_startFYXVisitManager_;

- (void)stopFYXVisitManager:(CDVInvokedUrlCommand*)command;
- (void)_stopFYXVisitManager_;

@end
