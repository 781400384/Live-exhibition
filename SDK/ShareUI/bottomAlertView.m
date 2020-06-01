//
//  bottomAlertView.m
//  LzhAlertView
//
//  Created by 刘中华 on 2019/12/11.
//  Copyright © 2019 LZH. All rights reserved.
//  底部

#import "bottomAlertView.h"
#import "UIColor+LZHExtension.h"
#import "UIButton+ImageTitleSpacing.h"
#import "ToolTipView.h"
/* 屏幕尺寸 */
#define Screen_W   [UIScreen mainScreen].bounds.size.width
#define Screen_H   [UIScreen mainScreen].bounds.size.height

@interface bottomAlertView ()

@property(nonatomic,strong)UIView * bgView ;
@property(nonatomic,strong)UILabel * tipsLabel ;
@property(nonatomic,strong)UIButton * cancelBtn ;

@property(nonatomic,strong)NSArray * titleArr ;

@end

@implementation bottomAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
        [self showAlertView];
    }
    return self;
}

#pragma mark -- 事件
//显示
-(void)showAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithString:@"000000" alpha:0.4] ;
        self.bgView.frame = CGRectMake(0, Screen_H-210, Screen_W, 210) ;
    }] ;
}

//隐藏
-(void)removeAlertView{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithString:@"000000" alpha:0.0] ;
        self.bgView.frame = CGRectMake(0, Screen_H, Screen_W, 210) ;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }] ;
}

-(void)btnAction:(UIButton *)sender{
    [self removeAlertView];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:self.shareDesc
                                images:self.imageUrl
                                   url:[NSURL URLWithString:self.url]
                                 title:self.shareTitle
                                  type:SSDKContentTypeAuto];
    switch (sender.tag) {
        case 0:
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
                    parameters:params
                onStateChanged:^(SSDKResponseState state, NSDictionary *userData,
               SSDKContentEntity *contentEntity, NSError *error) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               NSLog(@"成功");//成功
                                [[NSNotificationCenter defaultCenter] postNotificationName:ShareSuccessNotification object:nil];
                               break;
                           case SSDKResponseStateFail:
                          {
                            NSLog(@"--%@",error.description);
                               //失败
                               break;
                          }
                           case SSDKResponseStateCancel:
                               //取消
                               break;

                           default:
                               break;
                       }
                   }];
            break;
        case 1:
                       [ShareSDK share:SSDKPlatformSubTypeWechatSession
                                         parameters:params
                                     onStateChanged:^(SSDKResponseState state, NSDictionary *userData,
                                    SSDKContentEntity *contentEntity, NSError *error) {
                                            switch (state) {
                                                case SSDKResponseStateSuccess:
                                                    NSLog(@"成功");//成功
                                                     [[NSNotificationCenter defaultCenter] postNotificationName:ShareSuccessNotification object:nil];
                                                    break;
                                                case SSDKResponseStateFail:
                                               {
                                                 NSLog(@"--%@",error.description);
                                                    //失败
                                                    break;
                                               }
                                                case SSDKResponseStateCancel:
                                                    //取消
                                                    break;

                                                default:
                                                    break;
                                            }
                                        }];
            break;
        case 2:
                       [ShareSDK share:SSDKPlatformSubTypeQZone
                                                               parameters:params
                                                           onStateChanged:^(SSDKResponseState state, NSDictionary *userData,
                                                          SSDKContentEntity *contentEntity, NSError *error) {
                                                                  switch (state) {
                                                                      case SSDKResponseStateSuccess:
                                                                          NSLog(@"成功");//成功
                                                                           [[NSNotificationCenter defaultCenter] postNotificationName:ShareSuccessNotification object:nil];
                                                                          break;
                                                                      case SSDKResponseStateFail:
                                                                     {
                                                                       NSLog(@"--%@",error.description);
                                                                          //失败
                                                                          break;
                                                                     }
                                                                      case SSDKResponseStateCancel:
                                                                          //取消
                                                                          break;

                                                                      default:
                                                                          break;
                                                                  }
                                                              }];
            break;
        case 3:
                       [ShareSDK share:SSDKPlatformSubTypeQQFriend
                                                                                     parameters:params
                                                                                 onStateChanged:^(SSDKResponseState state, NSDictionary *userData,
                                                                                SSDKContentEntity *contentEntity, NSError *error) {
                                                                                        switch (state) {
                                                                                            case SSDKResponseStateSuccess:
                                                                                                NSLog(@"成功");//成功
                                                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:ShareSuccessNotification object:nil];
                                                                                                break;
                                                                                            case SSDKResponseStateFail:
                                                                                           {
                                                                                             NSLog(@"--%@",error.description);
                                                                                                //失败
                                                                                                break;
                                                                                           }
                                                                                            case SSDKResponseStateCancel:
                                                                                                //取消
                                                                                                break;

                                                                                            default:
                                                                                                break;
                                                                                        }
                                                                                    }];
            break;
        default:
            break;
    }
   
}

#pragma mark -- UI
-(void)creatSubView{
    self.backgroundColor = [UIColor colorWithString:@"000000" alpha:0.0] ;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAlertView)]];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tipsLabel];
    [self.bgView addSubview:self.cancelBtn];
    
    self.titleArr = @[@"微信朋友圈",@"微信好友",@"QQ空间",@"QQ"];
    CGFloat  btnW = Screen_W/4 ;
    for (int i=0; i<self.titleArr.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(btnW*i, 50, btnW, 92)];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.titleArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.titleArr[i]] forState:UIControlStateHighlighted];
        btn.titleLabel.font=  [UIFont systemFontOfSize:12 weight:UIFontWeightLight] ;
        [btn setTitleColor:[UIColor colorWithString:@"251848"] forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:LZHButtonEdgeInsetsStyleTop imageTitleSpace:10];
        btn.tag = i ;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }
}


-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, 210)];
        _bgView.backgroundColor = [UIColor colorWithString:@"F6F6F6"] ;
    }
    return _bgView ;
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Screen_W, 20)];
        _tipsLabel.text = @"分享至" ;
        _tipsLabel.textColor = [UIColor colorWithString:@"818299"] ;
        _tipsLabel.font = [UIFont systemFontOfSize:14] ;
        _tipsLabel.textAlignment = 1 ;
        
        UIView * leftLinkView = [[UIView alloc]initWithFrame:CGRectMake(120, (20-0.6)/2, 40, 0.6)];
        leftLinkView.backgroundColor = [UIColor colorWithString:@"C6C4CF"] ;
        [_tipsLabel addSubview:leftLinkView];

        UIView * rightLinkView = [[UIView alloc]initWithFrame:CGRectMake(Screen_W-40-120, (20-0.6)/2, 40, 0.6)];
        rightLinkView.backgroundColor = [UIColor colorWithString:@"C6C4CF"] ;
        [_tipsLabel addSubview:rightLinkView];
    }
    return _tipsLabel ;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 160, Screen_W, 50)];
        _cancelBtn.backgroundColor = [UIColor whiteColor] ;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15] ;
        [_cancelBtn setTitleColor:[UIColor colorWithString:@"251848"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(removeAlertView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn ;
}

@end
