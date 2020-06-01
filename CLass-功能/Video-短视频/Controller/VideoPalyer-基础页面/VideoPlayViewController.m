//
//  VideoPlayViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "VideoHandle.h"
#import "VideoListModel.h"
#import "NewVideoCollectionViewCell.h"
#import "NewVideoViewController.h"
#import "LoginViewController.h"
static NSString   *  const cellID=@"cellID";
@interface VideoPlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                                     page;@end

@implementation VideoPlayViewController




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [self loadData];
     self.page=1;
     self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
                  
                  self.page = 1;
                 [self loadData];
     }];
              self.collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
                  
                  self.page++;
                 [self loadData];
              }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"视频";
    self.naviView.leftItemButton.hidden=YES;
     [self.collectionView registerClass:[NewVideoCollectionViewCell class] forCellWithReuseIdentifier:cellID];
}

-(void)loadData{
    [VideoHandle getVideoListWuthPage:self.page uid:[[UserInfoDefaults userInfo].uid intValue] cateId:@"all" success:^(id  _Nonnull obj) {
        NSLog(@"短视频数据=%@",obj);
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            if (self.page==1) {
                 self.dataList=[VideoListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                [self.dataList addObjectsFromArray:[VideoListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
            }
           
           [self.collectionView reloadData];
           [self.collectionView.mj_header endRefreshing];
           [self.collectionView.mj_footer endRefreshing];
           
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
         return CGSizeMake((SCREEN_WIDTH-30*KScaleW)/2, 235*KScaleH);
  
  
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
    if ([UserInfoDefaults isLogin]) {
        NewVideoViewController   *  vc=[[NewVideoViewController alloc]init];
           [self.navigationController pushViewController:vc animated:NO];
           VideoListModel  *  model=self.dataList[indexPath.row];
           vc.model=model;
    }else{
        [self goLogin];
        }
   
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewVideoCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor grayColor];
    [cell setRadius:5.0];
    cell.model=self.dataList[indexPath.row];
    return  cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10 );
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
        CGFloat tabbarHeight=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        CGFloat naviHeight=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-tabbarHeight-self.naviView.bottom) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
        [self loadData];
    };
}
@end
