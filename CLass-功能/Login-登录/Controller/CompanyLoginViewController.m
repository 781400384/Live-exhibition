//
//  CompanyLoginViewController.m
//  VideoLive
//  参展商登录
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CompanyLoginViewController.h"
#import "ForgetBaseViewController.h"
#import "CompanyRegisterViewController.h"
#import "LoginHandle.h"
#import "SettingDetailViewController.h"
#import "CompanyForgetViewController.h"
@interface CompanyLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField    *     phoneTF;
@property (nonatomic, strong) UITextField    *     pwdTF;
@property (nonatomic, strong) UITextField    *     codeTF;
@property (nonatomic, strong) UITextField    *     companyTF;
@end

@implementation CompanyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.hidden=YES;
    [self configUI];
}
-(void)configUI{
#pragma mark - 登录
    
    
 
    
    for (int i= 0; i<2; i++) {
        
        UITextField   *   tf=[[UITextField alloc]initWithFrame:CGRectMake(39*KScaleW, 24*KScaleH+60*KScaleW*i, SCREEN_WIDTH-78*KScaleW, 47*KScaleH)];
        tf.backgroundColor=[UIColor whiteColor];
        tf.delegate=self;
        [self.view addSubview:tf];
        NSArray  *  array=@[@"输入公司账号(公司名称)",@"输入密码"];
         tf.placeholder=array[i];
        UIView   *  lineView=[[UIView alloc]initWithFrame:CGRectMake(39*KScaleW, tf.bottom, tf.width, 0.5*KScaleH)];
               lineView.backgroundColor=[UIColor colorWithHexString:@"#D6D6D6"];
               [self.view addSubview:lineView];
        UIButton    *   numCodeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 54.3*KScaleW, tf.height)];
        [numCodeBtn setImage:[UIImage imageNamed:@"login_edge_down"] forState:UIControlStateNormal];
        [numCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
        UIButton   *    pwdBtn=[[UIButton  alloc]initWithFrame:CGRectMake(tf.width-16.5*KScaleW, 0, 16.5*KScaleW, tf.height)];
        [pwdBtn setImage:[UIImage imageNamed:@"login_can_see"] forState:UIControlStateNormal];
        [pwdBtn setImage:[UIImage imageNamed:@"login_see"] forState:UIControlStateSelected];
        [pwdBtn addTarget:self action:@selector(pwdChange:) forControlEvents:UIControlEventTouchUpInside];
        tf.keyboardType=UIKeyboardTypeDefault;
        if (i==0) {
            self.phoneTF=tf;
        }
        if (i==1) {
            self.pwdTF=tf;
            tf.rightView=pwdBtn;
            tf.rightViewMode=UITextFieldViewModeAlways;
            tf.secureTextEntry=YES;
        }
    }
    
    UIButton   *   loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(39*KScaleW, self.pwdTF.bottom+47.5*KScaleH, SCREEN_WIDTH-78*KScaleW, 40*KScaleH)];
    loginBtn.backgroundColor=APP_NAVI_COLOR;
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font=APP_NORMAL_FONT(15.0);
    [loginBtn setRadius:19.75*KScaleW];
      [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
          UILabel  *    forgetLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-88*KScaleW)/2+44*KScaleW, loginBtn.bottom+33*KScaleH, (SCREEN_WIDTH-88*KScaleW)/2, 13*KScaleH)];
             forgetLabel.textColor=APP_NAVI_COLOR;
             forgetLabel.textAlignment=NSTextAlignmentRight;
             forgetLabel.font=APP_NORMAL_FONT(14.0);
             forgetLabel.text=@"忘记密码";
             [self.view addSubview:forgetLabel];
             forgetLabel.userInteractionEnabled=YES;

    UITapGestureRecognizer      *   forget=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
    CompanyForgetViewController   *  vc=[[CompanyForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    }];
    [forgetLabel addGestureRecognizer:forget];
       
    

       UILabel *label = [[UILabel alloc] init];
       label.frame = CGRectMake(0,loginBtn.bottom+281.5*KScaleH,SCREEN_WIDTH,10.5);
       label.textAlignment=NSTextAlignmentCenter;
       label.font=APP_NORMAL_FONT(10.0);
       [self.view addSubview:label];
       label.textColor=[UIColor colorWithHexString:@"#323232"];
        NSString   *  agreement=@"登录即代表同意服务和隐私条款";
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:agreement attributes:attribtDic];
        //赋值
    
        label.attributedText =attribtStr;
    label.userInteractionEnabled=YES;
    UITapGestureRecognizer  * labTap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        SettingDetailViewController  *  vc=[[SettingDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        vc.naviView.naviTitleLabel.text=@"服务隐私协议";
        vc.url=@"https://api.bjzhanbotest.com/Agreement/details/agreement_id/1";
    }];
    [label addGestureRecognizer:labTap];
}
-(void)pwdChange:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
                 self.pwdTF.secureTextEntry=NO;
             }else{
                 self.pwdTF.secureTextEntry=YES;
             }
}
/**获取短信验证码*/
- (void)getCodeAction:(UIButton *)sender{
    
    [sender beginCountDownWithDuration:SMS_TIME_INTERVAL];
   
    
}
-(void)loginClick{
   __weak typeof(self)weakSelf = self;
     [LoginHandle loginWithPhone:self.phoneTF.text pwd:self.pwdTF.text type:1 success:^(id  _Nonnull obj) {
         NSDictionary  *  dic=(NSDictionary *)obj;

         if ([dic[@"code"] intValue]==200) {
             UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
             [UserInfoDefaults  saveUserInfo:model];
              weakSelf.loginSuccessBlock();
              [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];
           
         }else{
             [self.view toast:dic[@"msg"]];
         }
         NSLog(@"dic==%@",dic);
     } failed:^(id  _Nonnull obj) {
         
     }];
}
@end
