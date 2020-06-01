//
//  ToolTipView.m
//  LzhAlertView
//
//  Created by 刘中华 on 2019/12/11.
//  Copyright © 2019 LZH. All rights reserved.
//

#import "ToolTipView.h"
/* 屏幕尺寸 */
#define Screen_W   [UIScreen mainScreen].bounds.size.width
#define Screen_H   [UIScreen mainScreen].bounds.size.height

@implementation ToolTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+(void)showMessage:(NSString *)message offset:(CGFloat)offset
{
    UIWindow * window ;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 13.0){
        window = [[[UIApplication sharedApplication] windows] objectAtIndex:0] ;
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor redColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 6;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    if (message.length>0) {
        UILabel *label = [[UILabel alloc]init];
        NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        CGRect rect = [attributeStr boundingRectWithSize:CGSizeMake(300, 9000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        label.frame = CGRectMake(10, 7, rect.size.width+2.0, rect.size.height);
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.numberOfLines = 0;
        [showview addSubview:label];
        
        showview.frame = CGRectMake((Screen_W - rect.size.width - 20)/2, Screen_H/2.0+offset, rect.size.width+20, rect.size.height+15);
        [UIView animateWithDuration:1.5 animations:^{
            showview.alpha = 0.9;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
        }];
    }
}

@end
