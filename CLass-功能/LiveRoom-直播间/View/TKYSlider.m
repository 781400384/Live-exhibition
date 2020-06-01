
//
//  TKYSlider.m
//  StationHouseHelper
//
//  Created by apple on 2018/5/5.
//  Copyright © 2018年 铁科院. All rights reserved.
//

#import "TKYSlider.h"
//整个屏幕的宽
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//整个屏幕的高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//适配机型比例
#define kWidthScale (kScreenWidth / 375.0)
#define kHeightScale (kScreenHeight / 667.0)
@implementation TKYSlider


- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, kScreenWidth - kWidthScale *175, 7);
}


@end
