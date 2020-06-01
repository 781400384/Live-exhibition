//
//  CompanyRegisterViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CompanyRegisterViewController.h"

@interface CompanyRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField      *    companyNameTF;
@property (nonatomic, strong) UITextField      *    pwdTF;
@property (nonatomic, strong) UITextField      *    nameTF;
@property (nonatomic, strong) UITextField      *    cardNumTF;
@property (nonatomic, strong) UITextField      *    phoneTF;
@property (nonatomic, strong) UIImageView      *    licenseImageView;
@property (nonatomic, strong) UIImageView      *    cardFontImageView;
@property (nonatomic, strong) UIImageView      *    cardBackImageView;
@end

@implementation CompanyRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"申请账号";
    [self configUI];
}
-(void)configUI{
    UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, 40*KScaleH)];
    bgView.backgroundColor=APP_NAVI_COLOR;
    [self.view addSubview:bgView];
    
    UILabel   *   noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(19*KScaleW, 14*KScaleH, SCREEN_WIDTH-19*KScaleW, 12*KScaleH)];
    noticeLabel.textAlignment=NSTextAlignmentLeft;
    noticeLabel.font=APP_NORMAL_FONT(13.0);
    noticeLabel.textColor=[UIColor whiteColor];
    noticeLabel.text=@"以下信息均为必填项，为保证您的利益，请如实填写";
    [bgView addSubview:noticeLabel];
    for (int i=0; i<5; i++) {
        UILabel   *    label=[[UILabel alloc]initWithFrame:CGRectMake(15*KScaleW, bgView.bottom+51*KScaleH*i, 90*KScaleW, 50.5*KScaleH)];
        label.font=APP_NORMAL_FONT(15.0);
        label.text=@[@"公司名称",@"设置密码",@"真实姓名",@"身份证号",@"联系电话"][i];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=COLOR_333;
        [self.view addSubview:label];
        UITextField   *  tf=[[UITextField alloc]initWithFrame:CGRectMake(label.right+20*KScaleW,   bgView.bottom+51*KScaleH*i, SCREEN_WIDTH-110*KScaleW, 50.5*KScaleH)];
        tf.delegate=self;
        tf.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:tf];
        NSArray  *  array=@[@"请填写公司名称",@"请设置账号密码",@"请填写您的真实姓名",@"请填写您的身份证号",@"请填写您的联系电话"];
        tf.placeholder=array[i];
        tf.clearButtonMode=UITextFieldViewModeAlways;
        [self.view addSubview:tf];
        UIView   *  lineView=[[UIView alloc]initWithFrame:CGRectMake(0, tf.bottom, SCREEN_WIDTH, 0.5*KScaleH)];
        lineView.backgroundColor=[UIColor colorWithHexString:@"#D6D6D6"];
        [self.view addSubview:lineView];
        switch (i) {
            case 0:
                self.companyNameTF=tf;
                break;
            case 1:
                self.pwdTF=tf;
                break;
            case 2:
                self.nameTF=tf;
                break;
            case 3:
                self.cardNumTF=tf;
                break;
            case 4:
                self.phoneTF=tf;
                break;
            default:
                break;
        }
    }
    
    for (int i=0; i<3; i++) {
        UIImageView      *   image=[[UIImageView alloc]initWithFrame:CGRectMake(15*KScaleW+122.5*KScaleW*i, self.phoneTF.bottom+10*KScaleH, 100*KScaleW, 100*KScaleH)];
        NSArray  *  array=@[@"login_licnese",@"login_card_font",@"login_card_back"];
        image.image=[UIImage imageNamed:array[i]];
        [self.view addSubview:image];
        switch (i) {
            case 0:
                self.licenseImageView=image;
                break;
            case 1:
                self.cardFontImageView=image;
                break;
            case 2:
               self.cardBackImageView=image;
               break;
            default:
            break;
        }
    }
    UIImageView   *  bgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_example"]];
    bgImage.frame=CGRectMake(14.5*KScaleW, self.cardBackImageView.bottom+21*KScaleH, 234*KScaleW, 244*KScaleH);
    [self.view addSubview:bgImage];
    
    UIButton   *   loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(47.5*KScaleW, bgImage.bottom+16*KScaleH, SCREEN_WIDTH-95*KScaleW, 40*KScaleH)];
              loginBtn.backgroundColor=APP_NAVI_COLOR;
              [loginBtn setTitle:@"提交认证" forState:UIControlStateNormal];
              [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
              loginBtn.titleLabel.font=APP_NORMAL_FONT(15.0);
              [loginBtn setRadius:19.75*KScaleW];
              [self.view addSubview:loginBtn];
    
}
@end
