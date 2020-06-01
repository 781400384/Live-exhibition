//
//  UIView+extra.h
//  LCBarrage
//
//  Created by 冀柳冲 on 2017/5/10.
//  Copyright © 2017年 JLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色RGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//屏幕尺寸
#define Kratio [UIScreen mainScreen].bounds.size.width/375
#define KHratio [UIScreen mainScreen].bounds.size.height/667
#define UIScreenWidth  ((int)[UIScreen mainScreen].bounds.size.width)
#define UIScreenHeight ((int)[UIScreen mainScreen].bounds.size.height)



@interface UIView (extra)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@end
