//
//  ExhibitionImageBigViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ExhibitionImageBigViewController.h"

@interface ExhibitionImageBigViewController ()

@end

@implementation ExhibitionImageBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor=[UIColor blackColor];
    UIImageView * Image=[[UIImageView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
      [Image sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"avatar_set_default"]];
      [self.view addSubview:Image];
    [self.naviView.leftItemButton setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
}



@end
