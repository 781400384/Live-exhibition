//
//  UIButton+HWExt.h
//  HomeWorld
//
//  Created by ZJQ on 2017/5/25.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimeEndCallBack)();

@interface UIButton (HWExt)



- (void)beginCountDownWithDuration:(NSTimeInterval)duration;

- (void)beginCountDownWithDuration:(NSTimeInterval)duration normalTitle:(NSString *)normalTitle callBack:(TimeEndCallBack)callBack;


- (void)verticalImageAndTitle:(CGFloat)spacing;

@end
