//
//  LoginViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LoginViewController.h"
#import "CoustomerLoginViewController.h"
#import "CompanyLoginViewController.h"
#import "HSSegmentView.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled=YES;
//    self.naviView.leftItemButton.hidden=YES;
   CoustomerLoginViewController * hvc=[[CoustomerLoginViewController alloc]init];
    __weak __typeof(self)weakSelf = self;
    hvc.loginSuccessBlock = ^{
    weakSelf.loginSuccessBlock();
    };
    CompanyLoginViewController * cvc=[[CompanyLoginViewController alloc]init];
    NSArray *controllers = @[hvc, cvc];
    NSArray *titleArray = @[@"观众登录", @"参展商登录"];
    cvc.loginSuccessBlock = ^{
      weakSelf.loginSuccessBlock();
      };
    HSSegmentView *hss = [[HSSegmentView alloc] initWithFrame:CGRectMake(0, self.naviView.bottom+10*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT - self.naviView.bottom-10*KScaleH) buttonName:titleArray contrllers:controllers parentController:self];
    hss.num=0;
    hss.userInteractionEnabled=YES;
    [self.view addSubview:hss];
    
  
}
@end
