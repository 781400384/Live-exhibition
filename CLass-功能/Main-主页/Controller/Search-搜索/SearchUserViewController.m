//
//  SearchUserViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SearchUserViewController.h"
#import "SearchUserTableViewCell.h"
#import "SearchUserModel.h"
#import "MainHandle.h"
#import "LivePersonInfoViewController.h"
#import "LiveCompanyInfoViewController.h"
#import "LoginViewController.h"
@interface SearchUserViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView     *      tableView;
@property (nonatomic, strong) NSMutableArray    *    dataList;
@property (nonatomic, assign) int                    page;
@end

@implementation SearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
      [self loadData];
      [self.tableView shouldAddHeaderRefresh:YES];
      [self.tableView shouldAddFooterRefresh:YES];
      __weak typeof(self)weakSelf = self;
      self.tableView.headerRefreshBlock = ^{
          
          weakSelf.page = 1;
          [weakSelf loadData];
      };
      self.tableView.footerRefreshBlock = ^{
        
          weakSelf.page++;
          [weakSelf loadData];
          
          
      };
}
-(void)loadData{
    [MainHandle searchWithpage:self.page uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token keyWord:self.keyWords type:2 success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
                     NSLog(@"abc==%@",dic);
                     if ([dic[@"code"] intValue]==200) {
                         if (self.page==1) {
                             self.dataList=[SearchUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"user_list"]];
                         }else{
                             [self.dataList addObjectsFromArray:[SearchUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"user_list"]]];
                         }
                         [self.tableView reloadData];
                         
                     }else{
//                         [self.view toast:dic[@"msg"]];
                     }
                     [self.tableView reloadData];
                     [self.tableView endRefreshing];
       } failed:^(id  _Nonnull obj) {
             [self.tableView endRefreshing];
       }];
   
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
    
   SearchUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
   cell= [[SearchUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataList[indexPath.row];
    [cell.attentionBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if ([UserInfoDefaults isLogin]) {
            if ([cell.model.is_follow intValue]==0) {
                 [self attentionWithUid:[cell.model.uid intValue]];
            }else{
                [self cancelAttentioinWithUid:[cell.model.uid intValue]];
            }
        }else{
            [self goLogin];
        }
       
    }];
    if ([UserInfoDefaults isLogin]) {
        if ([cell.model.user_type intValue]==0) {
                UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                      LivePersonInfoViewController   *  vc=[[LivePersonInfoViewController alloc]init];
                      [self.navigationController pushViewController:vc animated:NO];
                      vc.uid=cell.model.uid;
                
                    vc.userType=cell.model.is_follow;
                  }];
                  [cell.avatarImg addGestureRecognizer:tap];
           }else{
           UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
               LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
               [self.navigationController pushViewController:vc animated:NO];
               vc.showType=@"1";
               vc.uid=cell.model.uid;
               vc.userType=cell.model.is_follow;
           }];
           [cell.avatarImg addGestureRecognizer:tap];
               
           }
    }else{
        [self goLogin];
    }
   
    
    
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
         CGFloat  height=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
           _tableView= [[BaseTableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT-46.5*KScaleH-height) style:UITableViewStylePlain];
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
-(void)attentionWithUid:(int)Uid{
    [MainHandle attentionUserWithUserId:Uid uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
//            [self loadData];
        }
        NSLog(@"f点击关注返回的信息===%@",dic);
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)cancelAttentioinWithUid:(int)uid{
    [MainHandle cancelAttentionWithUserId:uid uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
               if ([dic[@"code"] intValue]==200) {
//                   [self loadData];
               }
               NSLog(@"f点击关注返回的信息===%@",dic);
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
//        [self.tableView reloadData];
    };
}
@end
