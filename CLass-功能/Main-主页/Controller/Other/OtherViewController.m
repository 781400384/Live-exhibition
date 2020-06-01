//
//  OtherViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "OtherViewController.h"
#import "MainCollectionViewCell.h"
#import "MainHandle.h"
#import "LiveListModel.h"
#import "RecordVideoPlayViewController.h"

static NSString   *  const cellID=@"cellID";
@interface OtherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) int                                     page;
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpEmpty];
    [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellID];
      [self loadDataWithCateId:[self.cateId intValue]];
        self.page=1;
    self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
           self.page = 1;
          [self loadDataWithCateId:[self.cateId intValue]];
       }];
       self.collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
           
           self.page++;
          [self loadDataWithCateId:[self.cateId intValue]];
       }];
}
-(void)loadDataWithCateId:(int)cateId{
    [MainHandle getCategoaryWithCateId:cateId page:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"%@",obj);
        if ([dic[@"code"] intValue]==200) {
            if (self.page==1) {
            self.dataList=[LiveListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
        [self.dataList addObjectsFromArray:[LiveListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
                
            }
        }else{
             self.emptyImage.hidden=NO;
            self.emptyLabel.hidden=NO;
            
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
        return CGSizeMake((SCREEN_WIDTH-40*KScaleW)/2, 114.5*KScaleH);
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
   
        LiveListModel  *  model=self.dataList[indexPath.row];
        if ([model.play_type intValue]==1) {
            RecordVideoPlayViewController  *  vc=[[RecordVideoPlayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.recordId=model.live_record_id;
            vc.type=@"0";
        }else{
            
        }
   
  
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.liveModel=self.dataList[indexPath.row];
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
        CGFloat  tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        CGFloat  height=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar-46.5*KScaleH-height) collectionViewLayout:stretchyLayout];
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
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_empty_image"]];
    self.emptyImage.frame=CGRectMake((SCREEN_WIDTH-190*KScaleW)/2, 224.5*KScaleH, 190*KScaleW, 150*KScaleW);
    self.emptyImage.contentMode=UIViewContentModeScaleAspectFill;
    self.emptyImage.clipsToBounds=YES;
//    self.emptyImage.hidden=YES;
    [self.view addSubview:self.emptyImage];
    
    self.emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyImage.bottom, SCREEN_WIDTH, 15.5*KScaleH)];
    self.emptyLabel.textAlignment=NSTextAlignmentCenter;
    self.emptyLabel.font=APP_NORMAL_FONT(16.0);
    self.emptyLabel.textColor=[UIColor colorWithHexString:@"#666666"];
    self.emptyLabel.text=@"暂时没有相关信息哦~";
//    self.emptyLabel.hidden=YES;
    [self.view addSubview:self.emptyLabel];
    
    
   
    
}
@end
