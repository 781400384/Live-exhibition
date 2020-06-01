//
//  StartLiveLeftViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "StartLiveLeftViewController.h"
#import "SRWebSocket.h"
#import "LiveHandle.h"
#import "bottomAlertView.h"
@interface StartLiveLeftViewController ()<AlivcLivePusherInfoDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherNetworkDelegate,AlivcLivePusherBGMDelegate,AlivcLivePusherSnapshotDelegate,AlivcLivePusherCustomFilterDelegate,AlivcLivePusherCustomDetectorDelegate,SRWebSocketDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AlivcLivePushConfig   *   liveConfig;
@property (nonatomic, strong) AlivcLivePusher       *   livePusher;
@property (nonatomic, strong) SRWebSocket           *   webSocket;
@property (nonatomic, strong) UIView                *   playView;
@property (nonatomic, strong) UITableView           *   tableView;
@property (nonatomic, strong) NSMutableArray        *   dataList;
@end

@implementation StartLiveLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webSocket.delegate=nil;
    [self.webSocket close];
    [self configUILeft];
}

//横屏直播
-(void)configUILeft{
    self.playView=[[UIView alloc]initWithFrame:CGRectMake(0, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
    self.playView.backgroundColor=[UIColor whiteColor];
    self.playView.userInteractionEnabled=YES;
    self.playView.clipsToBounds=YES;
    [self.view addSubview:self.playView];
    self.liveConfig = [[AlivcLivePushConfig alloc]init];
    self.liveConfig.previewDisplayMode=ALIVC_LIVE_PUSHER_PREVIEW_ASPECT_FILL;
    self.liveConfig.resolution = AlivcLivePushResolution540P;
    self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.liveConfig];
    [self.livePusher setInfoDelegate:self];
    [self.livePusher setErrorDelegate:self];
    [self.livePusher setNetworkDelegate:self];
    [self.livePusher setBGMDelegate:self];
    [self.livePusher setSnapshotDelegate:self];
    [self.livePusher setCustomFilterDelegate:self];
    [self.livePusher setCustomDetectorDelegate:self];
    [self.livePusher startPreview:self.playView];
     NSString   *   str=self.dic[@"data"][@"push_url"];
     [self.livePusher startPushWithURL:str];
     self.webSocket=[[SRWebSocket alloc]initWithURL:[NSURL URLWithString:self.dic[@"data"][@"chartServer"]]];
     self.webSocket.delegate=self;
     [self.webSocket open];
    
    UIButton  *  backBtn=[[UIButton alloc]initWithFrame:CGRectMake(15*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 12*KScaleW, 17*KScaleH)];
    [backBtn setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:backBtn];
    
    UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(backBtn.right+13.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, SCREEN_WIDTH-100*KScaleW, 17*KScaleH)];
    titleLabel.text=self.dic[@"data"][@"title"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=APP_NORMAL_FONT(16.0);
    [self.playView addSubview:titleLabel];
    
    UIButton * shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-34*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 22*KScaleW, 22*KScaleH)];
    [shareBtn setImage:[UIImage imageNamed:@"live_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:shareBtn];
    
    UILabel  *  watchNum=[[UILabel alloc]initWithFrame:CGRectMake(15*KScaleW, titleLabel.bottom+156.5*KScaleH, 52*KScaleW, 12*KScaleH)];
    watchNum.textColor=[UIColor whiteColor];
    watchNum.textAlignment=NSTextAlignmentCenter;
    watchNum.font=APP_NORMAL_FONT(12.0);
    [self.playView addSubview:watchNum];
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.dic[@"data"][@"title"]]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        // 表情图片
    attch.image = [UIImage imageNamed:@"liveing_num"];
        // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 12*KScaleW, 12*KScaleH);
        // 创建带有图片的富文本
   NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
   [attri appendAttributedString:string]; //在文字后面添加图片
     //在文字下标第几个添加图片  0就是文字前面添加图片
   [attri insertAttributedString:string atIndex:0];
        // 用label的attributedText属性来使用富文本
   watchNum.attributedText = attri;
    
    UIButton  *  screenBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-34*KScaleW, shareBtn.bottom+148.5*KScaleH, 22*KScaleW, 22*KScaleH)];
    [screenBtn setImage:[UIImage imageNamed:@"living_screen"] forState:UIControlStateNormal];
    [screenBtn addTarget:self action:@selector(screenClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:screenBtn];
}
#pragma mark - 关闭直播间
-(void)closeBtn{
    if([LandScreenTool isOrientationLandscape]){
        [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
        
    }else{
       [self.navigationController popToRootViewControllerAnimated:YES];
        [self.livePusher stopPush];
        [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
            NSLog(@"关闭直播间%@",obj);
            } failed:^(id  _Nonnull obj) {
        
        }];
         [self.livePusher stopPreview];
         [self.webSocket close];
    };
    
    
}
#pragma mark - 分享
-(void)shareClick{
    [LiveHandle getLiveShareWithUid:[[UserInfoDefaults userInfo].uid intValue]  token:[UserInfoDefaults userInfo].token liveUid:[[UserInfoDefaults userInfo].uid intValue]  stream:self.dic[@"data"][@"stream"] success:^(id  _Nonnull obj) {
         NSDictionary  *  dic=(NSDictionary *)obj;
                if ([dic[@"code"] intValue]==200) {
                    bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                    alertV.shareTitle=dic[@"data"][@"title"];
                    alertV.shareDesc=dic[@"data"][@"desc"];
                    alertV.imageUrl=dic[@"data"][@"thumb"];
                    alertV.url=dic[@"data"][@"url"];
                }else{
//                    [self.view toast:dic[@"msg"]];
                }
    } failed:^(id  _Nonnull obj) {
        
    }];

}
#pragma mark - 全屏
-(void)screenClick{
    if([LandScreenTool isOrientationLandscape])
               [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
           else
               [LandScreenTool forceOrientation: UIInterfaceOrientationLandscapeRight];
       
}
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSData  *  data=[message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    [self.dataList addObject:dic];
//    [self.tableView reloadData];
    [self scrollToBottom];
    NSLog(@"聊天s室罅隙%@",dic);
}
-(void)scrollToBottom {
    if (self.dataList.count > 0) {
        if ([self.tableView numberOfRowsInSection:0] > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.tableView numberOfRowsInSection:0]-1) inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
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
