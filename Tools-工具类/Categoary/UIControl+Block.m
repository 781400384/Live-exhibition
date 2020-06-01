//
//  UIControl+Block.m
//  HomeWorld
//
//  Created by ZJQ on 2017/6/8.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "UIControl+Block.h"

#import <objc/message.h>


static char controlEventKey;

@implementation UIControl (Block)


-(void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(void (^)())actionBlock {
    
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
    
    objc_setAssociatedObject(self, &controlEventKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)callActionBlock:(id)sender {
    void (^block)() =  objc_getAssociatedObject(self, &controlEventKey);
    if (block)  block();
    
}



@end
