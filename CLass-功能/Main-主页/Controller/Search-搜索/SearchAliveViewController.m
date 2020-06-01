//
//  SearchAliveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SearchAliveViewController.h"
#import "MainCollectionViewCell.h"
#import "MainHandle.h"
#import "SearchLiveModel.h"
#import "RecordVideoPlayViewController.h"
#import "LoginViewController.h"
#import "SeeLiveViewController.h"
static NSString   *  const cellID=@"cellID";
@interface SearchAliveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                                      page;
@end

@implementation SearchAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
   [self loadDataWithKeyWord:self.keyWords];
        self.page=1;
      self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
             
             self.page = 1;
            [self loadDataWithKeyWord:self.keyWords];
         }];
         self.collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
             
             self.page++;
             [self loadDataWithKeyWord:self.keyWords];
         }];
}
-(void)loadDataWithKeyWord:(NSString *)keyWord{
    [MainHandle searchWithpage:self.page uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token keyWord:keyWord type:0 success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
               NSLog(@"%@",obj);
               if ([dic[@"code"] intValue]==200) {
                   if (self.page==1) {
                   self.dataList=[SearchLiveModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"live_list"]];
                   }else{
               [self.dataList addObjectsFromArray:[SearchLiveModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"live_list"]]];
                       
                   }
               }
                 [self.collectionView reloadData];
                [self.collectionView.mj_header endRefreshing];
               [self.collectionView.mj_footer endRefreshing];
    } failed:^(id  _Nonnull obj) {
        [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
    }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake((SCREEN_WIDTH-40*KScaleW)/2, 134.5*KScaleH);
}

#pragma mark - delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
        return self.dataList.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    SearchLiveModel  *  model=self.dataList[indexPath.row];
    if ([UserInfoDefaults isLogin]) {
        if ([model.play_type intValue]==1) {
            RecordVideoPlayViewController   *  vc=[[RecordVideoPlayViewController alloc]init];
            vc.recordId=model.live_record_id;
            vc.type=@"0";
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            SeeLiveViewController  *  vc=[[SeeLiveViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.liveUid=model.live_uid;
               vc.liveType=model.is_screen;
        }
    }else{
        [self goLogin];
    }
    
   
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.searchLiveModel=self.dataList[indexPath.row];
    SearchLiveModel  *   model=self.dataList[indexPath.row];
    return  cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15 );
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;

}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *stretchyLayout= [UICollectionViewFlowLayout new];
        CGFloat  height=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-46.5*KScaleH-height) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
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
//        [self.tableView reloadData];
    };
}
@end
