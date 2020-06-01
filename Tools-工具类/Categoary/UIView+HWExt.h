//
//  UIView+HWExt.h
//  HomeWorld
//
//  Created by ZJQian on 2017/6/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HWExt)


/**
 提示 toast

 @param toastString <#toastString description#>
 */
- (void)toast:(NSString *)toastString;



/**
 设置圆角

 @param radius <#radius description#>
 */
- (void)setRadius:(CGFloat)radius;

@end
