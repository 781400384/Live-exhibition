//
//  VCTwoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VCTwoViewController.h"
#import "MyVideoOrLikeCollectionViewCell.h"
#import "MyVideoListModel.h"
#import "MyVideoLikeModel.h"
#import "MineHandle.h"
#import "MyVidePlayViewController.h"
static NSString   *  const cellID=@"cellID";
@interface VCTwoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                                      page;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@end

@implementation VCTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.collectionView registerClass:[MyVideoOrLikeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self collectionView];
 
        [self loadMyVideoData];
  
             self.page=1;
         self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
                
                self.page = 1;
            
                      [self loadMyVideoData];
                 
            }];
            self.collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
                
                self.page++;
              
                      [self loadMyVideoData];
                
            }];
     [self setUpEmpty];
    
}
-(void)loadMyVideoData{
    [MineHandle getMyVideoListWithUid:[self.uid intValue] token:[UserInfoDefaults userInfo].token page:self.page success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
           if ([dic[@"code"] intValue]==200) {
               if (self.page==1) {
                   self.dataList=[MyVideoListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
               }else{
                   [self.dataList addObjectsFromArray:[MyVideoListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
               }
               [self.collectionView reloadData];
               [self.collectionView.mj_header endRefreshing];
               [self.collectionView.mj_footer endRefreshing];
           }
       if (self.dataList.count==0) {
            self.emptyImage.hidden=NO;
            self.emptyLabel.hidden=NO;
                                                                  
        }else{
          self.emptyImage.hidden=YES;
          self.emptyLabel.hidden=YES;
        }
       } failed:^(id  _Nonnull obj) {
           
       }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake((SCREEN_WIDTH-45*KScaleW)/3, 128*KScaleH);
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
    MyVideoListModel   *  model=self.dataList[indexPath.row];
          MyVidePlayViewController   *  vc=[[MyVidePlayViewController alloc]init];
          [self.navigationController pushViewController:vc animated:NO];
          vc.model=model;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyVideoOrLikeCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

        cell.videoListModel=self.dataList[indexPath.row];
   
    return  cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7.5, 15, 7.5, 15 );
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 7.5;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 7.5;

}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *stretchyLayout= [UICollectionViewFlowLayout new];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
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
