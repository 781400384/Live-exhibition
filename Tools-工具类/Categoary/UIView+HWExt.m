//
//  UIView+HWExt.m
//  HomeWorld
//
//  Created by ZJQian on 2017/6/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "UIView+HWExt.h"
#import <Toast/UIView+Toast.h>

@implementation UIView (HWExt)


- (void)toast:(NSString *)toastString {
    
    
    
    CSToastStyle *style = [[CSToastStyle alloc]initWithDefaultStyle];
    style.horizontalPadding = 10;
    style.verticalPadding = 5;
    style.backgroundColor=[UIColor lightGrayColor];
    style.titleColor=[UIColor colorWithHexString:@"#0B2137"];
    [self makeToast:toastString duration:5 position:CSToastPositionCenter style:style];

}


- (void)setRadius:(CGFloat)radius {

    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}


@end
