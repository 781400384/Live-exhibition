//
//  CompanyForgetViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CompanyForgetViewController.h"
#import "LoginHandle.h"
@interface CompanyForgetViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField    *     phoneTF;
@property (nonatomic, strong) UITextField    *     pwdTF;
@property (nonatomic, strong) UITextField    *     codeTF;
@property (nonatomic, strong) UITextField    *     companyTF;

@end

@implementation CompanyForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"忘记密码";
    [self configUI];
}

-(void)configUI{
    #pragma mark - 忘记密码
        for (int a= 0; a<4; a++) {
    
               UITextField   *   tf=[[UITextField alloc]initWithFrame:CGRectMake(39*KScaleW,self.naviView.bottom+24*KScaleH+60*KScaleH*a, SCREEN_WIDTH-78*KScaleW, 47*KScaleH)];
               tf.backgroundColor=[UIColor whiteColor];
               tf.delegate=self;
               [self.view addSubview:tf];
               NSArray  *  array=@[@"输入公司账号(公司名称)",@"  输入手机号码",@"输入验证码",@"输入密码"];
               tf.placeholder=array[a];
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
            if (a==0) {
              self.phoneTF=tf;
            }
               if (a==1) {
                   self.pwdTF=tf;
                   tf.leftView=numCodeBtn;
                   [tf setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
                   tf.leftViewMode=UITextFieldViewModeAlways;
               }
               if (a==2) {
                   self.codeTF=tf;
                   tf.rightView = codeBtn;
                   tf.rightViewMode = UITextFieldViewModeAlways;
                   tf.keyboardType = UIKeyboardTypeNumberPad;
               }
               if (a==3) {
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
}
-(void)pwdChange:(UIButton *)sender{
    sender.selected=!sender.selected;
}
/**获取短信验证码*/
- (void)getCodeAction:(UIButton *)sender{
    
    [LoginHandle getMsgCodeWithPhone:self.phoneTF.text success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
        [self.view toast:@"发送成功"];
        [sender beginCountDownWithDuration:SMS_TIME_INTERVAL];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
    
   
   
    
}
-(void)loginClick{
     [LoginHandle loginWithPhone:self.phoneTF.text pwd:self.pwdTF.text type:1 success:^(id  _Nonnull obj) {
         NSDictionary  *  dic=(NSDictionary *)obj;
         NSLog(@"dic=====%@",dic);
         if ([dic[@"code"] intValue]==200) {
             [self.view toast:@"密码修改成功"];
             [self.navigationController popViewControllerAnimated:YES];
           
         }else{
//             [self.view toast:dic[@"msg"]];
         }
     } failed:^(id  _Nonnull obj) {
         
     }];
}
@end
