//
//  UIAlertView+HWExt.h
//  HomeWorld
//
//  Created by ZJQ on 2017/5/12.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (HWExt)

/**
 自定义alertView
 
 @param title 标题
 @param messgae 内容
 @param cancelTitle 取消按钮标题
 @param confirmTitle 确定按钮标题
 @param cancel 取消回调
 @param confirm 确定回调
 @return <#return value description#>
 */
+ (instancetype)alertWithTitle:(NSString *)title messgae:(NSString *)messgae cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle cancel:(void(^)())cancel confirm:(void(^)())confirm;


@end
