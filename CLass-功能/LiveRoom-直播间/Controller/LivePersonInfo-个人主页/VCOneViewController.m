//
//  VCOneViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VCOneViewController.h"
#import "MyVideoOrLikeCollectionViewCell.h"
#import "CreateCompanyInfoViewController.h"
#import "MineHandle.h"
#import "CompanyImageListModel.h"
#import "CompanyInfoDetailViewController.h"
static NSString   *  const cellID=@"cellID";
@interface VCOneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                                      page;
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;

@end

@implementation VCOneViewController

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
     [self setUpEmpty];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self.collectionView registerClass:[MyVideoOrLikeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    self.naviView.naviTitleLabel.text=@"企业墙";
    [self.naviView.rightItemButton setImage:[UIImage imageNamed:@"companyInfo_image_add"] forState:UIControlStateNormal];
    [self.naviView.rightItemButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        CreateCompanyInfoViewController  *  vc=[[CreateCompanyInfoViewController alloc]init];
           [self.navigationController pushViewController:vc animated:NO];
    }];
   
}
-(void)loadData{
    [MineHandle getCompanyListWithUid:[self.uid intValue] token:[UserInfoDefaults userInfo].token page:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
             NSLog(@"obj==%@",dic);
//             [self.view toast:dic[@"msg"]];
                    if ([dic[@"code"] intValue]==200) {
                        if (self.page==1) {
                        self.dataList=[CompanyImageListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                        }else{
                    [self.dataList addObjectsFromArray:[CompanyImageListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
                            
                        }
                    }else{
                        
                        
                    }
        if (self.dataList.count==0) {
                   self.emptyImage.hidden=NO;
                   self.emptyLabel.hidden=NO;
                                                                         
               }else{
                 self.emptyImage.hidden=YES;
                 self.emptyLabel.hidden=YES;
               }
                      [self.collectionView reloadData];
                      [self.collectionView.mj_header endRefreshing];
                    [self.collectionView.mj_footer endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake((SCREEN_WIDTH-45*KScaleW)/3, 110*KScaleH);
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
    CompanyInfoDetailViewController  *  vc=[[CompanyInfoDetailViewController alloc]init];
      [self.navigationController pushViewController:vc animated:NO];
      CompanyImageListModel  *  model=self.dataList[indexPath.row];
      vc.companyId=model.user_wall_id;
      vc.userType=@"1";
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyVideoOrLikeCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor grayColor];
    cell.watchImg.image=[UIImage imageNamed:@"mine_praise_small"];
    cell.imageListModel=self.dataList[indexPath.row];
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
