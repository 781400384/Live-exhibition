//
//  CoustomerLoginViewController.m
//  VideoLive
//  观众登录
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CoustomerLoginViewController.h"
#import "CoustomerRegisterViewController.h"
#import "CompanyForgetViewController.h"
#import "ForgetBaseViewController.h"
#import "CoustomerRegisterViewController.h"
#import "LoginHandle.h"
#import "SettingDetailViewController.h"
#import "CoustomerForgetViewController.h"
@interface CoustomerLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField    *     phoneTF;
@property (nonatomic, strong) UITextField    *     pwdTF;
@end

@implementation CoustomerLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled=YES;
    [self configUI];
    self.naviView.leftItemButton.hidden=YES;
}
-(void)configUI{
    for (int i= 0; i<2; i++) {
       
               UITextField   *   tf=[[UITextField alloc]initWithFrame:CGRectMake(39*KScaleW, 24*KScaleH+60*KScaleH*i, SCREEN_WIDTH-78*KScaleW, 47*KScaleH)];
               tf.backgroundColor=[UIColor whiteColor];
               tf.delegate=self;
               [self.view addSubview:tf];
               NSArray  *  array=@[@"  输入手机号码",@"输入密码"];
       
               tf.placeholder=array[i];
               tf.clearButtonMode = UITextFieldViewModeWhileEditing;
                tf.keyboardType=UIKeyboardTypeDefault;
               UIView   *  lineView=[[UIView alloc]initWithFrame:CGRectMake(39*KScaleW, tf.bottom, tf.width, 0.5*KScaleH)];
               lineView.backgroundColor=[UIColor colorWithHexString:@"#D6D6D6"];
               [self.view addSubview:lineView];
               UIButton    *   numCodeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 54.3*KScaleW, tf.height)];
               [numCodeBtn setImage:[UIImage imageNamed:@"login_edge_down"] forState:UIControlStateNormal];
               [numCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
               [numCodeBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
               numCodeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, numCodeBtn.titleLabel.intrinsicContentSize.width+2*KScaleW, 0, -numCodeBtn.titleLabel.intrinsicContentSize.width-2*KScaleW);
               numCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -numCodeBtn.currentImage.size.width-2*KScaleW, 0, numCodeBtn.currentImage.size.width+2*KScaleW);
               UIButton   *    pwdBtn=[[UIButton  alloc]initWithFrame:CGRectMake(tf.width-16.5*KScaleW, 0, 16.5*KScaleW, tf.height)];
               [pwdBtn setImage:[UIImage imageNamed:@"login_can_see"] forState:UIControlStateNormal];
               [pwdBtn setImage:[UIImage imageNamed:@"login_see"] forState:UIControlStateSelected];
               [pwdBtn addTarget:self action:@selector(pwdChange:) forControlEvents:UIControlEventTouchUpInside];
               if (i==0) {
                   self.phoneTF=tf;
                   tf.leftView=numCodeBtn;
                   [tf setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
                   tf.leftViewMode=UITextFieldViewModeAlways;
               }
               if (i==1) {
                   self.pwdTF=tf;
                   tf.rightView=pwdBtn;
                   tf.secureTextEntry=YES;
                   tf.rightViewMode=UITextFieldViewModeAlways;
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
           
    
    
           UILabel  *    registerLabel=[[UILabel alloc]initWithFrame:CGRectMake(44*KScaleW, loginBtn.bottom+33*KScaleH, (SCREEN_WIDTH-88*KScaleW)/2, 13*KScaleH)];
           registerLabel.textColor=APP_NAVI_COLOR;
           registerLabel.textAlignment=NSTextAlignmentLeft;
           registerLabel.font=APP_NORMAL_FONT(14.0);
           registerLabel.text=@"快速注册";
           registerLabel.userInteractionEnabled=YES;
           [self.view addSubview:registerLabel];
    UITapGestureRecognizer   *   registerClick=[[ UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        CoustomerRegisterViewController  *  vc=[[CoustomerRegisterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
       
    }];;
    [registerLabel addGestureRecognizer:registerClick];
           
    
    
            UILabel  *    forgetLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-88*KScaleW)/2+44*KScaleW, loginBtn.bottom+33*KScaleH, (SCREEN_WIDTH-88*KScaleW)/2, 13*KScaleH)];
              forgetLabel.textColor=APP_NAVI_COLOR;
              forgetLabel.textAlignment=NSTextAlignmentRight;
              forgetLabel.font=APP_NORMAL_FONT(14.0);
              forgetLabel.text=@"忘记密码";
              [self.view addSubview:forgetLabel];
    UITapGestureRecognizer  *   forgetClick=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
              CoustomerForgetViewController  *  vc=[[CoustomerForgetViewController alloc]init];
               [self.navigationController pushViewController:vc animated:NO];
               
    }];
    [forgetLabel addGestureRecognizer:forgetClick];
              forgetLabel.userInteractionEnabled=YES;
           
    
    
           UILabel   *    loginLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, loginBtn.bottom+186*KScaleH, SCREEN_WIDTH, 11.5*KScaleH)];
            loginLabel.font=APP_NORMAL_FONT(12.0);
            loginLabel.textAlignment=NSTextAlignmentCenter;
            [self.view addSubview:loginLabel];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"————————  其他登录方式  ————————"];
            NSRange range1 = [[str string] rangeOfString:@"————————    ————————"];
            [str addAttribute:NSForegroundColorAttributeName value:COLOR_999 range:range1];
            NSRange range2 = [[str string] rangeOfString:@"其他登录方式"];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#323232"] range:range2];
            loginLabel.attributedText = str;
           
           for (int i =0; i<2; i++) {
                UIButton  *    thirdLogin=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-106.5*KScaleW)/2+66.5*KScaleW*i, loginLabel.bottom+26*KScaleH, 40*KScaleW, 40*KScaleW)];
               NSArray  *  array=@[@"login_qq",@"login_wx"];;
               thirdLogin.tag=i;
               [thirdLogin addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
               [thirdLogin setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
               [self.view addSubview:thirdLogin];
           }
    

   

    
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
-(void)thirdLogin:(UIButton *)sender{
    if (sender.tag==0) {
        [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess)
                      {
                                  if (user.gender==0) {
                                      [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"男" type:1];
                                  }else if(user.gender==1){
                                      [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"女" type:1];
                                  }else{
                                      [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"保密" type:1];
                                  }
                                 
                              }

                              else
                                      {
                                          NSLog(@"%@",error);
                                      }
        }];
    }
    if (sender.tag==1) {
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess)
            {
                        if (user.gender==0) {
                            [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"男" type:1];
                        }else if(user.gender==1){
                            [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"女" type:1];
                        }else{
                            [self otherLoginWithOpenId:user.uid nickName:user.nickname avatar:user.icon sex:@"保密" type:1];
                        }
                       
                    }

                    else
                            {
                                NSLog(@"%@",error);
                            }
        }];
    }
}
-(void)otherLoginWithOpenId:(NSString *)openId nickName:(NSString *)nickName avatar:(NSString *)avatar sex:(NSString *)sex type:(int)type{
     __weak typeof(self)weakSelf = self;
    [LoginHandle thirdLoginWithOpenId:openId type:type nickName:nickName avatar:avatar sex:sex type:2 success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            NSLog(@"返回的个人信息==%@",dic);
            UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
            [UserInfoDefaults  saveUserInfo:model];
             weakSelf.loginSuccessBlock();
            //修改融云信息
              [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];
         
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
   -(void)pwdChange:(UIButton *)sender{
           sender.selected=!sender.selected;
           if (sender.selected==YES) {
               self.pwdTF.secureTextEntry=NO;
           }else{
               self.pwdTF.secureTextEntry=YES;
           }
       }

-(void)loginClick{
    __weak typeof(self)weakSelf = self;
    [LoginHandle loginWithPhone:self.phoneTF.text pwd:self.pwdTF.text type:0 success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
            [UserInfoDefaults  saveUserInfo:model];
             weakSelf.loginSuccessBlock();
            //修改融云信息
            NSLog(@"登陆之后的个人信息%@",dic);
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];
        }else
        {
            
//            [self.view toast:dic[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
   if (status == ConnectionStatus_Connected) {
       NSLog(@"融云服务器连接成功!");
   } else  {
       if (status == ConnectionStatus_SignUp) {
           NSLog(@"融云服务器断开连接!");
       } else {
           NSLog(@"融云服务器连接失败!");
       }
   }
}
@end
