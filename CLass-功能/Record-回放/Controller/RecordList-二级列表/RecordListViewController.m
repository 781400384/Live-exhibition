//
//  RecordListViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "RecordListViewController.h"
#import "MainCollectionViewCell.h"
#import "RecordVideoPlayViewController.h"
#import "RecordHandle.h"
#import "RecordListModel.h"
#import "SeeLiveViewController.h"
static NSString   *  const cellID=@"cellID";
@interface RecordListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView       *       emptyImage;
@property (nonatomic, strong) UILabel           *       emptyLabel;
@property (nonatomic, strong) UICollectionView            *           collectionView;
@property (nonatomic, strong) NSMutableArray              *            dataList;
@property (nonatomic, assign) int                                     page;
@end

@implementation RecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:cellID];
//    self.naviView.naviTitleLabel.text=@"回放";
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
-(void)loadData{
    

    
    [RecordHandle getRecordListSecWithPage:self.page exhibitionTypeId:self.typeId success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"obj==%@",dic);
       
               if ([dic[@"code"] intValue]==200) {
                   if (self.page==1) {
                   self.dataList=[RecordListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"live_list"]];
                   }else{
               [self.dataList addObjectsFromArray:[RecordListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"live_list"]]];
                       
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
  
     if (indexPath.section==0) {
         return CGSizeMake(SCREEN_WIDTH-20*KScaleW, 194.5*KScaleH);
     }else{
         return CGSizeMake((SCREEN_WIDTH-40*KScaleW)/2, 114.5*KScaleH);
     }
  
}

#pragma mark - delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        if (self.dataList.count==0) {
            return 0;
        }else{
            return 1;
            
        }
    }else{
        return self.dataList.count-1;
    }
       
   
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        
        RecordListModel   *  model=self.dataList[0];
        if ([model.play_type intValue]==1) {
           [self getVideoDetailWithVideoId:[model.live_record_id intValue]];
        }else{
           
        SeeLiveViewController   *  vc=[[SeeLiveViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        vc.liveUid=model.live_uid;
            vc.liveType=model.is_screen;
                    
        }
      
    }else{
        RecordListModel   *  model=self.dataList[indexPath.item+1];
       if ([model.play_type intValue]==1) {
           [self getVideoDetailWithVideoId:[model.live_record_id intValue]];
        }else{
        SeeLiveViewController   *  vc=[[SeeLiveViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        vc.liveUid=model.live_uid;
        vc.liveType=model.is_screen;
                    
        }
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor grayColor];
    cell.titleLabel.font=APP_BOLD_FONT(16.0);
    if (indexPath.section==0) {
        cell.recordListModel=self.dataList[0];
    }else{
        cell.recordListModel=self.dataList[indexPath.row+1];
    }
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
-(void)getVideoDetailWithVideoId:(int)videoId{
            RecordVideoPlayViewController   *  vc=[[RecordVideoPlayViewController alloc]init];
            vc.recordId=[NSString stringWithFormat:@"%d",videoId];
            vc.type=@"0";
            [self.navigationController pushViewController:vc animated:NO];
    
}
-(void)setUpEmpty{
    self.emptyImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_bg"]];
    self.emptyImage.frame=CGRectMake((SCREEN_WIDTH-250*KScaleW)/2, 253*KScaleH, 250*KScaleW, 211*KScaleW);
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
