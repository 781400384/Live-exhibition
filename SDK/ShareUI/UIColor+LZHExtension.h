//
//  UIColor+LZHExtension.h
//  LzhAlertView
//
//  Created by 刘中华 on 2019/12/10.
//  Copyright © 2019 LZH. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LZHExtension)

// 默认alpha位1
+ (UIColor *)colorWithString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
