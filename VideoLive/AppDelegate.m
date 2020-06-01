//
//  AppDelegate.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "BaseTabarViewController.h"
#import "LiveHandle.h"
static NSString *jgAppKey = @"c549a33bc0045ef4dd6d9a10";
static NSString *channel = @"App Store";
static BOOL isProduction = NO;
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch. [[IQKeyboardManager sharedManager]setEnable:YES];
         [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
         [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:YES];
         [self netWorkListener];
         BaseTabarViewController *  vc=[[BaseTabarViewController alloc]init];
                         BaseNavigationViewController  *  nav=[[BaseNavigationViewController alloc]initWithRootViewController:vc];
                         self.window.rootViewController = nav;
   [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
       NSLog(@"关闭直播间%@",obj);
       } failed:^(id  _Nonnull obj) {

   }];
#pragma mark- 连接融云服务器
    [[RCIM sharedRCIM] initWithAppKey:@"x18ywvqfx539c"];
     [self conneRongYun];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rongLogin:) name:LoginSuccessNotification object:nil];
#pragma mark - 腾讯云
   [TXUGCBase setLicenceURL:TXlicenceURL key:TXlicenceKey];
#pragma mark - 初始化Share
    [self initShare];
    
#pragma mark - 极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:jgAppKey
                           channel:channel
                  apsForProduction:isProduction
             advertisingIdentifier:nil];
    

    return YES;
}
-(void)rongLogin:(NSNotification *)wxLogin{
    [self conneRongYun];
}
-(void)conneRongYun{
    
    [[RCIM sharedRCIM]connectWithToken:[UserInfoDefaults userInfo].rongToken success:^(NSString *userId) {
                   NSLog(@"登陆成功。当前登录的用户融云ID：%@", userId);
                            RCUserInfo *user = [RCUserInfo new];
                               user.portraitUri = [UserInfoDefaults userInfo].head_path;
                               user.name = [UserInfoDefaults userInfo].nickname;
        RCUserInfo  *  userinfo=[[RCUserInfo alloc]initWithUserId:userId name:[UserInfoDefaults userInfo].nickname portrait:[UserInfoDefaults userInfo].head_path];
        [RCIM sharedRCIM].currentUserInfo=userinfo;
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
         [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableSyncReadStatus = YES;
         [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"融云错误码%ld",(long)status);
                } tokenIncorrect:^{
                    NSLog(@"融云Token错误");
                }];
}
#pragma mark -初始化Share
-(void)initShare{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupQQWithAppId:@"1109318150" appkey:@"kdDKtqircHpHLgW4"];
         [platformsRegister setupWeChatWithAppId:@"wx89f0e904ac8de0a6" appSecret:@"ca0d6e0908f0ae14bd3cad21612bd4c0" universalLink:@"https://api.bjzhanbotest.com/phonelive/"];
    }];
}
#pragma mark - 网络判断
- (void)netWorkListener {
    
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                self.reachabilityStatus = AFNetworkReachabilityStatusUnknown;
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                self.reachabilityStatus = AFNetworkReachabilityStatusNotReachable;
                NSLog(@"没有网络(断网)");
                [self.window toast:@"当前无网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
  [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  //Optional
  NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

//// iOS 12 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
//  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//    //从通知界面直接进入应用
//  }else{
//    //从通知设置界面进入应用
//  }
//}
//
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//  // Required
//  NSDictionary * userInfo = notification.request.content.userInfo;
//  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//    [JPUSHService handleRemoteNotification:userInfo];
//  }
//  completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
//}

// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//  // Required
//  NSDictionary * userInfo = response.notification.request.content.userInfo;
//  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//    [JPUSHService handleRemoteNotification:userInfo];
//  }
//  completionHandler();  // 系统要求执行这个方法
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
   TXVodPlayer  *  player=[[TXVodPlayer alloc]init];
                            [player stopPlay];
                            [player removeVideoWidget];
   //进入后台
}
 
- (void)applicationDidBecomeActive:(UIApplication *)application
{
 
    NSLog(@"---applicationDidBecomeActive----");
    //进入前台
 TXVodPlayer  *  player=[[TXVodPlayer alloc]init];
                            [player stopPlay];
    [player removeVideoWidget];
     
}
@end
