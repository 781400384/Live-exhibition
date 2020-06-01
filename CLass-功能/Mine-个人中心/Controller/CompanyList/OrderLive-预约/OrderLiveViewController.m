//
//  OrderLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "OrderLiveViewController.h"
#import "OrederLiveTableViewCell.h"
#import "MineHandle.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface OrderLiveViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong)BaseTableView   *   tableView;
@property (nonatomic, strong) NSMutableArray *   dataList;
@property (nonatomic, assign) int                page;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@end

@implementation OrderLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    self.naviView.naviTitleLabel.text=@"预约展览";
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
     [self setUpEmpty];
}
-(void)loadData{
    [MineHandle orderLiveWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token page:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"obj=%@",dic);
        if ([dic[@"code"] intValue]==200) {
            if (self.page==1) {
                self.dataList=[OrderLiveModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                [self.dataList addObjectsFromArray:[OrderLiveModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
            }
            [self.tableView reloadData];
        }else{
//            [self.view toast:dic[@"msg"]];
        }
        if (self.dataList.count==0) {
                   self.emptyImage.hidden=NO;
                   self.emptyLabel.hidden=NO;
                                                                         
               }else{
                 self.emptyImage.hidden=YES;
                 self.emptyLabel.hidden=YES;
               }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrederLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ OrederLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataList[indexPath.row];
    return cell;
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
- (BaseTableView *)tableView {
    
    if (!_tableView) {
        
        BaseTableView * tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 75*KScaleH;
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(void)setUpEmpty{
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_bg"]];
    self.emptyImage.frame=CGRectMake((SCREEN_WIDTH-75*KScaleW)/2, 253*KScaleH, 75*KScaleW, 75*KScaleW);
    self.emptyImage.contentMode=UIViewContentModeScaleAspectFill;
    self.emptyImage.clipsToBounds=YES;
    self.emptyImage.hidden=YES;
    [self.view addSubview:self.emptyImage];
    
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyImage.bottom+20.5*KScaleH, SCREEN_WIDTH, 13*KScaleH)];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.font=APP_NORMAL_FONT(16.0);
    self.emptyLabel.textColor=COLOR_999;
    self.emptyLabel.text=@"空空如也";
     self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    
    
   
    
}
@end
