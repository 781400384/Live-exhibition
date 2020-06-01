//
//  NSString+string.m
//  Project1
//
//  Created by iMac on 2019/10/16.
//  Copyright © 2019 ceo. All rights reserved.
//

#import "NSString+string.h"

//#import <AppKit/AppKit.h>


@implementation NSString (string)
+ (NSString *)getVersion {
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)getBundleIdentifier{
       return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark 获取设备UUID
+ (NSString *)getDeviceUUID {
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    
    return (__bridge NSString *)(uuidStr);
}




@end
