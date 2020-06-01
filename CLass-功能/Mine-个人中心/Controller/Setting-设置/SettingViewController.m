//
//  SettingViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SettingViewController.h"
#import "MineHandle.h"
#import "SettingModel.h"
#import "SettingDetailViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *   tableView;
@property (nonatomic, strong) NSMutableArray    *   dataList;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"设置";
    [self loadData];
}
-(void)loadData{
    [MineHandle getSettingListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"obj==%@",obj);
//        [self.view toast:dic[@"msg"]];
        if ([dic[@"code"] intValue]==200) {
        self.dataList=[SettingModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.tableView reloadData];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell11"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.textLabel.text=[self.dataList[indexPath.row] valueForKey:@"type_name"];
     cell.textLabel.font=APP_NORMAL_FONT(16.0);
     cell.textLabel.textColor=COLOR_333;
     cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_next"]];
  
      UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(15*KScaleW, cell.height-0.5*KScaleH, SCREEN_WIDTH-30*KScaleW, 0.5*KScaleH)];
                lineView.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
              [cell addSubview:lineView];
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingModel  *  model=self.dataList[indexPath.row];
    SettingDetailViewController   *  vc=[[SettingDetailViewController alloc]init];
    vc.url=model.url;
    [self.navigationController pushViewController:vc animated:NO];
    vc.naviView.naviTitleLabel.text=model.type_name;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
        return self.dataList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50.0f;
        tableView.backgroundColor=[UIColor whiteColor];
//        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        
        tableView.tableFooterView=[self addFooterView];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

-(UIView *)addFooterView{
    UIView   *    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 61*KScaleH)];
    bgView.backgroundColor=[UIColor whiteColor];
    UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(30*KScaleW
                                                               , 10*KScaleH, SCREEN_WIDTH-60*KScaleW, 50.5*KScaleH)];
    btn.backgroundColor=APP_NAVI_COLOR;
    [btn setRadius:10.0];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
    btn.titleLabel.font=APP_NORMAL_FONT(18.0);
    [bgView addSubview:btn];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    return bgView;
}
-(void)logout{
    [UserInfoDefaults logoutUserInfo];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
