//
//  AttentionViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "AttentionViewController.h"
#import "SearchUserTableViewCell.h"
#import "LivePersonInfoViewController.h"
#import "LiveCompanyInfoViewController.h"
#import "LoginViewController.h"
#import "SearchUserModel.h"
#import "MainHandle.h"
//#import "MainCollectionViewCell.h"
//static NSString   *  const cellID=@"cellID";
@interface AttentionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView     *      tableView;
//@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                    page;

@end

@implementation AttentionViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (![UserInfoDefaults isLogin]) {
//        [self goLogin];
       }else{
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.leftItemButton.hidden=YES;
//    [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellID];
//    [self collectionView];
   
}
-(void)loadData{
    [MainHandle getFollowListWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token page:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",dic);
        if ([dic[@"code"] intValue]==200) {
            if (self.page==1) {
                self.dataList=[SearchUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                [self.dataList addObjectsFromArray:[SearchUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
            }
        }
        if(self.dataList.count==0){
             [self.tableView setEmptyData];
             self.tableView.emptyDelegate=self;
            [self.tableView setEmptyImage:[UIImage imageNamed:@"empty_bg"]];
            self.tableView.emptyString=@"暂无数据";
        }
       
//        [self.view toast:dic[@"msg"]];
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
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
   cell= [[SearchUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell11"];
            }
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataList[indexPath.row];
    [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [cell.attentionBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self cancelAttentionWithUid:[cell.model.uid intValue]];
    }];
    if ([cell.model.user_type intValue]==0) {
         UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
               LivePersonInfoViewController   *  vc=[[LivePersonInfoViewController alloc]init];
               [self.navigationController pushViewController:vc animated:NO];
               vc.uid=cell.model.uid;
           }];
           [cell.avatarImg addGestureRecognizer:tap];
    }else{
    UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        vc.uid=cell.model.uid;
    }];
    [cell.avatarImg addGestureRecognizer:tap];
        
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
        CGFloat tabbar_heighr=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
           _tableView= [[BaseTableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT-46.5*KScaleH-height-tabbar_heighr) style:UITableViewStylePlain];
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
-(void)cancelAttentionWithUid:(int)uid{
    [MainHandle cancelAttentionWithUserId:uid uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
//           [self.view toast:dic[@"msg"]];
       
            [self loadData];
       } failed:^(id  _Nonnull obj) {
           
       }];
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
