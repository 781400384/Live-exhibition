//
//  CommentView.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CommentView.h"
#import "VideoHandle.h"
#import "CommendModel.h"
#import "CommentViewTableViewCell.h"
@interface CommentView()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray    *   dataList;
@property (nonatomic, assign) int                    page;
@end
@implementation CommentView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = RGBHexColor(0xffffff, 1);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
      
         self.page = 1;
//          [self loadDataWithVideoId:[self.videoId intValue]];
          [self.tableView shouldAddHeaderRefresh:YES];
          [self.tableView shouldAddFooterRefresh:YES];
          __weak typeof(self)weakSelf = self;
          self.tableView.headerRefreshBlock = ^{
              
              weakSelf.page = 1;
              [weakSelf loadDataWithVideoId:[weakSelf.videoId intValue]];
          };
          self.tableView.footerRefreshBlock = ^{
            
              weakSelf.page++;
              [weakSelf loadDataWithVideoId:[weakSelf.videoId intValue]];
              
               [self showAlertView];
          };
    }
    return self;
}
-(void)showAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.4) ;
        self.tableView.frame = CGRectMake(0,217*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT-217*KScaleH) ;
        [self loadDataWithVideoId:[self.videoId intValue]];
        NSLog(@"12313213131");
    }] ;
}

//隐藏
-(void)removeAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.0) ;
        self.tableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-217*KScaleH);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }] ;
}
-(void)loadDataWithVideoId:(int)videoId{
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
        [self.tableView reloadData];
        [self.tableView endRefreshing];
         NSLog(@"评论轮信息%@",dic);
//        [self layoutUI];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CommentViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentViewTableViewCell class]) forIndexPath:indexPath];
       cell.model=self.dataList[indexPath.row];

        return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
-(BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 217*KScaleH, SCREEN_WIDTH, SCREEN_WIDTH-217*KScaleH) style:UITableViewStylePlain];
           _tableView.backgroundColor = [UIColor whiteColor];
           _tableView.showsVerticalScrollIndicator = NO;
           _tableView.showsHorizontalScrollIndicator=NO;
           _tableView.dataSource = self;
           _tableView.delegate = self;
           _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
           _tableView.tableFooterView = [UIView new];
           _tableView.estimatedRowHeight = 10000;
        
           [self addSubview:_tableView];
    }
    return _tableView;
}
@end
