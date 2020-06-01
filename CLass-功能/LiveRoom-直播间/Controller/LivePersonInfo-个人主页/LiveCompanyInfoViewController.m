//
//  LiveCompanyInfoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LiveCompanyInfoViewController.h"
#import "VCOneViewController.h"
#import "VCTwoViewController.h"
#import "VCThreeViewController.h"
#import "LCActionAlertView.h"
#import "bottomAlertView.h"
#import "EditCompanyViewController.h"
#import "MainHandle.h"
#import "VideoHandle.h"
#import "VCOneViewController.h"
#import "VCTwoViewController.h"
#import "VCThreeViewController.h"
#import "MineHandle.h"
#import "ChatViewController.h"
#define NeedStartMargin 10   // 首列起始间距
#define NeedFont 14   // 需求文字大小
#define NeedBtnHeight 25   // 按钮高度
@interface LiveCompanyInfoViewController ()
@property (nonatomic, strong) NSArray  *  array;
@property (nonatomic, strong) UIButton *  lastBtn;
@property (nonatomic, strong) NSDictionary    *    dictionary;
@end

@implementation LiveCompanyInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"uid ==%@",self.uid);

    // Do any additional setup after loading the view.
   
     self.view.backgroundColor = [UIColor whiteColor];
     [self configUI];
    
     
}
-(void)configUI{
    //标题数组
        NSArray *data = @[@"企业墙",@"企业视频",@"直播记录"];
        //控制器数组
        NSMutableArray *vcArr = [NSMutableArray new];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            VCOneViewController  *  cx=[VCOneViewController new];
            cx.uid=self.uid;
            cx.naviView.hidden=YES;
            [vcArr addObject:cx];
            VCTwoViewController  *  mc=[VCTwoViewController new];
            mc.uid=self.uid;
                       mc.naviView.hidden=YES;
            [vcArr addObject:mc];
            VCThreeViewController *vc = [VCThreeViewController new];
            vc.uid=self.uid;
                       vc.naviView.hidden=YES;
            [vcArr addObject:vc];
        }];

        WMZPageParam *param = PageParam()
        .wTitleArrSet(data)
        .wControllersSet(vcArr)
        .wMenuTitleColorSet([UIColor colorWithHexString:@"#666666"])

        .wMenuTitleWidthSet(SCREEN_WIDTH/3)
        .wMenuTitleSelectColorSet(APP_NAVI_COLOR)
//        .wMenuTitleSelectFont(24.0)
         .wMenuAnimalTitleBigSet(YES)
    
        //悬浮开启
        .wTopSuspensionSet(YES)
        //顶部可下拉
        .wBouncesSet(YES)
        //头视图y坐标从0开始
        .wFromNaviSet(NO)
        //导航栏透明度变化
        .wNaviAlphaSet(YES)
        //头部
        .wMenuHeadViewSet(^UIView *{
            
            UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450*KScaleH)];
            bgView.backgroundColor=[UIColor whiteColor];
            [VideoHandle getOtherUserInfoWithUid:[[UserInfoDefaults userInfo].uid intValue] visit_uid:[self.uid intValue] success:^(id  _Nonnull obj) {
                  NSDictionary * dic=(NSDictionary *)obj;
                  NSLog(@"返回的g信息=%@",dic);
                if ([dic[@"code"] intValue]==200) {
                    
                
                  self.dictionary=dic;
                          UIImageView   *  bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*KScaleH)];
                    [bgImage sd_setImageWithURL:[NSURL URLWithString:self.dictionary[@"data"][@"bg_img"]] placeholderImage:[UIImage imageNamed:@"companyInfo_uploadImage"]];;
                                 bgImage.userInteractionEnabled=YES;
                                 bgImage.clipsToBounds=YES;
                                 bgImage.contentMode=UIViewContentModeScaleToFill;
                                 [bgView addSubview:bgImage];
                    CAGradientLayer *gl = [CAGradientLayer layer];
                           gl.frame = CGRectMake(0,0,SCREEN_WIDTH,200*KScaleH);
                           
                           gl.startPoint = CGPointMake(0, 0);
                           gl.endPoint = CGPointMake(1, 1);
                           gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
                           gl.locations = @[@(0.0),@(1.0)];
                       
                           [bgImage.layer addSublayer:gl];
                                 CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
                                   UIButton *    _leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
                                   _leftItemButton.frame = CGRectMake(13, y, 24*KScaleW,24*KScaleW);
                                  [_leftItemButton setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
                                 [bgImage addSubview:_leftItemButton];
                                 [_leftItemButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
                    if ([self.showType isEqualToString:@"0"]) {
                        UIButton *    _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
                                                             _rightItemButton.frame = CGRectMake(SCREEN_WIDTH-53*KScaleW,y+4*KScaleH, 40*KScaleW,16*KScaleW);
                                                             _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:16];
                                                   [_rightItemButton setTitle:@"更多" forState:UIControlStateNormal];
                                                      [bgImage addSubview:_rightItemButton];
                                                      [_rightItemButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
                                                      
                    }else{
     UIButton *    _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
           _rightItemButton.frame = CGRectMake(SCREEN_WIDTH-36.5*KScaleW, y,24*KScaleW,24*KScaleW);
           _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightItemButton setImage:[UIImage imageNamed:@"live_share"] forState:UIControlStateNormal];
    [bgImage addSubview:_rightItemButton];
    [_rightItemButton addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
                    }
                                  
                                 
                                 
                                 UIImageView   *  avatarImage=[[UIImageView alloc]initWithFrame:CGRectMake(15*KScaleW, bgImage.bottom+15*KScaleW, 50*KScaleW, 50*KScaleW)];
                                 [avatarImage setRadius:25*KScaleW];
                                 avatarImage.contentMode=UIViewContentModeScaleAspectFill;
                                 avatarImage.clipsToBounds=YES;
                                 [avatarImage sd_setImageWithURL:[NSURL URLWithString:self.dictionary
                                 [@"data"][@"head_path"]]];
                                 [bgView addSubview:avatarImage];
                                 
                                 UILabel   *  nickeName=[[UILabel alloc]initWithFrame:CGRectMake(avatarImage.right+15*KScaleW, bgImage.bottom+21*KScaleH, SCREEN_WIDTH/2-30*KScaleW, 19*KScaleH)];
                                 nickeName.textAlignment=NSTextAlignmentLeft;
                                 nickeName.font=APP_BOLD_FONT(20.0);
                                 nickeName.textColor=COLOR_333;
                                 nickeName.text=self.dictionary[@"data"][@"nickname"];
                                 [bgView addSubview:nickeName];
                                 
                                 UILabel  *  idIlabel=[[UILabel alloc]initWithFrame:CGRectMake(avatarImage.right+15*KScaleW, nickeName.bottom+10*KScaleH, SCREEN_WIDTH/2-30*KScaleW, 11.5*KScaleH)];
                                 idIlabel.textAlignment=NSTextAlignmentLeft;
                                 idIlabel.font=APP_NORMAL_FONT(12.0);
                                 idIlabel.textColor=COLOR_333;
                                 idIlabel.text=[NSString stringWithFormat:@"ID：%@",self.dictionary[@"data"][@"uid"]];
                                 [bgView addSubview:idIlabel];
                                 
                                 UILabel  *  rqueset=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, bgImage.bottom+24*KScaleH, SCREEN_WIDTH/2-15*KScaleW, 11.5*KScaleH)];
                                 rqueset.textAlignment=NSTextAlignmentRight;
                                 rqueset.font=APP_NORMAL_FONT(12.0);
                                 rqueset.textColor=COLOR_333;
                                 rqueset.text=[NSString stringWithFormat:@"%d次访问",[self.dictionary[@"data"][@"visit_num"] intValue]];
                                 [bgView addSubview:rqueset];
                                 
                                 float butX = NeedStartMargin;
                                  float butY =avatarImage.bottom+ 25*KScaleH;
                                  CGFloat height=25*KScaleH;
                             //     NSArray   *  array=SEARCH_HISTORY;
                            self.array=[self.dictionary[@"data"][@"cate_item"] componentsSeparatedByString:@","];
                          for(int i = 0; i < self.array.count; i++){

                                         //宽度自适应计算宽度
                                         NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
                                         CGRect frame_W = [self.array[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
                                         
                                         //宽度计算得知当前行不够放置时换行计算累加Y值
                                         if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
                                             butX = NeedStartMargin;
                                             butY += (NeedBtnHeight+10);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
                                             height+=NeedBtnHeight+10;
                                         }
                                         //设置计算好的位置数值
                                         UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX,butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
                                         //设置内容
                                         [btn setTitle:self.array[i] forState:UIControlStateNormal];
                                         btn.tag = i;
                                         //设置圆角
                                         btn.layer.cornerRadius =2.5;//2.0是圆角的弧度，根据需求自己更改
                                         [btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
                                         btn.backgroundColor=[UIColor whiteColor];
                                         btn.layer.borderWidth=0.5*KScaleW;
                                         btn.layer.borderColor=[UIColor colorWithHexString:@"#e5e5e5"].CGColor;
                                         btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                                         butX = CGRectGetMaxX(btn.frame)+15;
                                         [bgView addSubview:btn];
                                     if (i==self.array.count-1) {
                                         if (self.array.count==0) {
                                             [self.lastBtn setTitle:@"暂无标签" forState:UIControlStateNormal];
                                         }
                                         self.lastBtn=btn;
                                     }
                                     }
                                 UILabelSet  *   descripeLabel=[[UILabelSet alloc]initWithFrame:CGRectMake(15*KScaleW, self.lastBtn.bottom+24.5*KScaleH, SCREEN_WIDTH-15*KScaleW, 53.5*KScaleH)];
                                 descripeLabel.textAlignment=NSTextAlignmentLeft;
                                 descripeLabel.font=APP_NORMAL_FONT(14.0);
                                 descripeLabel.textColor=COLOR_333;
                                 descripeLabel.numberOfLines=0;
                                 descripeLabel.text=self.dictionary[@"data"][@"user_sign"];
                    [bgView addSubview:descripeLabel];
                    
                }else{
//                    [self.view toast:dic[@"msg"]];
                }
              } failed:^(id  _Nonnull obj) {
                  
              }];
            
            return bgView;
        });
        
        self.param = param;

      //延时0.1秒
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 下拉刷新
          __weak LiveCompanyInfoViewController *weakSelf = self;
          self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [weakSelf.downSc.mj_header endRefreshing];
              });
          }];

      });
    UIView  *  lineBgVew=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44.5*KScaleH, SCREEN_WIDTH, 44.5*KScaleH)];
    lineBgVew.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:lineBgVew];
    UIView   *  lineView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44*KScaleH, SCREEN_WIDTH, 0.5*KScaleH)];
       lineView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
       [lineBgVew addSubview:lineView];
       UIButton *  attentionBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,1*KScaleH, (SCREEN_WIDTH-0.5*KScaleW)/2, 43.5*KScaleH)];
       attentionBtn.backgroundColor=[UIColor whiteColor];
      if ([self.userType isEqualToString:@"0"]||[self.dictionary[@"data"][@"is_spot"] isEqualToString:@"0"]) {
           [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
           [attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
       }else{
           [attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
           [attentionBtn setTitle:@"关注" forState:UIControlStateSelected];
       }
       attentionBtn.titleLabel.font=APP_BOLD_FONT(14.0);
      [attentionBtn addTarget:self action:@selector(attentionClick:) forControlEvents:UIControlEventTouchUpInside];
       [attentionBtn setTitleColor:[UIColor colorWithHexString:@"#646464"] forState:UIControlStateNormal];
       [lineBgVew addSubview:attentionBtn];
       
       UIButton * chatBtn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-0.5*KScaleW)/2+0.5*KScaleW, 1*KScaleH, (SCREEN_WIDTH-0.5*KScaleW)/2, 43.5*KScaleH)];
       chatBtn.backgroundColor=[UIColor whiteColor];
       [chatBtn setTitle:@"私信" forState:UIControlStateNormal];
    [chatBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
          dispatch_async(dispatch_get_main_queue(), ^{
               //主线程执行
           ChatViewController    *   chat=[[ChatViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:self.uid];
           chat.title =[NSString stringWithFormat:@"%@", self.dictionary[@"data"][@"nickname"]];
           [self.navigationController pushViewController:chat animated:YES];
               
           });
       }];
       chatBtn.titleLabel.font=APP_BOLD_FONT(14.0);
       [chatBtn setTitleColor:[UIColor colorWithHexString:@"#646464"] forState:UIControlStateNormal];
        [lineBgVew addSubview:chatBtn];
       UIView  *  shortLine=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-0.5*KScaleW)/2, SCREEN_HEIGHT-30*KScaleH, 0.5*KScaleH, 16*KScaleH)];
       shortLine.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
      [lineBgVew addSubview:shortLine];
    if ([self.showType isEqualToString:@"0"]) {

      }else{
          [self.view addSubview:lineBgVew];
           
      }
         
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)more{
    [LCActionAlertView showActionViewNames:@[@"编辑",@"分享"] completed:^(NSInteger index,NSString * name) {
                                 if (index==0) {
                                     EditCompanyViewController  *  vc=[[EditCompanyViewController alloc]init];
                                     
                                     [self.navigationController pushViewController:vc animated:NO];
                                 }else{
                                    [MineHandle getInfoShareWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token visit_uid:[self.uid intValue] success:^(id  _Nonnull obj) {
                                         NSDictionary  *  dic=(NSDictionary *)obj;
                                         if ([dic[@"code"] intValue]==200) {
                                             bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                                         [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                                             alertV.shareTitle=dic[@"data"][@"title"];
                                             alertV.shareDesc=dic[@"data"][@"desc"];
                                             alertV.imageUrl=dic[@"data"][@"thumb"];
                                             alertV.url=dic[@"data"][@"url"];
                                         }else{
//                                             [self.view toast:dic[@"msg"]];
                                         }
                                     } failed:^(id  _Nonnull obj) {
                                         
                                     }];
                                 }
                             } canceled:^{

                             }];
}
-(void)shareClick{
    [MineHandle getInfoShareWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token visit_uid:[self.uid intValue] success:^(id  _Nonnull obj) {
                                             NSDictionary  *  dic=(NSDictionary *)obj;
                                             if ([dic[@"code"] intValue]==200) {
                                                 bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                                             [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                                                 alertV.shareTitle=dic[@"data"][@"title"];
                                                 alertV.shareDesc=dic[@"data"][@"desc"];
                                                 alertV.imageUrl=dic[@"data"][@"thumb"];
                                                 alertV.url=dic[@"data"][@"url"];
                                             }else{
    //                                             [self.view toast:dic[@"msg"]];
                                             }
                                         } failed:^(id  _Nonnull obj) {
                                             
                                         }];
}
-(void)attentionClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if ([self.userType isEqualToString:@"0"]) {
        [self attention];
    }else{
        [self cancelAttention];
    }
}
-(void)attention{
    [MainHandle attentionUserWithUserId:[self.uid intValue] uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
//        [self.view toast:dic[@"msg"]];
    } failed:^(id  _Nonnull obj) {
        
    }];
    
}
-(void)cancelAttention{
    [MainHandle cancelAttentionWithUserId:[self.uid intValue] uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
//        [self.view toast:dic[@"msg"]];
        NSLog(@"f点击关注返回的信息===%@",dic);
    } failed:^(id  _Nonnull obj) {
        
    }];
}
@end
