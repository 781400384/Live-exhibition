//
//  ZMCusCommentListView.m
//  ZM
//
//  Created by Kennith.Zeng on 2018/8/29.
//  Copyright © 2018年 Kennith. All rights reserved.
//

#import "ZMCusCommentListView.h"
#import "ZMCusCommentBottomView.h"
#import "ZMCusCommentListTableHeaderView.h"
#import "ZMCusCommentListContentCell.h"
#import "ZMCusCommentListReplyContentCell.h"
#import "ZMColorDefine.h"
#import "VideoHandle.h"
#import "CommendModel.h"

@interface ZMCusCommentListView()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) ZMCusCommentBottomView *bottomView;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) ZMCusCommentListTableHeaderView *headerView;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSMutableArray    *   dataList;
@property (nonatomic, assign) int                    page;
@end


@implementation ZMCusCommentListView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = RGBHexColor(0xffffff, 1);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
      
          self.page = 1;
//          [self loadData];
          [self.tableView shouldAddHeaderRefresh:YES];
          [self.tableView shouldAddFooterRefresh:YES];
          __weak typeof(self)weakSelf = self;
          self.tableView.headerRefreshBlock = ^{
              
              weakSelf.page = 1;
              [weakSelf loadData];
          };
          self.tableView.footerRefreshBlock = ^{
            
              weakSelf.page++;
              [weakSelf loadData];
              
              
          };
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMsg:) name:SendJusgeNotificationSuccess object:nil];
    }
    return self;
}
- (void)didMoveToWindow {
    if (self.window) {
        //创建通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMsg:) name:SendJusgeNotificationSuccess object:nil];
    }
}
 
 
//从当前window删除 相当于-viewDidUnload
- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow == nil) {
//移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SendJusgeNotificationSuccess object:nil];
    }
}
-(void)reloadMsg:(NSNotification *)wxLogin{
    [self loadData];
}
-(void)loadData{
    [VideoHandle getCommentListWithVideoId:[self.videoId intValue] uid:[[UserInfoDefaults userInfo].uid intValue] page:self.page success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            NSLog(@"评论轮信息%@",dic);
            if (self.page==1) {
                self.dataList=[CommendModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                [self.dataList addObjectsFromArray:[CommendModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];}
        }else{
            [self toast:dic[@"msg"]];
        }
         NSLog(@"评论轮信息%@",dic);
        [self layoutUI];
    } failed:^(id  _Nonnull obj) {
        
    }];
}

- (void)layoutUI{
    
    @weakify(self)
    _headerView = [[ZMCusCommentListTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    _headerView.closeBtnBlock = ^{
        @strongify(self)
        if (self.closeBtnBlock) {
            self.closeBtnBlock();
        }
    };
    [self addSubview:_headerView];

    CGFloat tableHeight  = SCREEN_HEIGHT - CGRectGetHeight(self.headerView.frame) - SAFE_AREA_BOTTOM - ZMCusComentBottomViewHeight-STATUS_AND_NAV_BAR_HEIGHT;
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.headerView.frame), SCREEN_WIDTH, tableHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    _tableView.estimatedRowHeight = 10000;
    [_tableView registerClass:[ZMCusCommentListContentCell class] forCellReuseIdentifier:NSStringFromClass([ZMCusCommentListContentCell class])];
    [_tableView registerClass:[ZMCusCommentListReplyContentCell class] forCellReuseIdentifier:NSStringFromClass([ZMCusCommentListReplyContentCell class])];
    [self addSubview:_tableView];

    CGFloat toolViewY = SCREEN_HEIGHT-ZMCusComentBottomViewHeight-SAFE_AREA_BOTTOM-STATUS_AND_NAV_BAR_HEIGHT-40*KScaleH;
    _toolView = [[ZMCusCommentToolView alloc] initWithFrame:CGRectMake(0, toolViewY, SCREEN_WIDTH, ZMCusComentBottomViewHeight+STATUS_BAR_HEIGHT)];
    _toolView.sendBtnBlock = ^(NSString *text) {
          @strongify(self)
        [self sendJudgeWithText:text];
//        if (self.sendBtnBlock) {
//            self.sendBtnBlock(text);
//        }
        NSLog(@"发送aaaaaaaa==%@",text);
    };

    [self addSubview:_toolView];

}


#pragma mark -
#pragma mark UITableViewDataSource, UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果你需要做成多级回复的话，可以改一下tableview为section 的形式去做
//    if (indexPath.row==1||indexPath.row==3||indexPath.row==4) {
//        ZMCusCommentListReplyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMCusCommentListReplyContentCell class]) forIndexPath:indexPath];
//        [cell configData:nil];
//        return cell;
//    }else{
        ZMCusCommentListContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZMCusCommentListContentCell class]) forIndexPath:indexPath];
    cell.model=self.dataList[indexPath.row];
//        [cell configData:nil];
        return cell;
//    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //防止重复点击
    CommendModel  *  model=self.dataList[indexPath.row];
    if (!self.isSelect) {
        self.isSelect = YES;
        [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:1.0f];
        self.toolView.textView.placeholder = [NSString stringWithFormat:@"回复:%@",model.nickname];
        [self.toolView showTextView];

        if (self.replyBtnBlock) {
            self.replyBtnBlock();
        }
    }
}
- (void)repeatDelay{
    self.isSelect = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.toolView hideTextView];
}
-(void)sendJudgeWithText:(NSString *)text{
    [VideoHandle sendJudgeWithVideoId:[self.videoId intValue] uid:[[UserInfoDefaults userInfo].uid intValue] tken:[UserInfoDefaults userInfo].token content:text success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            [self toast:@"评论成功"];
            [self loadData];
        }else{
            [self toast:dic[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)loadDataWithVideoId:(int)videoId
{
    [VideoHandle getCommentListWithVideoId:videoId uid:[[UserInfoDefaults userInfo].uid intValue] page:self.page success:^(id  _Nonnull obj) {
          NSDictionary * dic=(NSDictionary *)obj;
          if ([dic[@"code"] intValue]==200) {
              NSLog(@"评论轮信息%@",dic);
              if (self.page==1) {
                  self.dataList=[CommendModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
              }else{
                  [self.dataList addObjectsFromArray:[CommendModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];}
          }else{
              [self toast:dic[@"msg"]];
          }
           NSLog(@"评论轮信息%@",dic);
          [self layoutUI];
      } failed:^(id  _Nonnull obj) {
          
      }];
}
@end
