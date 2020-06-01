//
//  ForgetBaseViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ForgetBaseViewController.h"
#import "CoustomerForgetViewController.h"
#import "CompanyForgetViewController.h"
#import "HSSegmentView.h"
@interface ForgetBaseViewController ()

@end

@implementation ForgetBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       CoustomerForgetViewController * hvc=[[CoustomerForgetViewController alloc]init];
       CompanyForgetViewController * cvc=[[CompanyForgetViewController alloc]init];
       NSArray *controllers = @[hvc, cvc];
       NSArray *titleArray = @[@"观众登录", @"参展商登录"];
       
       HSSegmentView *hss = [[HSSegmentView alloc] initWithFrame:CGRectMake(0, self.naviView.bottom+10*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT - self.naviView.bottom-10*KScaleH) buttonName:titleArray contrllers:controllers parentController:self];
       [self.view addSubview:hss];
}



@end
