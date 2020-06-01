//
//  LiveAlertView.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LiveAlertView.h"
@interface LiveAlertView()
@property (nonatomic, strong) UIImageView           *   alertView;

@end

@implementation LiveAlertView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView=[[UIImageView alloc]init];
        self.alertView.frame = CGRectMake(0,SCREEN_HEIGHT-150*KScaleH, SCREEN_WIDTH, 150*KScaleH);
        self.alertView.userInteractionEnabled=YES;
        self.alertView.contentMode=UIViewContentModeScaleAspectFit;
        self.alertView.image=[UIImage imageNamed:@"mine_radius"];
        [self addSubview:self.alertView];
       
        self.startLive=[[UIButton alloc]initWithFrame:CGRectMake(89*KScaleW, 12*KScaleH, 68*KScaleW, 87*KScaleH)];
        [self.startLive setImage:[UIImage imageNamed:@"mine_start_live"] forState:UIControlStateNormal];
        [self.startLive setTitle:@"立即直播" forState:UIControlStateNormal];
        self.startLive.titleLabel.font=APP_BOLD_FONT(14.0);
   [self.startLive setImageEdgeInsets:UIEdgeInsetsMake(-self.startLive.titleLabel.intrinsicContentSize.height-6*KScaleW, 0, 0, -self.startLive.titleLabel.intrinsicContentSize.width)];
                     [self.startLive setTitleEdgeInsets:UIEdgeInsetsMake(self.startLive.currentImage.size.height+6*KScaleW, -self.startLive.currentImage.size.width, 0, 0)];
        [self.startLive setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
        [self.alertView addSubview:self.startLive];
        
       self.startVideo=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-157*KScaleW, 12*KScaleH, 68*KScaleW, 87*KScaleH)];
               [self.startVideo setImage:[UIImage imageNamed:@"mine_start_video"] forState:UIControlStateNormal];
               [self.startVideo setTitle:@"拍摄视频" forState:UIControlStateNormal];
               self.startVideo.titleLabel.font=APP_BOLD_FONT(14.0);
             [self.startVideo setImageEdgeInsets:UIEdgeInsetsMake(-self.startVideo.titleLabel.intrinsicContentSize.height-6*KScaleW, 0, 0, -self.startVideo.titleLabel.intrinsicContentSize.width)];
               [self.startVideo setTitleEdgeInsets:UIEdgeInsetsMake(self.startVideo.currentImage.size.height+6*KScaleW, -self.startVideo.currentImage.size.width, 0, 0)];
               [self.startVideo setTitleColor:[UIColor colorWithHexString:@"#101010"] forState:UIControlStateNormal];
               [self.alertView addSubview:self.startVideo];
        
        UIButton  *  close=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20*KScaleW)/2, 115.5*KScaleH, 20*KScaleW, 20*KScaleW)];
        [close setImage:[UIImage imageNamed:@"mine_close"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:close];
    }
    return self;
}
-(void)close{
    [self dismissAlertView];
}
- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissAlertView {
    [UIView animateWithDuration:.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}

@end
