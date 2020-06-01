//
//  AuthenticationViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"审核进度";
    
    [self configUI];
}

-(void)configUI{
    UIImageView     *    statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom+59*KScaleH, SCREEN_WIDTH, 50*KScaleH)];
    statusImage.image=[UIImage imageNamed:@"authentication_success_line"];
    statusImage.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:statusImage];
    
    UIImageView     *    logoImage=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-68*KScaleW)/2, statusImage.bottom+72*KScaleH, 68*KScaleW, 68*KScaleW)];
    logoImage.image=[UIImage imageNamed:@"authentication_success"];
    logoImage.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoImage];
    
    UILabel   *  noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, logoImage.bottom+9.5*KScaleH, SCREEN_WIDTH, 15.5*KScaleH)];
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    noticeLabel.font=APP_NORMAL_FONT(16.0);
    noticeLabel.textColor=COLOR_333;
    noticeLabel.text=@"恭喜您审核通过";
    [self.view addSubview:noticeLabel];
    
    UIButton   *  btn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-297.15*KScaleW)/2, noticeLabel.bottom+42*KScaleH, 297.15*KScaleW, 40*KScaleH)];
    btn.backgroundColor=APP_NAVI_COLOR;
    [btn setRadius:19.75*KScaleW];
    [btn setTitle:@"立即直播" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)btnClick:(UIButton *)sender{
    
}

@end
