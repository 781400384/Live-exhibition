//
//  UIControl+Block.h
//  HomeWorld
//
//  Created by ZJQ on 2017/6/8.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Block)


- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(void(^)())actionBlock;


@end
