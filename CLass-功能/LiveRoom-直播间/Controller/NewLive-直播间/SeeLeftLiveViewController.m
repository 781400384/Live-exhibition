//
//  SeeLeftLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/26.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SeeLeftLiveViewController.h"
#import <AliyunPlayerSDK/AliyunPlayerSDK.h>
#import "SRWebSocket.h"
#import "LiveHandle.h"
#import "bottomAlertView.h"
#import "LiveCompanyInfoViewController.h"
#import "MainHandle.h"
@interface SeeLeftLiveViewController ()<UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate>{
    
     AliVcMediaPlayer *  player;
}
@property (nonatomic, strong) UIView   *   playerView;
@property (nonatomic, strong) SRWebSocket           *   webSocket;
@property (nonatomic, strong) UIView                *   playView;
@property (nonatomic, strong) UITableView           *   tableView;
@property (nonatomic, strong) NSMutableArray        *   dataList;
@property (nonatomic, strong) NSDictionary          *   dictionary;
@end

@implementation SeeLeftLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}
-(void)loadData{
    [LiveHandle userGetInWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token live_uid:[self.liveUid intValue] uccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            self.dictionary=dic;
//            self.userList=[LiveUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"corpse_list"]];
            [self configUI];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)configUI{
    self.playerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 226*KScaleH)];
    self.playerView.backgroundColor=[UIColor whiteColor];
    self.playerView.userInteractionEnabled=YES;
    self.playerView.clipsToBounds=YES;
    [self.view addSubview:self.playerView];
    player=[[AliVcMediaPlayer alloc]init];
    [player create:self.playerView];
    player.scalingMode=scalingModeAspectFitWithCropping;
    
    [player setRenderMirrorMode:renderMirrorHorizonMode];
    [player prepareToPlay:[NSURL URLWithString:self.dictionary[@"data"][@"pull_url"]]];
    [player play];
    
    UIButton  *  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(15*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 12*KScaleW, 17*KScaleH)];
    [backBtn setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(backBtn.right+13.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH-100*KScaleW, 17*KScaleH)];
    titleLabel.text=self.dictionary[@"data"][@"title"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=APP_NORMAL_FONT(16.0);
    [self.view addSubview:titleLabel];
    
    UIButton * shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-34*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 22*KScaleW, 22*KScaleH)];
    [shareBtn setImage:[UIImage imageNamed:@"live_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIButton  *  btn=[[UIButton alloc]initWithFrame:(CGRect)CGRectMake(SCREEN_WIDTH-33.5*KScaleW,197.5*KScaleH, 22*KScaleW, 22*KScaleW)];
    [btn setImage:[UIImage imageNamed:@"living_screen"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(screenClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - 关闭直播间
-(void)closeBtn{
    if([LandScreenTool isOrientationLandscape]){
        [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
        
    }else{
       [self.navigationController popToRootViewControllerAnimated:YES];
        [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
            NSLog(@"关闭直播间%@",obj);
            } failed:^(id  _Nonnull obj) {
        
        }];
         [player stop];
         [self.webSocket close];
    };
    
    
}

-(void)screenClick{
    if([LandScreenTool isOrientationLandscape])
        [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
    else
        [LandScreenTool forceOrientation: UIInterfaceOrientationLandscapeRight];
    [player setRenderRotate:renderRotate90];
       [player setScalingMode:scalingModeAspectFitWithCropping];
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if ([LandScreenTool isOrientationLandscape]) {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 self.playView.frame = self.view.bounds;
                   
             } completion:nil];
         }
         else {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 self.playView.frame = CGRectMake(0, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH,SCREEN_WIDTH*9/16);
             } completion:nil];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     }];
}
@end
