//
//  PersonInfoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "VideoLiveTextView.h"
#import "MineHandle.h"
#import "InterestLabelModel.h"
#import "MineHandle.h"
#import "LCActionAlertView.h"
#import "CXDatePickerView.h"
#define NeedStartMargin 15  // 首列起始间距
#define NeedFont 12   // 需求文字大小
#define NeedBtnHeight 30
@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSMutableArray  *   interestList;
  
    NSString        *   sex;
    NSString        *  birthday;
}
@property (nonatomic, strong) UITableView    *   tableView;
@property (nonatomic, strong) NSArray        *   titleList;
@property (nonatomic, strong) UITextField    *   nickNameTF;
@property (nonatomic, strong) VideoLiveTextView   *   textView;
@property (nonatomic, strong) UILabel        *   sexLabel;
@property (nonatomic, strong) UILabel        *   birthdayLabe;
@property (nonatomic, strong) NSArray  *  array;
@property (nonatomic, strong)   NSMutableArray  *   btnList;
@property (nonatomic, strong) NSMutableArray    *   detailList;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"个人资料";
    self.naviView.rightTitleLabel.text=@"保存";
    self.titleList=@[@[@"头像",@"昵称",@"签名",@"性别",@"生日"],@[@"兴趣标签"]];
    [self loadData];
    
}
-(void)loadData{
    [MineHandle getIntersetLabelWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
               NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",dic);
               if ([dic[@"code"] intValue]==200) {
                  interestList=[InterestLabelModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                   [self.tableView reloadData];
               }
        [self.view toast:dic[@"msg"]];
           } failed:^(id  _Nonnull obj) {
               
           }];
}
-(void)rightTitleLabelTap{
    NSString *text = [self.btnList componentsJoinedByString:@","];
    [self updateInfoWithNickName:self.nickNameTF.text==nil?[UserInfoDefaults userInfo].nickname:self.nickNameTF.text sign:self.textView.text==nil?[UserInfoDefaults userInfo].user_sign:self.textView.text sex:self.sexLabel.text==nil?[UserInfoDefaults userInfo].sex:self.sexLabel.text birthday:birthday==nil?@"":birthday labelId:text==nil?@"":text];
}
#pragma
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.backgroundColor=[UIColor whiteColor];
    UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 17*KScaleH, 35*KScaleW, 17*KScaleH)];
    if (indexPath.section==0) {
        titleLabel.width=35*KScaleW;
        #pragma mark-第一列布局
        if (indexPath.row==0) {

            UIImageView   *   avatarImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-63.5*KScaleW, 8*KScaleH, 34*KScaleH, 34*KScaleH)];
            avatarImage.clipsToBounds=YES;
            avatarImage.contentMode=UIViewContentModeScaleToFill;
            [avatarImage setRadius:17.25*KScaleH];
            [cell addSubview:avatarImage];
            [avatarImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path]];
             cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        }
        #pragma mark-第2列布局
        if (indexPath.row==1) {
           cell.accessoryType=UITableViewCellAccessoryNone ;
            self.nickNameTF=[[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right+17*KScaleW,10*KScaleH, SCREEN_WIDTH-88.5*KScaleW,cell.height-10*KScaleH)];
                          self.nickNameTF.backgroundColor=[UIColor whiteColor];
                          self.nickNameTF.delegate=self;
                          self.nickNameTF.tintColor=APP_NAVI_COLOR;
                          [cell addSubview:self.nickNameTF];
                          self.nickNameTF.placeholder = [UserInfoDefaults userInfo].nickname==nil?@"请输入你的昵称":[UserInfoDefaults userInfo].nickname;
                          self.nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
          
        }
        #pragma mark-第3列布局
        if (indexPath.row==2) {
             cell.accessoryType=UITableViewCellAccessoryNone ;
            self.textView = [[VideoLiveTextView alloc]initWithFrame:CGRectMake(titleLabel.right+17*KScaleW,10*KScaleH, SCREEN_WIDTH-88.5*KScaleW,cell.height-10*KScaleH)];
                  // 设置颜色
                  self.textView.backgroundColor = [UIColor whiteColor];
                  // 设置提示文字
            self.textView.placehoder = [UserInfoDefaults userInfo].user_sign==nil?@"填写属于自己的个性签名吧~":[UserInfoDefaults userInfo].user_sign;
                  // 设置提示文字颜色
                  self.textView.placehoderColor = COLOR_999;
                  // 设置textView的字体
                  self.textView.font = APP_NORMAL_FONT(18.0);
                  // 设置内容是否有弹簧效果
                  self.textView.alwaysBounceVertical = YES;
                  // 设置textView的高度根据文字自动适应变宽
                  self.textView.isAutoHeight = YES;
                  // 添加到视图上
            [cell addSubview:self.textView];
        }
        #pragma mark-第4列布局
        if (indexPath.row==3) {
             cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_next"]];
              UILabel  *  label=[[UILabel alloc]initWithFrame:CGRectMake(titleLabel.right+17*KScaleW,16.5*KScaleH, SCREEN_WIDTH-88.5*KScaleW,17*KScaleH)];
                label.textColor=COLOR_333;
               label.textAlignment=NSTextAlignmentLeft;
               label.font=APP_NORMAL_FONT(18.0);
               [cell addSubview:label];
            label.text=[UserInfoDefaults userInfo].sex==nil?@"保密":[UserInfoDefaults userInfo].sex;
            _sexLabel=label;
        }
        #pragma mark-第5列布局
        if (indexPath.row==4) {
             cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_next"]];
            UILabel  *  label=[[UILabel alloc]initWithFrame:CGRectMake(titleLabel.right+17*KScaleW,(cell.height-17*KScaleH)/2, SCREEN_WIDTH-88.5*KScaleW,17*KScaleH)];
                           label.textColor=COLOR_333;
                          label.textAlignment=NSTextAlignmentLeft;
                          label.font=APP_NORMAL_FONT(18.0);
            
                          [cell addSubview:label];
                       label.text=[UserInfoDefaults userInfo].birthday==nil?@"":[UserInfoDefaults userInfo].birthday;
                       _birthdayLabe=label;
        }
    }else{
#pragma mark - 头部标题
        titleLabel.width=71*KScaleW;
          cell.accessoryType=UITableViewCellAccessoryNone ;
        UILabel  *  label=[[UILabel alloc]initWithFrame:CGRectMake(0,titleLabel.bottom+34.5*KScaleH, SCREEN_WIDTH,14*KScaleH)];
                       label.textColor=[UIColor colorWithHexString:@"#646464"];
                      label.textAlignment=NSTextAlignmentCenter;
                      label.font=APP_NORMAL_FONT(15.0);
                      [cell addSubview:label];
        label.text=@"请选择你的兴趣标签";
#pragma mark - 选择标签
        
      
                float butX = NeedStartMargin;
                            float butY =label.bottom+ 39*KScaleH;
                            CGFloat height=30*KScaleH;
                           for(int i = 0; i < interestList.count; i++){
                               InterestLabelModel  *  model=interestList[i];
                                   //宽度自适应计算宽度
                                   NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
                                   CGRect frame_W = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
                                   
                                   //宽度计算得知当前行不够放置时换行计算累加Y值
                                   if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
                                       butX = NeedStartMargin;
                                       butY += (NeedBtnHeight+15);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
                                       height+=NeedBtnHeight+15;
                                   }
                                   //设置计算好的位置数值
                               UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
                                   //设置内容
                                   [btn setTitle:model.title forState:UIControlStateNormal];
                                   btn.tag = i;
                                   //设置圆角
                                   btn.layer.cornerRadius =2.5;//2.0是圆角的弧度，根据需求自己更改
                                 
                            
                               if ([model.is_label intValue]==1) {
                                   btn.backgroundColor=[UIColor colorWithHexString:model.color];
                                     [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                               }else{
                                   btn.backgroundColor=[UIColor whiteColor];
                                   [btn setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
                                   
                               }
                               [btn addTarget:self action:@selector(labelSel:) forControlEvents:UIControlEventTouchUpInside];
                                   btn.layer.borderWidth=0.5*KScaleW;
                                     btn.tag=i;
                                   btn.layer.borderColor=[UIColor colorWithHexString:model.color].CGColor;
                                   btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
                                   butX = CGRectGetMaxX(btn.frame)+15;
                                   [cell addSubview:btn];
                               }
                       
      
        
           
    }
    titleLabel.textColor=COLOR_333;
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.text=self.titleList[indexPath.section][indexPath.row];
    titleLabel.font=APP_NORMAL_FONT(18.0);
    [cell addSubview:titleLabel];
    return cell;
}
-(void)labelSel:(UIButton *)sender{
      InterestLabelModel  *  model=interestList[sender.tag];
    
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        sender.backgroundColor=[UIColor colorWithHexString:model.color];
       [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnList addObject:model.label_id];
        NSLog(@"list=%@",self.btnList);
    }else{
        sender.backgroundColor=[UIColor whiteColor];
        [sender setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        [self.btnList removeObject:model.label_id];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==3) {
            [LCActionAlertView showActionViewNames:@[@"男",@"女",@"保密"] completed:^(NSInteger index,NSString * name) {
                                            if (index==0) {
                                                _sexLabel.text=@"男";
                                            } else if(index==1){
                                                _sexLabel.text=@"女";
                                            }else{
                                                _sexLabel.text=@"保密";
                                            }
                                        } canceled:^{

                                        }];
        }
        if (indexPath.row==4) {
            CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                    NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self->birthday=dateString;
                _birthdayLabe.text=dateString;
               }];
               datepicker.dateLabelColor = [UIColor colorWithHexString:@"#0b2137"];//年-月-日-时-分 颜色
               datepicker.datePickerColor = [UIColor colorWithHexString:@"#444444"];//滚轮日期颜色
               datepicker.doneButtonColor = [UIColor colorWithHexString:@"#20a63f "];//确定按钮的颜色
               datepicker.cancelButtonColor = [UIColor colorWithHexString:@"#cdd3d9"];
               datepicker.yearLabelColor=[UIColor colorWithHexString:@"#ebebeb"];
            [datepicker show];
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            return 102.5*KScaleH;
        }else{
            return 50*KScaleH;
        }
    }else{
        return 305*KScaleH;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray  *  array=self.titleList[section];
        return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 7.5*KScaleH;
    
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor colorWithHexString:@"#F1F1F1"];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}
- (UIColor *)randomColor {
    CGFloat hue = (arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
-(void)updateInfoWithNickName:(NSString *)nickName sign:(NSString *)sign sex:(NSString *)sex birthday:(NSString *)birthday labelId:(NSString *)labelId{
    [MineHandle updateUserInfoWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token  nickName:nickName sign:sign sex:sex label_ids:labelId birthday:birthday success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"修改信息==%@",dic);
        if ([dic[@"code"] intValue]==200) {
            UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
            [UserInfoDefaults  saveUserInfo:model];
                       //修改融云信息
                       RCUserInfo *user = [RCUserInfo new];
                       user.name = model.nickname;;
                       [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:model.uid];
            [self.navigationController popViewControllerAnimated:YES];
        }
//          [self.view toast:dic[@"msg"]];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(NSMutableArray *)btnList{
    if (!_btnList) {
        _btnList=[NSMutableArray array];
    }
    return _btnList;
}
-(NSMutableArray *)detailList{
    if (!_detailList) {
        _detailList=[NSMutableArray array];
    }
    return _detailList;
}
@end
