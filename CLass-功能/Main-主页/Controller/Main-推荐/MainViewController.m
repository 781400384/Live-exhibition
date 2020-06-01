//
//  MainViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MainViewController.h"
#import "MainCollectionViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "ExhibitionListViewController.h"
#import "BannerListModel.h"
#import "LiveListModel.h"
#import "ExhibitionTypeListModel.h"
#import "ExihibitionListModel.h"
#import "MainHandle.h"
#import "RecordVideoPlayViewController.h"
#import "ExhibitionDetaiilViewController.h"
#import "RecordListViewController.h"
#import "LoginViewController.h"
#import "LiveCompanyInfoViewController.h"
#import "SettingDetailViewController.h"
#import "SeeLiveViewController.h"

#import "SeeLeftLiveViewController.h"
static NSString   *  const cellID=@"cellID";
static NSString   *  const headerID=@"headerID";

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, strong) SDCycleScrollView           *            cycleScrollView;
@property (nonatomic,strong) UIScrollView                 *            judgeScrollView;

@property (nonatomic, strong) NSMutableArray              *             bannerList;
@property (nonatomic, strong) NSMutableArray              *             liveList;
@property (nonatomic, strong) NSMutableArray              *             typeList;
@property (nonatomic, strong) NSMutableArray              *             exhibitionList;
@end

@implementation MainViewController

- (void)viewDidLoad {
   [super viewDidLoad];
    if (@available(iOS 10.0,*)) {
       self.collectionView.prefetchingEnabled = NO;
    }
     [self.view addSubview:self.collectionView];
    self.naviView.leftItemButton.hidden=YES;
                self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self loadData];
                }];
    
//    [self.collectionView.mj_header beginRefreshing];
   [self loadData];
}

-(void)loadData{
    [MainHandle getMainPageInfoListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",dic);
               if ([dic[@"code"] intValue]==200) {
                   self.bannerList=[BannerListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"slider_list"]];
                   self.liveList=[LiveListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"live_list"]];
                   self.typeList=[ExhibitionTypeListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"exhibition_type_list"]];
                    self.exhibitionList=[ExihibitionListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"exhibition_list"]];
                     NSLog(@"一共有多少航呢？=====%lu",(unsigned long)self.exhibitionList.count);
               }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failed:^(id  _Nonnull obj) {
        
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return CGSizeMake(SCREEN_WIDTH, 145*KScaleH );
    }else if(section==1){
         return CGSizeMake(SCREEN_WIDTH, 47*KScaleH );
    }else if(section==2){
        return CGSizeMake(SCREEN_WIDTH, 47*KScaleH );
    }else{
        return CGSizeMake(0,0);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   NSString *cellbbb = [NSString stringWithFormat:@"cellId%ld,%ld,%ld",(long)collectionView.tag,(long)indexPath.section,(long)indexPath.row];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellbbb];
    UICollectionReusableView *reusableview=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellbbb forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section==0) {
              _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15*KScaleW, 10*KScaleH, SCREEN_WIDTH-30*KScaleW, 125*KScaleH) delegate:self placeholderImage:[UIImage imageNamed:@"2.jpg"]];
              _cycleScrollView.currentPageDotColor=APP_NAVI_COLOR;
              _cycleScrollView.autoScrollTimeInterval = 3.0;
              _cycleScrollView.contentMode = UIViewContentModeScaleToFill;
              _cycleScrollView.clipsToBounds = YES;
              [_cycleScrollView setRadius:7.5*KScaleH];
            NSMutableArray *bannerUrlArray = [NSMutableArray array];
                                     for (BannerListModel *model in self.bannerList) {
                                         [bannerUrlArray addObject:[NSString stringWithFormat:@"%@",model.thumb]];
                                         self.cycleScrollView.imageURLStringsGroup = bannerUrlArray;
                }
              [reusableview addSubview:_cycleScrollView];
            
        }else if(indexPath.section==1){
            UILabel   *   titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 20*KScaleH, SCREEN_WIDTH-15*KScaleW, 17*KScaleH)];
            titleLabel.textAlignment=NSTextAlignmentLeft;
            titleLabel.font=APP_BOLD_FONT(18.0);
            titleLabel.text=@"正在直播";
            [reusableview addSubview:titleLabel];
        }else if(indexPath.section==2){
            UILabel   *   titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 20*KScaleH, SCREEN_WIDTH-70*KScaleW, 17*KScaleH)];
            titleLabel.textAlignment=NSTextAlignmentLeft;
            titleLabel.font=APP_BOLD_FONT(18.0);
            titleLabel.text=@"近期展会";
            [reusableview addSubview:titleLabel];
            
            UIButton  *   moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55*KScaleW, 22*KScaleH, 45*KScaleW, 14*KScaleW)];
            moreBtn.backgroundColor=[UIColor whiteColor];
            [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
            [moreBtn setImage:[UIImage imageNamed:@"main_next"] forState:UIControlStateNormal];
            moreBtn.titleLabel.font=APP_NORMAL_FONT(14.0);
            [moreBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            [reusableview addSubview:moreBtn];
            [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
            moreBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 33*KScaleW, 0, 0);
            moreBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -18*KScaleW, 0, 0);
        }
    }
    return reusableview;

}
-(void)more{
    ExhibitionListViewController  *  vc=[[ExhibitionListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
    printf("---点击了第%ld张图片\n",(long)index);
    if ([UserInfoDefaults isLogin]) {
    BannerListModel  *   model=self.bannerList[index];
    switch ([model.slider_type intValue]) {
        case 0:{
            //直播
            SeeLiveViewController   *  vc=[[SeeLiveViewController alloc]init];
                               
                                       [self.navigationController pushViewController:vc animated:NO];
                                 
                                 vc.liveUid=model.value;
            vc.liveType=@"0";
            
        }
            break;
        case 1:{
            //直播回放
            RecordVideoPlayViewController  *  vc=[[RecordVideoPlayViewController alloc]init];
                       if ([UserInfoDefaults isLogin]) {
                             [self.navigationController pushViewController:vc animated:NO];
                       }else{
                           [self goLogin];
                       }
                       vc.recordId=model.value;
            vc.type=@"0";}
            break;
        case 2:{
            //短视频
        }
            break;
        case 3:{
            //展会详情
            ExhibitionDetaiilViewController   *  vc=[[ExhibitionDetaiilViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.exhibitionId=[model.value intValue];
        }
            break;
        case 4:{
            //企业主页
            LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.uid=model.value;
        }
        break;
        case 5:{
            //跳转网页
            SettingDetailViewController  *  vc=[[SettingDetailViewController alloc]init];
             [self.navigationController pushViewController:vc animated:NO];
            vc.url=model.value;
            }
            break;
        default:
            break;
    }
        
    }else{
        [self goLogin];
    }
}
#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return CGSizeMake((SCREEN_WIDTH-40*KScaleW)/2, 114.5*KScaleH);
    }else if(indexPath.section==1){
        return CGSizeMake(SCREEN_WIDTH, 145.5*KScaleH);
    }else if(indexPath.section==2){
        if (indexPath.item==0) {
             return CGSizeMake(SCREEN_WIDTH-30*KScaleW, 194.5*KScaleH);
        }else{
            return CGSizeMake((SCREEN_WIDTH-40*KScaleW)/2, 114.5*KScaleH);
            
        }
    }else{
        return CGSizeMake(0, 0);
    }
}

#pragma mark - delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        if (self.liveList.count>4) {
            return 4;
        }else{
            return self.liveList.count;
            
        }
    }else if(section==1){
        return 1;
    }else if (section==2) {
        if (self.exhibitionList.count>3) {
            return 3;
        }else{
            return self.exhibitionList.count;
            
        }
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        LiveListModel  *  model=self.liveList[indexPath.row];
        if ([model.play_type intValue]==1) {
            RecordVideoPlayViewController  *  vc=[[RecordVideoPlayViewController alloc]init];
            if ([UserInfoDefaults isLogin]) {
                  [self.navigationController pushViewController:vc animated:NO];
            }else{
                [self goLogin];
            }
            vc.recordId=model.live_record_id;
            vc.type=@"0";
        

        }else{
//            SeeLeftLiveViewController  *  vc=[[SeeLeftLiveViewController alloc]init];
           SeeLiveViewController   *  vc=[[SeeLiveViewController alloc]init];
                       if ([UserInfoDefaults isLogin]) {
                             [self.navigationController pushViewController:vc animated:NO];
                       }else{
                           [self goLogin];
                       }
                       vc.liveUid=model.live_uid;
               vc.liveType=model.is_screen;
                    
        }
    }
    if (indexPath.section==2) {
        if ([UserInfoDefaults isLogin]) {
            ExihibitionListModel  *  model=self.exhibitionList[indexPath.row];
                   ExhibitionDetaiilViewController   *  vc=[[ExhibitionDetaiilViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:NO];
                   vc.exhibitionId=[model.exhibition_id intValue];
        }else{
            [self goLogin];
        }
       
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellAAA = [NSString stringWithFormat:@"cellId%ld,%ld,%ld",(long)collectionView.tag,(long)indexPath.section,(long)indexPath.row];
  [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellAAA];
    MainCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellAAA forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    if (indexPath.section==0) {
        cell.liveModel=self.liveList[indexPath.row];
        cell.typeLabel.hidden=YES;
    }
    if (indexPath.section==1) {
        cell.bgImage.hidden=YES;
        cell.titleLabel.hidden=YES;
       self.judgeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, cell.height)];
                   self.judgeScrollView.backgroundColor = [UIColor whiteColor];
                   self.judgeScrollView.showsHorizontalScrollIndicator = NO;
           self.judgeScrollView.contentSize = CGSizeMake(270*KScaleW*self.typeList.count, 0);
                   [cell addSubview:self.judgeScrollView];
        self.judgeScrollView.userInteractionEnabled=YES;
        for (int i=0; i<self.typeList.count; i++) {
            NSLog(@"%lu",(unsigned long)self.typeList.count);
            ExhibitionTypeListModel   *  model=self.typeList[i];
            UIImageView  *   image=[[UIImageView alloc]initWithFrame:CGRectMake(15*KScaleW+270*KScaleW*i, 0, 260*KScaleW, cell.height)];
            [image setRadius:7.5*KScaleH];
            image.clipsToBounds=YES;
            image.userInteractionEnabled=YES;
            UITapGestureRecognizer  *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                if ([UserInfoDefaults isLogin]) {
                    RecordListViewController  *  vc=[[RecordListViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:NO];
                    vc.naviView.naviTitleLabel.text=@"";
                     vc.typeId=model.exhibition_id;
                }else{
                    [self goLogin];
                }
               
            }];
            [image addGestureRecognizer:tap];
            [image sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"companyInfo_uploadImage  "]];
            [self.judgeScrollView addSubview:image];
            UILabel  *  typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(9.5*KScaleW, image.height-16.5*KScaleH, 150*KScaleW, 11.5*KScaleH)];
            typeLabel.textColor=[UIColor whiteColor];
            typeLabel.textAlignment=NSTextAlignmentLeft;
            typeLabel.font=APP_NORMAL_FONT(12);
            typeLabel.text=model.title;
            [image addSubview:typeLabel];
            UILabel  *  watchNum=[[UILabel alloc]init];
            watchNum.textColor=[UIColor whiteColor];
            CGFloat watchSize=[self getWidthWithTitle:model.play_num font:APP_NORMAL_FONT(12.0)];
            watchNum.frame=CGRectMake(image.width-watchSize-10*KScaleW, image.height-16.5*KScaleH, watchSize, 11.5*KScaleH);
            watchNum.textAlignment=NSTextAlignmentRight;
            watchNum.font=APP_NORMAL_FONT(12);
            watchNum.text=model.play_num;
            [image addSubview:watchNum];
            UIImageView  *  watchImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_watch"]];
            watchImg.frame=CGRectMake(watchNum.left-26.5*KScaleW, watchNum.centerY-8*KScaleH, 23*KScaleW, 16*KScaleH);
            watchImg.clipsToBounds=YES;
            watchImg.contentMode=UIViewContentModeScaleAspectFit;
            [image addSubview:watchImg];
        }
    }
     if (indexPath.section==2) {
         cell.exhibitionModel=self.exhibitionList[indexPath.row];
             }
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
        UICollectionViewFlowLayout *stretchyLayout= [[UICollectionViewFlowLayout alloc] init];
        CGFloat  tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        CGFloat  height=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar-46.5*KScaleH-height) collectionViewLayout:stretchyLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
       

    }
    return _collectionView;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
return NO;
}
-(NSMutableArray *)bannerList{
    if (!_bannerList) {
        _bannerList=[NSMutableArray array];
    }
    return _bannerList;
}
-(NSMutableArray *)liveList{
    if (!_liveList) {
        _liveList=[NSMutableArray array];
    }
    return _liveList;
}
-(NSMutableArray *)typeList{
    if (!_typeList) {
        _typeList=[NSMutableArray array];
    }
    return _typeList;
}
-(NSMutableArray *)exhibitionList{
    if (!_exhibitionList) {
        _exhibitionList=[NSMutableArray array];
    }
    return _exhibitionList;
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
//        [self.tableView reloadData];
    };
}
-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
