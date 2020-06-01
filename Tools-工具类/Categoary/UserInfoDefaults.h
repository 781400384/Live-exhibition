//
//  UserInfoDefaults.h
//  synw
//
//  Created by 纪先森丶 on 2018/9/20.
//  Copyright © 2018年 纪先森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface UserInfoDefaults : NSObject
/**
 是否登录
 
 @return <#return value description#>
 */
+ (BOOL)isLogin;

/**
 存值到本地
 
 @param value <#value description#>
 @param key <#key description#>
 */
+(void)saveValue:(id) value forKey:(NSString *)key;



/**
 从本地取值
 
 @param key <#key description#>
 @return <#return value description#>
 */
+(id)valueForKey:(NSString *)key;



/**
 保存 BOOL 型的数据到本地
 
 @param value <#value description#>
 @param key <#key description#>
 */
+(void)saveBoolValue:(BOOL)value forKey:(NSString *)key;



/**
 从本地取出 BOOL 型的数据
 
 @param key <#key description#>
 @return <#return value description#>
 */
+(BOOL)boolValueForKey:(NSString *)key;



/**
 将个人信息保存到本地
 
 @param userInfo <#userInfo description#>
 */
+ (void)saveUserInfo:(UserInfoModel *)userInfo;

/**
 从本地取出个人信息
 
 @return <#return value description#>
 */
+ (UserInfoModel *)userInfo;



/**
 注销本地个人信息
 */
+ (void)logoutUserInfo;



/**
 打印 UserDefault 存取的所有数据
 
 @return <#return value description#>
 */
+(NSDictionary *)printAllUserDefault;
/**
 移除 UserDefault 存储
 */
+ (void)removeUserDefaultForKey:(NSString *)key;
@end

