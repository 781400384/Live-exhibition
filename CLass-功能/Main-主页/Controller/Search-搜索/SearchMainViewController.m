//
//  SearchMainViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SearchMainViewController.h"
#import "HGSegmentedPageViewController.h"
#import "SearchAliveViewController.h"
#import "SearchVideoViewController.h"
#import "SearchUserViewController.h"
#import "SearchMainTableViewCell.h"
#import "HGSegmentedPageViewController.h"
#define NeedStartMargin 10   // 首列起始间距
#define NeedFont 14   // 需求文字大小
#define NeedBtnHeight 25   // 按钮高度
#define RecordCount 5
#define SEARCH_HISTORY [[NSUserDefaults standardUserDefaults] arrayForKey:@"SearchHistory"]
static   NSString   *   const   cellID  = @"searchCell";
@interface SearchMainViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) HGSegmentedPageViewController *segmentedPageViewController;
@property (nonatomic, strong) UITextField     *      searchTF;
@property (nonatomic, strong) UITableView     *      tableView;
@property (nonatomic, strong) NSMutableArray  *      dataList;
@property (nonatomic, strong) NSArray         *      titleList;

@end

@implementation SearchMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.naviView.rightTitleLabel.text=@"取消";
    self.naviView.rightTitleLabel.textColor=COLOR_333;
    self.titleList=@[@"直播",@"视频",@"用户"];
    self.naviView.leftItemButton.hidden=YES;
}
-(void)rightTitleLabelTap{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)configUI{
    self.searchTF=[[UITextField alloc]initWithFrame:CGRectMake(15*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH-75*KScaleW, 30*KScaleH)];
            self.searchTF.backgroundColor=[UIColor whiteColor];
            [self.searchTF setRadius:15*KScaleH];
            self.searchTF.delegate=self;
            self.searchTF.tintColor=APP_NAVI_COLOR;
            self.searchTF.backgroundColor=RGB(244, 244, 244);
            [self.naviView addSubview:self.searchTF];
            UIImageView  *  leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_search"]];
            leftImage.frame=CGRectMake(0, 0, 43.9*KScaleW, 44.5*KScaleH);
            leftImage.contentMode=UIViewContentModeScaleAspectFill;
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"搜索你感兴趣的直播/视频/用户"];
            [placeholder addAttribute:NSFontAttributeName
                                    value:[UIFont systemFontOfSize:14.0]
                                    range:NSMakeRange(0, 15)];
            self.searchTF.attributedPlaceholder = placeholder;
            self.searchTF.leftView=leftImage;
            self.searchTF.leftViewMode=UITextFieldViewModeAlways;
            self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.searchTF.returnKeyType=UIReturnKeySearch;
#pragma mark - 历史搜索和热搜
    
     [self tableView];
    
#pragma mark - 搜索结果
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{   if(self.searchTF==textField){
    [self addSearchRecord:textField.text];
    [self.tableView removeFromSuperview];
    [self addSegmentedPageViewController];
    NSMutableArray *controllers = [NSMutableArray array];
                   SearchAliveViewController   *   aliveVC=[SearchAliveViewController new];
           aliveVC.keyWords=self.searchTF.text;
                   [controllers addObject:aliveVC];
                   SearchVideoViewController   *  videoVC=[SearchVideoViewController new];
           videoVC.keyWords=self.searchTF.text;
                   [controllers addObject:videoVC];
                   SearchUserViewController   *  userVC=[SearchUserViewController new];
           userVC.keyWords=self.searchTF.text;
                   [controllers addObject:userVC];
           _segmentedPageViewController.pageViewControllers = controllers;
           _segmentedPageViewController.categoryView.titles =self.titleList;
           _segmentedPageViewController.categoryView.alignment = HGCategoryViewAlignmentLeft;
           _segmentedPageViewController.categoryView.originalIndex =0;
           _segmentedPageViewController.categoryView.topBorder.hidden = YES;
           _segmentedPageViewController.categoryView.titleNomalFont= [UIFont systemFontOfSize:16.0];
           _segmentedPageViewController.categoryView.titleSelectedFont= [UIFont boldSystemFontOfSize:16.0];
           _segmentedPageViewController.categoryView.titleNormalColor= [UIColor colorWithHexString:@"#666666"];
           _segmentedPageViewController.categoryView.titleSelectedColor= COLOR_333;
           _segmentedPageViewController.categoryView.vernier.backgroundColor= APP_NAVI_COLOR;
           [_segmentedPageViewController.categoryView setVernierHeight:3*KScaleH];
           [_segmentedPageViewController.categoryView setVernierWidth:15*KScaleW];
           [_segmentedPageViewController.categoryView setItemWidth:SCREEN_WIDTH/3];
       #pragma mark - 动态计算标题长度
           [_segmentedPageViewController.categoryView setItemSpacing:0];
           _segmentedPageViewController.categoryView.bottomBorder.hidden=YES;
}

    return YES;
}

#pragma mark -历史记录

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30*KScaleH)];
        bgView.backgroundColor=[UIColor whiteColor];
        UILabel   *   label=[[UILabel alloc]initWithFrame:CGRectMake(15.5*KScaleW, 17*KScaleH, SCREEN_WIDTH-15.5*KScaleW, 13*KScaleH)];
        label.font=APP_NORMAL_FONT(14.0);
        label.textColor=COLOR_999;
        label.textAlignment=NSTextAlignmentLeft;
        label.text=@"搜索历史";
        [bgView addSubview:label];
        return bgView;
       
    }
//    if (section==1) {
//       UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30*KScaleH)];
//        bgView.backgroundColor=[UIColor whiteColor];
//              UILabel   *   label=[[UILabel alloc]initWithFrame:CGRectMake(15.5*KScaleW, 12*KScaleH, SCREEN_WIDTH-15.5*KScaleW, 13*KScaleH)];
//              label.font=APP_NORMAL_FONT(14.0);
//              label.textColor=COLOR_999;
//              label.textAlignment=NSTextAlignmentLeft;
//              label.text=@"热门搜索";
//              [bgView addSubview:label];
//              return bgView;
//    }
        return nil;
   
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self addSearchRecord:@"测试数据"];
    [self.tableView removeFromSuperview];
    [self addSegmentedPageViewController];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   SearchMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
   cell= [[SearchMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.indexNum.hidden=YES;
        cell.hotWords.hidden=YES;
#pragma mark - 历史记录
           float butX = NeedStartMargin;
           float butY = 15*KScaleH;
           CGFloat height=25*KScaleH;
           NSArray   *  array=SEARCH_HISTORY;
          for(int i = 0; i < array.count; i++){
                  
                  //宽度自适应计算宽度
                  NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
                  CGRect frame_W = [array[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
                  
                  //宽度计算得知当前行不够放置时换行计算累加Y值
                  if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
                      butX = NeedStartMargin;
                      butY += (NeedBtnHeight+10);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
                      height+=NeedBtnHeight+10;
                  }
                  //设置计算好的位置数值
                  UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX,butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
                  //设置内容
                  [btn setTitle:array[i] forState:UIControlStateNormal];
                  btn.tag = i;
                  //设置圆角
                  btn.layer.cornerRadius =12.5;//2.0是圆角的弧度，根据需求自己更改
                  [btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
                  btn.backgroundColor=COLOR_f4;
                  btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                  [btn addTarget:self action:@selector(SelBtn:) forControlEvents:UIControlEventTouchUpInside];
                  butX = CGRectGetMaxX(btn.frame)+15;
                  [cell addSubview:btn];
                  
                  
              }
    }
//     if (indexPath.section==1) {
//        cell.indexNum.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
//        cell.hotWords.text=@"测试数据";
//
//    }
  return cell;
}
#pragma mark - 历史记录点击事件
-(void)SelBtn:(UIButton *)sender{
    NSArray * array=SEARCH_HISTORY;
    [self.tableView removeFromSuperview];
    [self addSegmentedPageViewController];
     NSMutableArray *controllers = [NSMutableArray array];

       
                SearchAliveViewController   *   aliveVC=[SearchAliveViewController new];
        aliveVC.keyWords=array[sender.tag];
                [controllers addObject:aliveVC];
                SearchVideoViewController   *  videoVC=[SearchVideoViewController new];
        videoVC.keyWords=array[sender.tag];
                [controllers addObject:videoVC];
                SearchUserViewController   *  userVC=[SearchUserViewController new];
        userVC.keyWords=array[sender.tag];
                [controllers addObject:userVC];
        _segmentedPageViewController.pageViewControllers = controllers;
        _segmentedPageViewController.categoryView.titles =self.titleList;
        _segmentedPageViewController.categoryView.alignment = HGCategoryViewAlignmentLeft;
        _segmentedPageViewController.categoryView.originalIndex =0;
        _segmentedPageViewController.categoryView.topBorder.hidden = YES;
        _segmentedPageViewController.categoryView.titleNomalFont= [UIFont systemFontOfSize:16.0];
        _segmentedPageViewController.categoryView.titleSelectedFont= [UIFont boldSystemFontOfSize:16.0];
        _segmentedPageViewController.categoryView.titleNormalColor= [UIColor colorWithHexString:@"#666666"];
        _segmentedPageViewController.categoryView.titleSelectedColor= COLOR_333;
        _segmentedPageViewController.categoryView.vernier.backgroundColor= APP_NAVI_COLOR;
        [_segmentedPageViewController.categoryView setVernierHeight:3*KScaleH];
        [_segmentedPageViewController.categoryView setVernierWidth:15*KScaleW];
        [_segmentedPageViewController.categoryView setItemWidth:SCREEN_WIDTH/3];
    #pragma mark - 动态计算标题长度
        [_segmentedPageViewController.categoryView setItemSpacing:0];
        _segmentedPageViewController.categoryView.bottomBorder.hidden=YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         if (SEARCH_HISTORY != nil && ![SEARCH_HISTORY isKindOfClass:[NSNull class]] && SEARCH_HISTORY.count != 0) {
             return 30*KScaleH;
         }else{
             return 0;
             
         }
       }else{
           return 30*KScaleH;
       }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (SEARCH_HISTORY != nil && ![SEARCH_HISTORY isKindOfClass:[NSNull class]] && SEARCH_HISTORY.count != 0) {
             return 83*KScaleH;
                }else{
            return 0*KScaleH;
                }
    }else{
        return 35*KScaleH;
    }
}
#pragma mark - history
-(void)addSearchRecord:(NSString *)searchStr
{
    NSMutableArray *searchArray = [[NSMutableArray alloc]initWithArray:SEARCH_HISTORY];
    if (searchArray == nil) {
        searchArray = [[NSMutableArray alloc]init];
    } else if ([searchArray containsObject:searchStr]) {
        [searchArray removeObject:searchStr];
    } else if ([searchArray count] >= RecordCount) {
        [searchArray removeObjectsInRange:NSMakeRange(RecordCount - 1, [searchArray count] - RecordCount + 1)];
    }
    [searchArray insertObject:searchStr atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:@"SearchHistory"];
    NSLog(@"history=%@",searchArray);
}



-(NSArray *)getAllSearchHistory
{
  
    return SEARCH_HISTORY;
}

- (void)clearAllSearchHistory
{
    [[NSUserDefaults standardUserDefaults] setObject:[[NSMutableArray alloc]init] forKey:@"SearchHistory"];
}
#pragma mark - tabbleView
-(UITableView *)tableView{
    if (!_tableView) {
           _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchTF.bottom, SCREEN_WIDTH,SCREEN_HEIGHT-self.searchTF.bottom) style:UITableViewStylePlain];
           _tableView.delegate = self;
           _tableView.showsVerticalScrollIndicator = NO;
           _tableView.backgroundColor = [UIColor whiteColor];
           _tableView.dataSource = self;
           _tableView.separatorColor=[UIColor clearColor];
           [self.view addSubview:_tableView];
    }
   
    return _tableView;
    
}


#pragma mark - 搜索结果
- (void)addSegmentedPageViewController {
    [self addChildViewController:self.segmentedPageViewController];
    [self.view addSubview:self.segmentedPageViewController.view];
    [self.segmentedPageViewController didMoveToParentViewController:self];
    CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
    [self.segmentedPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchTF.mas_bottom).offset(16.5*KScaleH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-tabbar-16.5*KScaleH-self.searchTF.height);
    }];
}
#pragma mark Getters
- (HGSegmentedPageViewController *)segmentedPageViewController {
    if (!_segmentedPageViewController) {
        _segmentedPageViewController = [[HGSegmentedPageViewController alloc] init];
    }
    return _segmentedPageViewController;
}

@end
