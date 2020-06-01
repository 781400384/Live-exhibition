//
//  SettingDetailViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SettingDetailViewController.h"
#import <WebKit/WebKit.h>
@interface SettingDetailViewController ()

@end

@implementation SettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      WKWebView *webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom)];
      [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webview];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
