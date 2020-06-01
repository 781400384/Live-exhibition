//
//  CreateLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CreateLiveViewController.h"

@interface CreateLiveViewController ()
@property (nonatomic, strong) UITableView       *      tableView;
@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"创建直播";
}
@end
