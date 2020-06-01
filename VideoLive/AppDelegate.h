//
//  AppDelegate.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AFNetworkReachabilityManager.h>
typedef NS_ENUM(NSUInteger,ReachStatus){
    
    ReachStatusWiFi = 0,//WiFi
    ReachStatusWWAN,//手机数据
    ReachStatusUnable,//无网络
};
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, assign) ReachStatus                      reachStatus;
@property (nonatomic, assign) AFNetworkReachabilityStatus      reachabilityStatus;
@end

