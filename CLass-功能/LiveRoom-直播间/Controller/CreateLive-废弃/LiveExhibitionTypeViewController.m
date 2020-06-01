//
//  LiveExhibitionTypeViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LiveExhibitionTypeViewController.h"
#import "LiveExhibitionListModel.h"
#import "LiveExhibitionListHandle.h"
@interface LiveExhibitionTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *   tableView;
@property (nonatomic, strong) NSMutableArray        *   titleList;

@end

@implementation LiveExhibitionTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"展览分类";
//    self.titleList=@[@"",@"行业分类",@"展会分类",@"美颜",@"分享到"];
    [self loadData];
}
-(void)loadData{
    [LiveExhibitionListHandle getExhibitionListWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary   *   dic=(NSDictionary *)obj;
        NSLog(@"obj%@",dic);
        if ([dic[@"code"] intValue]==200) {
            self.titleList=[LiveExhibitionListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.tableView reloadData];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [ self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]animated:YES scrollPosition:UITableViewScrollPositionNone];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
       UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(15*KScaleW, 59*KScaleH, SCREEN_WIDTH-38*KScaleW, 0.5*KScaleH)];
       lineView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
       [cell addSubview:lineView];
       LiveExhibitionListModel    *   model=self.titleList[indexPath.row];
    cell.textLabel.text=model.title;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
    LiveExhibitionListModel    *   model=self.titleList[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.returnValueBlock) {
        //将自己的值传出去，完成传值
        self.returnValueBlock(model.title,model.exhibition_id);
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      
        return 60.5*KScaleH;
        
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
        return self.titleList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor whiteColor];
        _tableView = tableView;
        tableView.separatorColor=[UIColor clearColor];
        tableView.tableHeaderView=[self addHeaderView];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

-(UIView *)addHeaderView{
    UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KScaleH)];
    bgView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    bgView.userInteractionEnabled=YES;
    UILabel  *  noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20*KScaleW, 10*KScaleW, SCREEN_WIDTH-40*KScaleW, 30*KScaleH)];
    noticeLabel.numberOfLines=0;
    noticeLabel.font=APP_NORMAL_FONT(12.0);
    noticeLabel.textAlignment=NSTextAlignmentLeft;
    noticeLabel.textColor=[UIColor colorWithHexString:@"#656565"];
    noticeLabel.text=@"注意选择适合自己的展览。直播过程中，若运营人员发现选择的 展览和直播内容不相符的情况，会调整您直播的分类。";
    [bgView addSubview:noticeLabel];
    return bgView;
}


@end
