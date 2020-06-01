//
//  ExhibitionListViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ExhibitionListViewController.h"
#import "MainCollectionViewCell.h"
#import "ExihibitionListModel.h"
#import "MainHandle.h"
#import "ExhibitionDetaiilViewController.h"
static NSString   *  const cellID=@"cellID";
@interface ExhibitionListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) int                                     page;
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;

@end

@implementation ExhibitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self collectionView];
    self.naviView.naviTitleLabel.text=@"近期展会";
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
-(void)loadData{
    [MainHandle getExhibitionListWithPage:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
              NSLog(@"DICC=%@",obj);
              if ([dic[@"code"] intValue]==200) {
                  if (self.page==1) {
                 self.dataList=[ExihibitionListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                  }else{
              [self.dataList addObjectsFromArray:[ExihibitionListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
                      
                  }
              }else{
                 
                  
              }
                [self.collectionView reloadData];
                [self.collectionView.mj_header endRefreshing];
              [self.collectionView.mj_footer endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    return CGSizeMake(SCREEN_WIDTH-30*KScaleW, 194.5*KScaleH);
  
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
    ExihibitionListModel   *  model=self.dataList[indexPath.row];
    ExhibitionDetaiilViewController   *  vc=[[ExhibitionDetaiilViewController alloc]init];
    vc.exhibitionId=[model.exhibition_id intValue];
    [self.navigationController pushViewController:vc animated:NO];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.typeLabel.hidden=YES;
    cell.watchImg.hidden=YES;
    cell.watchNum.hidden=YES;
    cell.titleLabel.font=APP_BOLD_FONT(16.0);
    cell.bgView.width=70*KScaleW;
    cell.exhibitionModel=self.dataList[indexPath.row];
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
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
