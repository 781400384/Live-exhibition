//
//  CompanyInfoDetailViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/15.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CompanyInfoDetailViewController.h"
#import "CreateCompanyInfoTableViewCell.h"
#import "MineHandle.h"
#import "ImageModel.h"
#import "bottomAlertView.h"

#import "ExhibitionImageBigViewController.h"
@interface CompanyInfoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView    *    tableView;
@property (nonatomic, strong) NSDictionary   *    dictionary;
@property (nonatomic, strong) NSMutableArray *    dataList;

@end

@implementation CompanyInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.userType isEqualToString:@"0"]) {
        self.naviView.rightTitleLabel.text=@"删除";
        self.naviView.rightTitleLabel.textColor=COLOR_333;
    }else{
        self.naviView.rightTitleLabel.hidden=YES;
        }
   
    [self getCompanyInfo];
    self.view.backgroundColor=RGB(247, 247, 247);;
}
-(void)rightTitleLabelTap{
    [MineHandle deleCompanyWithwallId:self.companyId uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token
                              success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
//          [self.view toast:dic[@"msg"]];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)getCompanyInfo{
    [MineHandle getCmpanyInfoDetailWithUid:[[UserInfoDefaults userInfo].uid intValue] wallId:self.companyId success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
        NSLog(@"详细信息==%@",dic);
        if([dic[@"code"] intValue]==200){
            self.dictionary=dic;
            [self configUI];
            self.dataList=[ImageModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"path_list"]];
            NSLog(@"%lu",(unsigned long)self.dataList.count);
        }
        [self.tableView reloadData];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)configUI{
    
    UILabel  *   titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(16*KScaleW, self.naviView.bottom+10*KScaleH, SCREEN_WIDTH-32*KScaleW, 17*KScaleH)];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.textColor=COLOR_333;
    titleLabel.font=APP_BOLD_FONT(18.0);
    titleLabel.text=self.dictionary[@"data"][@"title"];
    [self.view addSubview:titleLabel];
    
   
    UILabelSet  *  detail=[[UILabelSet alloc]initWithFrame:CGRectMake(245.5*KScaleW, self.naviView.bottom+59.5*KScaleH, 127*KScaleH, 570*KScaleH)];
    detail.textAlignment=NSTextAlignmentLeft;
    detail.numberOfLines=0;
    detail.font=APP_NORMAL_FONT(16.0);
    detail.textColor=COLOR_333;
    detail.text=self.dictionary[@"data"][@"desc"];
    [self.view addSubview:detail];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0,SCREEN_HEIGHT-48.5*KScaleH,SCREEN_WIDTH,48.5*KScaleH);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton   *    praiseBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 48.5*KScaleH)];
    praiseBtn.backgroundColor=[UIColor whiteColor];
    [praiseBtn setImage:[UIImage imageNamed:@"mine_praise_nor"] forState:UIControlStateNormal];
    NSString  *  num=[NSString stringWithFormat:@"%@",self.dictionary[@"data"][@"spot_num"]];
    [praiseBtn setTitle:num forState:UIControlStateNormal];
    [praiseBtn setImage:[UIImage imageNamed:@"mine_praise_sel"] forState:UIControlStateSelected];
    [praiseBtn setTitleColor:COLOR_333 forState:UIControlStateNormal];
    [praiseBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateSelected];
    [praiseBtn addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:praiseBtn];
    
     UIButton   *    shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 48.5*KScaleH)];
        shareBtn.backgroundColor=[UIColor whiteColor];
        [shareBtn setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
        [shareBtn setTitle:@"" forState:UIControlStateNormal];
//        [shareBtn setImage:[UIImage imageNamed:@"mine_praise_sel"] forState:UIControlStateSelected];
    //    [praiseBtn setTitleColor:COLOR_333 forState:UIControlStateNormal];
    //    [praiseBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateSelected];
        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:shareBtn];
    
}
-(void)praiseClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
          NSString  *  num=[NSString stringWithFormat:@"%d",[self.dictionary[@"data"][@"spot_num"] intValue]+1];
         [sender setTitle:num forState:UIControlStateNormal];
        [self praise];
    }else{
        NSString  *  num=[NSString stringWithFormat:@"%d",[self.dictionary[@"data"][@"spot_num"] intValue]];
        [sender setTitle:num forState:UIControlStateNormal];
    }
}
-(void)shareBtnClick:(UIButton *)sender{
    bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:alertV];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreateCompanyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ CreateCompanyInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
  ImageModel  *  model=self.dataList[indexPath.row];
  [cell.addImage sd_setImageWithURL:[NSURL URLWithString:model.path]];
    cell.closeBtn.hidden=YES;
    cell.backgroundColor=RGB(247, 247, 247);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ImageModel  *  model=self.dataList[indexPath.row];
    ExhibitionImageBigViewController   *  vc=[[ExhibitionImageBigViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.url=model.path;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataList.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom+59.5*KScaleH, 230*KScaleH, 127.5f*4) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 127.5f;
        tableView.backgroundColor=RGB(247, 247, 247);
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        tableView.showsVerticalScrollIndicator =NO;
        [self.view addSubview:tableView];
        _tableView = tableView;
       
    }
    return _tableView;
}
-(void)praise{
    [MineHandle praiseCompanyWithWallId:[self.companyId intValue] uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo
                                                                                                                        ].token
                                success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
//            [self.view toast:dic[@"msg"]];
        }else{
//              [self.view toast:dic[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
@end
