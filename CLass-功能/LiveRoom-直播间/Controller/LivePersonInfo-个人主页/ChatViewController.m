//
//  ChatViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
    UIButton  *  leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(13, y, 24*KScaleW,24*KScaleW);
    leftBtn.titleLabel.font = APP_MAIN_FONT;
    [leftBtn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.hidden=NO;
     self.navigationItem.rightBarButtonItem = nil;
    
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
 
@end
