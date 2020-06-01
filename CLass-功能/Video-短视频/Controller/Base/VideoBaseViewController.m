//
//  VideoBaseViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VideoBaseViewController.h"
#import "HGSegmentedPageViewController.h"
#import "MainHandle.h"
#import "MainPageListModel.h"
#import "NewVideoViewController.h"
@interface VideoBaseViewController ()
@property (nonatomic, strong) HGSegmentedPageViewController *segmentedPageViewController;
@property (nonatomic, strong) NSMutableArray  *     dataList;
@end

@implementation VideoBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   self.naviView.hidden=YES;
    [self loadData];
}

- (void)addSegmentedPageViewController {
    [self addChildViewController:self.segmentedPageViewController];
    [self.view addSubview:self.segmentedPageViewController.view];
    [self.segmentedPageViewController didMoveToParentViewController:self];
    CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
     CGFloat  height=IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal;
    [self.segmentedPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-tabbar-height);
    }];
}

- (void)setupPageViewControllers {
    NSMutableArray *controllers = [NSMutableArray array];

    for (int i = 0; i < self.dataList.count; i++) {
        MainPageListModel  *  model=self.dataList[i];
            NewVideoViewController   *  mainVC=[NewVideoViewController new];
            [controllers addObject:mainVC];
//             mainVC.cateId=model.cate_id;
//        mainVC.height=_segmentedPageViewController.categoryView.height;
      
    }
    _segmentedPageViewController.pageViewControllers = controllers;
    _segmentedPageViewController.categoryView.backgroundColor=[UIColor clearColor];
    _segmentedPageViewController.view.backgroundColor=[UIColor clearColor];
    _segmentedPageViewController.categoryView.titles =[self.dataList valueForKey:@"title"];
    _segmentedPageViewController.categoryView.alignment = HGCategoryViewAlignmentLeft;
    _segmentedPageViewController.categoryView.originalIndex =0;
    _segmentedPageViewController.categoryView.topBorder.hidden = YES;
    _segmentedPageViewController.categoryView.titleNomalFont= [UIFont systemFontOfSize:16.0];
    _segmentedPageViewController.categoryView.titleSelectedFont= [UIFont boldSystemFontOfSize:18.0];
    _segmentedPageViewController.categoryView.titleNormalColor= COLOR_333;
    _segmentedPageViewController.categoryView.titleSelectedColor= [UIColor colorWithHexString:@"#101010"];
    _segmentedPageViewController.categoryView.vernier.backgroundColor= APP_NAVI_COLOR;
    [_segmentedPageViewController.categoryView setVernierHeight:3*KScaleH];
    [_segmentedPageViewController.categoryView setVernierWidth:15*KScaleW];
    [_segmentedPageViewController.categoryView setItemWidth:62.5*KScaleW];
    [_segmentedPageViewController.categoryView setItemSpacing:10*KScaleW];
    _segmentedPageViewController.categoryView.bottomBorder.hidden=YES;
    
}

#pragma mark Getters
- (HGSegmentedPageViewController *)segmentedPageViewController {
    if (!_segmentedPageViewController) {
        _segmentedPageViewController = [[HGSegmentedPageViewController alloc] init];
    }
    return _segmentedPageViewController;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(void)loadData{
    [MainHandle getMainPageInfoListWithSuccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
               if ([dic[@"code"] intValue]==200) {
                   self.dataList=[MainPageListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"category_list"]];
                   [self addSegmentedPageViewController];
                   [self setupPageViewControllers];
               }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
@end
