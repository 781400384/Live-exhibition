//
//  MessageBaseViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MessageBaseViewController.h"
#import "MessageTableViewCell.h"
#import "LoginViewController.h"
@interface MessageBaseViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *    dataList;

@end

@implementation MessageBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
 
    if ([UserInfoDefaults isLogin]) {
         [self.tableView reloadData];
    }else{
        [self goLogin];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.leftItemButton.hidden=YES;
    self.naviView.naviTitleLabel.text=@"消息";
    
  
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
   cell= [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
   
    
    
  return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 70*KScaleH;
}
#pragma mark - tabbleView
-(BaseTableView *)tableView{
    if (!_tableView) {
         CGFloat  height=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
           _tableView= [[BaseTableView alloc] initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH,SCREEN_HEIGHT-self.naviView.bottom-height) style:UITableViewStylePlain];
           _tableView.delegate = self;
           _tableView.showsVerticalScrollIndicator = NO;
           _tableView.backgroundColor = [UIColor whiteColor];
           _tableView.dataSource = self;
           _tableView.separatorColor=[UIColor clearColor];
           [self.view addSubview:_tableView];
    }
   
    return _tableView;
    
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
        [self.tableView reloadData];
    };
}
@end
