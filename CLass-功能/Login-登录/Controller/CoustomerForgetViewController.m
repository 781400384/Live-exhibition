//
//  CoustomerForgetViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CoustomerForgetViewController.h"
#import "LoginHandle.h"
@interface CoustomerForgetViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField    *     phoneTF;
@property (nonatomic, strong) UITextField    *     pwdTF;
@property (nonatomic, strong) UITextField    *     codeTF;

@end

@implementation CoustomerForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self configUI];
    self.naviView.naviTitleLabel.text=@"忘记密码";
}
-(void)configUI{
    
      for (int i= 0; i<3; i++) {
               
               UITextField   *   tf=[[UITextField alloc]initWithFrame:CGRectMake(39*KScaleW, self.naviView.bottom+24*KScaleH+60*KScaleH*i, SCREEN_WIDTH-78*KScaleW, 47*KScaleH)];
               tf.backgroundColor=[UIColor whiteColor];
               tf.delegate=self;
               [self.view addSubview:tf];
               NSArray  *  array=@[@"  输入手机号码",@"输入验证码",@"输入密码"];

               tf.placeholder=array[i];
               tf.clearButtonMode = UITextFieldViewModeWhileEditing;
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
               
               UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                  [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                  codeBtn.backgroundColor = [UIColor whiteColor];
                  codeBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
                  codeBtn.frame = CGRectMake(0, 0, 90*KScaleW, 30*KScaleH);
               [codeBtn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
                  [codeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
               if (i==0) {
                   self.phoneTF=tf;
                   tf.leftView=numCodeBtn;
                   [tf setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
                   tf.leftViewMode=UITextFieldViewModeAlways;
               }
               if (i==1) {
                   self.codeTF=tf;
                   tf.rightView = codeBtn;
                   tf.rightViewMode = UITextFieldViewModeAlways;
                   tf.keyboardType = UIKeyboardTypeNumberPad;
               }
               if (i==2) {
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
           [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(rtgisterClick) forControlEvents:UIControlEventTouchUpInside];
    }
    /**获取短信验证码*/
- (void)getCodeAction:(UIButton *)sender{
 
        [LoginHandle getForMsgCodeWithPhone:self.phoneTF.text success:^(id  _Nonnull obj) {
            NSDictionary * dic=(NSDictionary *)obj;
                                if ([dic[@"code"] intValue]==200) {
                                [self.view toast:@"发送成功"];
                                [sender beginCountDownWithDuration:SMS_TIME_INTERVAL];
                                }else{
//                                     [self.view toast:dic[@"msg"]];
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
-(void)rtgisterClick{
   
        [LoginHandle forgetWithPhone:self.phoneTF.text code:self.codeTF.text pwd:self.pwdTF.text rePwd:self.pwdTF.text success:^(id  _Nonnull obj) {
            NSDictionary * dic=(NSDictionary *)obj;
                       if ([dic[@"code"] intValue]==200) {
                           [self.navigationController popViewControllerAnimated:YES];
                           [self.view toast:@"密码修改成功"];
                       }else{
//                           [self.view toast:dic[@"msg"]];
                       }
        } failed:^(id  _Nonnull obj) {
            
        }];
   
    
}
@end
