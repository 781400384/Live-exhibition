//
//  MainBaseViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MainBaseViewController.h"
#import "MainViewController.h"
#import "AttentionViewController.h"
#import "OtherViewController.h"
#import "MainHandle.h"
#import "MainPageListModel.h"
#import "HGSegmentedPageViewController.h"
#import "SearchMainViewController.h"
#import "LoginViewController.h"
@interface MainBaseViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) HGSegmentedPageViewController *segmentedPageViewController;
@property (nonatomic, strong) UITextField     *     searchTF;
@property (nonatomic, strong) NSMutableArray  *     dataList;
@property (nonatomic, strong) NSMutableArray  *     titleList;
@end

@implementation MainBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self configUI];
    self.naviView.hidden=YES;
}
#pragma mark - 配置UI
-(void)configUI{
        self.searchTF=[[UITextField alloc]initWithFrame:CGRectMake(15*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH-30*KScaleW, 30*KScaleH)];
         self.searchTF.backgroundColor=[UIColor whiteColor];
         [self.searchTF setRadius:15*KScaleH];
         self.searchTF.delegate=self;
         self.searchTF.tintColor=APP_NAVI_COLOR;
         self.searchTF.backgroundColor=RGB(244, 244, 244);
         [self.view addSubview:self.searchTF];
         UIImageView  *  leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_search"]];
         leftImage.frame=CGRectMake(0, 0, 43.9*KScaleW, 44.5*KScaleH);
         leftImage.contentMode=UIViewContentModeScaleAspectFit;
         NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"搜索你感兴趣的直播/视频/用户"];
         [placeholder addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:14.0]
                                 range:NSMakeRange(0, 15)];
         self.searchTF.attributedPlaceholder = placeholder;
         self.searchTF.leftView=leftImage;
         self.searchTF.leftViewMode=UITextFieldViewModeAlways;
        
    
          
}
- (void)addSegmentedPageViewController {
    [self addChildViewController:self.segmentedPageViewController];
    [self.view addSubview:self.segmentedPageViewController.view];
    [self.segmentedPageViewController didMoveToParentViewController:self];
    CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
    [self.segmentedPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchTF.mas_bottom).offset(10*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-tabbar-10*KScaleH-self.searchTF.height);
    }];
}

- (void)setupPageViewControllers {
    NSMutableArray *controllers = [NSMutableArray array];

    for (int i = 0; i < 2; i++) {
//        MainPageListModel   *  model=self.dataList[i];
        
        if (i==0) {
            AttentionViewController   *   attentionVC=[AttentionViewController new];
            [controllers addObject:attentionVC];
        }else{
            MainViewController   *  mainVC=[MainViewController new];
            [controllers addObject:mainVC];
        }
      
    }
    _segmentedPageViewController.pageViewControllers = controllers;
    [self.titleList addObject:@"关注"];
    [self.titleList addObject:@"推荐"];
//    [self.titleList addObjectsFromArray:[self.dataList valueForKey:@"title"]];
    _segmentedPageViewController.categoryView.titles =self.titleList;
    _segmentedPageViewController.categoryView.alignment = HGCategoryViewAlignmentLeft;
    _segmentedPageViewController.categoryView.originalIndex =1;
    _segmentedPageViewController.categoryView.topBorder.hidden = YES;
    _segmentedPageViewController.categoryView.titleNomalFont= [UIFont systemFontOfSize:16.0];
    _segmentedPageViewController.categoryView.titleSelectedFont= [UIFont boldSystemFontOfSize:18.0];
    _segmentedPageViewController.categoryView.titleNormalColor= COLOR_333;
    _segmentedPageViewController.categoryView.titleSelectedColor= [UIColor colorWithHexString:@"#101010"];
    _segmentedPageViewController.categoryView.vernier.backgroundColor= APP_NAVI_COLOR;
    [_segmentedPageViewController.categoryView setVernierHeight:3*KScaleH];
    [_segmentedPageViewController.categoryView setVernierWidth:15*KScaleW];
    [_segmentedPageViewController.categoryView setItemWidth:62.5*KScaleW];
#pragma mark - 动态计算标题长度
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
-(NSMutableArray *)titleList{
    if (!_titleList) {
        _titleList=[NSMutableArray array];
    }
    return _titleList;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([UserInfoDefaults isLogin]) {
        SearchMainViewController   *   vc=[[SearchMainViewController alloc]init];
           [self.navigationController pushViewController:vc animated:NO];
    }else{
        [self goLogin];
    }
   
    return NO;
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
