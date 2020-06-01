//
//  UIButton+HWExt.m
//  HomeWorld
//
//  Created by ZJQ on 2017/5/25.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "UIButton+HWExt.h"




@implementation UIButton (HWExt)


- (void)beginCountDownWithDuration:(NSTimeInterval)duration {
   
    
    __block int timeout= duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.backgroundColor = APP_NAVI_COLOR;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self setTitle:[NSString stringWithFormat:@"%zds",timeout] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
                self.backgroundColor = [UIColor whiteColor];
//                self.layer.borderColor = [UIColor clearColor].CGColor;
                self.clipsToBounds = YES;
                [UIView commitAnimations];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


- (void)beginCountDownWithDuration:(NSTimeInterval)duration normalTitle:(NSString *)normalTitle callBack:(TimeEndCallBack)callBack {
    
    __block int timeout= duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:normalTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.backgroundColor = APP_NAVI_COLOR;
                callBack();
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self setTitle:[NSString stringWithFormat:@"%zds",timeout] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.backgroundColor = [UIColor lightGrayColor];
                self.layer.borderColor = [UIColor clearColor].CGColor;
                self.clipsToBounds = YES;
                [UIView commitAnimations];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}




@end
