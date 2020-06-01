//
//  NewVideoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "NewVideoViewController.h"
#import "LiveCompanyInfoViewController.h"
#import "bottomAlertView.h"
#import "LoginViewController.h"

#import "YPDouYinLikeAnimation.h"
#import "ZMCusCommentView.h"
#import "VideoHandle.h"
#import "CommentView.h"
@import TXLiteAVSDK_UGC;
@interface NewVideoViewController ()<TXVodPlayListener,UIGestureRecognizerDelegate>{
      TXVodPlayer *        player;
    BOOL                 _appIsInterrupt;
     BOOL                 _videoPause;
    ZMCusCommentView *view;
}


@end

@implementation NewVideoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"url==%@",self.model.url);
    self.view.backgroundColor = [UIColor blackColor];
    self.playerView=[[VideoPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.playerView];
    self.playerView.userInteractionEnabled=YES;
    self.playerView.model=self.model;
    player = [[TXVodPlayer alloc] init];
    player.vodDelegate=self;
    [player setLoop:YES];
    [player startPlay:self.model.url];
    player.loop=YES;
    
    [self.playerView.backBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer   *    iconTap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        if ([UserInfoDefaults isLogin]) {
            LiveCompanyInfoViewController  *  vc=[[LiveCompanyInfoViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:NO];
                   vc.uid=self.model.uid;
                   vc.userType=self.model.is_spot;
                   vc.showType=@"1";
            [player pause];
        }else{
            [self goLogin];
        }
       
    }];
    [self.playerView.avatarImage addGestureRecognizer:iconTap];
    [self.playerView.shareBtn addTarget:self action:@selector(shareShow) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView.judgeBtn addTarget:self action:@selector(showJudge) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView.playBtn addTarget:self action:@selector(palyResume) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [player pause];
        [self.playerView showPlayBtn];
    }];

    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [self.playerView addGestureRecognizer:singleFingerOne];
    
    UITapGestureRecognizer *singleFingerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTap:)];

    singleFingerTwo.numberOfTouchesRequired = 1;
    singleFingerTwo.numberOfTapsRequired = 2;
    singleFingerTwo.delegate = self;
     [self.playerView addGestureRecognizer:singleFingerTwo];
    [singleFingerOne requireGestureRecognizerToFail:singleFingerTwo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendJudge:) name:SendJudgeNotification object:nil];
}
//-(void)sendJudge:(NSNotification *)msg{
//    NSDictionary  * dic=msg.userInfo;
//    NSLog(@"fasong=%@  %@",self.model.video_id,dic[@"text"]);
//    [VideoHandle sendJudgeWithVideoId:11 uid:[[UserInfoDefaults userInfo].uid intValue] tken:[UserInfoDefaults userInfo].token content:dic[@"text"] success:^(id  _Nonnull obj) {
//           NSDictionary * dic=(NSDictionary *)obj;
////           [self.view toast:dic[@"msg"]];
//           if ([dic[@"code"] intValue]==200) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:SendJusgeNotificationSuccess object:nil];
//           }
//       } failed:^(id  _Nonnull obj) {
//
//       }];
//}
-(void)twoTap:(UITapGestureRecognizer *)tap{
    [[YPDouYinLikeAnimation shareInstance]createAnimationWithTap:tap];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
      [player startPlay:self.model.url];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
    [player removeVideoWidget];
    [player stopPlay];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [player removeVideoWidget];
    [player stopPlay];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [player removeVideoWidget];
    [player stopPlay];
   
}
-(void)palyResume{
    [player resume];
    [self.playerView hidePlayBtn];
}
-(void)shareShow{
    if ([UserInfoDefaults isLogin]) {
        [self getShareInfo];
    }else{
        [self goLogin];
    }
}
-(void)getShareInfo{
    [VideoHandle getVideoShareWithVideoId:[self.model.video_id intValue] uid:[[UserInfoDefaults userInfo].uid intValue] success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        [[UIApplication sharedApplication].keyWindow addSubview:alertV];
            alertV.shareTitle=dic[@"data"][@"title"];
            alertV.shareDesc=dic[@"data"][@"desc"];
            alertV.imageUrl=dic[@"data"][@"thumb"];
            alertV.url=dic[@"data"][@"url"];
        }else{
//            [self.view toast:dic[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
   
}
-(void)showJudge{
    view = [[ZMCusCommentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   [[UIApplication sharedApplication].keyWindow addSubview:view];
    view.videoId=self.model.video_id;
    
    [view showViewWithVideoId:[self.model.video_id intValue]];
   
    
//    CommentView * alertV = [[CommentView alloc]initWithFrame:CGRectMake(0, 217*KScaleH, SCREEN_WIDTH, SCREEN_HEIGHT-217*KScaleH)];
//                                   [[UIApplication sharedApplication].keyWindow addSubview:alertV];
//   [[ZMCusCommentManager shareManager] showCommentWithSourceId:self.model.video_id];
//    alertV.videoId=self.model.video_id;
   
    NSLog(@"videoId=%@",self.model.video_id);
}

-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
{
    
    NSDictionary* dict = param;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (EvtID == PLAY_EVT_RCV_FIRST_I_FRAME) {
             [player setupVideoWidget:self.playerView.coverImage insertIndex:0];
        }
        
        if (EvtID == PLAY_EVT_VOD_LOADING_END || EvtID == PLAY_EVT_VOD_PLAY_PREPARED) {
          
        }
        
        if (EvtID == PLAY_EVT_PLAY_BEGIN) {
            if (player.height>player.width) {
                 [player setRenderMode:RENDER_MODE_FILL_SCREEN];
            }else{
                 [player setRenderMode:RENDER_MODE_FILL_EDGE];
            }

        } else if (EvtID == PLAY_EVT_PLAY_PROGRESS) {
        } else if (EvtID == PLAY_ERR_NET_DISCONNECT || EvtID == PLAY_EVT_PLAY_END || EvtID == PLAY_ERR_FILE_NOT_FOUND || EvtID == PLAY_ERR_HLS_KEY || EvtID == PLAY_ERR_GET_PLAYINFO_FAIL) {
           
            if (EvtID == PLAY_ERR_NET_DISCONNECT) {
                NSString* Msg = (NSString*)[dict valueForKey:EVT_MSG];
                [self.view toast:Msg];
            }
        } else if (EvtID == PLAY_EVT_PLAY_LOADING){
        }
        else if (EvtID == PLAY_EVT_CONNECT_SUCC) {
        
        } else if (EvtID == PLAY_EVT_CHANGE_ROTATION) {
            return;
        }
        
    });
}

- (void)onAppDidEnterBackGround:(UIApplication*)app {
    if (_appIsInterrupt == NO) {
        if (!_videoPause) {
            [player pause];
        }
        _appIsInterrupt = YES;
    }
}

- (void)onAppWillEnterForeground:(UIApplication*)app {
    if (_appIsInterrupt == YES) {
        if (!_videoPause) {
            [player resume];
        }
        _appIsInterrupt = NO;
    }
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    [player pause];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[YPDouYinLikeAnimation shareInstance] createAnimationWithTouch:touches withEvent:event];
//    [player pause];
//    [self.playerView showPlayBtn];
}

@end
