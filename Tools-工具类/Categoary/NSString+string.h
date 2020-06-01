//
//  NSString+string.h
//  Project1
//
//  Created by iMac on 2019/10/16.
//  Copyright © 2019 ceo. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (string)
+ (NSString *)getVersion;
+ (NSString *)getBundleIdentifier;
/** 获取设备UUID */
+ (NSString *)getDeviceUUID;
+ (BOOL )tokenisValid;
+ (NSString *)kRandomAlphabetlength:(NSUInteger)length;

@end

NS_ASSUME_NONNULL_END
