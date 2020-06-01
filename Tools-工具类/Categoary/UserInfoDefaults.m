//
//  UserInfoDefaults.m
//  synw
//
//  Created by 纪先森丶 on 2018/9/20.
//  Copyright © 2018年 纪先森. All rights reserved.
//

#import "UserInfoDefaults.h"

@implementation UserInfoDefaults
+ (BOOL)isLogin {
    
    UserInfoModel *userInfo = [self userInfo];
    if (userInfo.token && ![userInfo.token isEmpty]) {
        return YES;
    }
    
    return NO;
}
+(void)saveValue:(id) value forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}


+(id)valueForKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}


+(BOOL)boolValueForKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}


+(void)saveBoolValue:(BOOL)value forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+ (void)saveUserInfo:(UserInfoModel *)userInfo{
    
    
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 开始归档
    [archiver encodeObject:userInfo forKey:@"userInfo"];
    
    // 归档结束.
    [archiver finishEncoding];
    
    // 写入本地
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfoFile"];
    
    [data writeToFile:file atomically:YES];
}

+ (UserInfoModel *)userInfo {
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfoFile"];
    
    NSData *data = [NSData dataWithContentsOfFile:file];
    if (data) {
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        UserInfoModel *userInfo = [unarchiver decodeObjectForKey:@"userInfo"];
        
        [unarchiver finishDecoding];
        
        return userInfo;
    }
    
    return nil;
}


+ (void)logoutUserInfo{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfoFile"];
    // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    // 删除
    [manager removeItemAtPath:filePath error:nil];
}

+(NSDictionary *)printAllUserDefault{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    
    return dic;
}

+ (void)removeUserDefaultForKey:(NSString *)key {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}
@end
