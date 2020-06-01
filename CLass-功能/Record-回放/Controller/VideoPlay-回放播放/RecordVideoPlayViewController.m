//
//  RecordVideoPlayViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "RecordVideoPlayViewController.h"
#import "RecordHandle.h"
#import "LiveCompanyInfoViewController.h"
#import "bottomAlertView.h"
#import "MainHandle.h"
@import TXLiteAVSDK_UGC;
@interface RecordVideoPlayViewController ()<TXVodPlayListener,UIGestureRecognizerDelegate>{
  TXVodPlayer *        player;
  BOOL                 _appIsInterrupt;
  BOOL                 _videoPause;
  UISlider*   _playProgress;
  UISlider*   _playableProgress;
  UILabel*    _playDuration;
  UILabel*    _playStart;
  float       _sliderValue;
 long long   _trackingTouchTS;
 BOOL        _startSeek;
}
@property (nonatomic, strong) UIImageView     *   bgImage;
@property (nonatomic, retain)  UISlider       *   playProgress;
@property (nonatomic, strong) NSDictionary    *   dictionary;
@end

@implementation RecordVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type intValue]==0) {
        [self loadData];
    }else{
        [self loadData];
    }
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;      // 手势有效设置为YES  无效为NO
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//
//   id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//
//     // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
//     UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//     panGesture.delegate = self; // 设置手势代理，拦截手势触发
//     [self.view addGestureRecognizer:panGesture];
//
//     // 一定要禁止系统自带的滑动手势
//     self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.naviView.leftItemButton.hidden=YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }

    return YES;
}
-(void)handleNavigationTransition:(UIPanGestureRecognizer *)tap{
    [self.navigationController popViewControllerAnimated:YES];
    [player removeVideoWidget];
       [player stopPlay];
        _playStart.text = @"00:00:00";
       [_playDuration setText:@"00:00:00"];
       [_playProgress setValue:0];
       [_playProgress setMaximumValue:0];
       [_playableProgress setValue:0];
       [_playableProgress setMaximumValue:0];
}
-(void)loadVideo{
    [RecordHandle getVideoDetailWithUid:[[UserInfoDefaults userInfo].uid intValue] videoId:[self.recordId intValue] success:^(id  _Nonnull obj) {
         self.dictionary=(NSDictionary *)obj;
                NSLog(@"视频回放%@",obj);
                if ([ self.dictionary[@"code"] intValue]==200) {
                    [self configUI];
                   
                    
                }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)loadData{
    [RecordHandle getRecordDetailWithUdi:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token recordId:[self.recordId intValue] success:^(id  _Nonnull obj) {
        self.dictionary=(NSDictionary *)obj;
        NSLog(@"获取视频视乎%@",obj);
        if ([ self.dictionary[@"code"] intValue]==200) {
            [self configUI];
           
            
        }else{
            [self.view toast:self.dictionary[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)configUI{
    NSLog(@"dictionary=%@",self.dictionary);
    self.bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bgImage.userInteractionEnabled=YES;
    self.bgImage.clipsToBounds=YES;
    self.bgImage.contentMode=UIViewContentModeScaleToFill;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:self.dictionary[@"data"][@"thumb"]]];
    [self.view addSubview:self.bgImage];
    
    UIView   *  bgView=[[UIView alloc]initWithFrame:CGRectMake(10.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+20*KScaleH, 120*KScaleW, 34*KScaleH)];
    bgView.backgroundColor=[UIColor colorWithHexString:@"#000000" alpha:0.8];
    bgView.userInteractionEnabled=YES;
    [bgView setRadius:16.75*KScaleH];
    [self.bgImage addSubview:bgView];
    
    UIImageView   *  avatarImage=[[UIImageView alloc]initWithFrame:CGRectMake(2*KScaleW, 2*KScaleH, 30*KScaleW, 30*KScaleH)];
    avatarImage.clipsToBounds=YES;
    [avatarImage setRadius:15.0];
    avatarImage.userInteractionEnabled=YES;
    avatarImage.contentMode=UIViewContentModeScaleToFill;
    [avatarImage sd_setImageWithURL:[NSURL URLWithString:self.dictionary[@"data"][@"head_path"]]];
    [bgView addSubview:avatarImage];
    UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
           [self.navigationController pushViewController:vc animated:NO];
           vc.uid=self.dictionary[@"data"][@"live_uid"];
          [player removeVideoWidget];
          [player stopPlay];
       }];
       [avatarImage addGestureRecognizer:tap];
    
    UILabel  *  nickName=[[UILabel alloc]initWithFrame:CGRectMake(avatarImage.right+4.5*KScaleW, 4*KScaleH, bgView.width-32*KScaleW, 13*KScaleH)];
    nickName.textAlignment=NSTextAlignmentLeft;
    nickName.textColor=[UIColor whiteColor];
    nickName.font=APP_NORMAL_FONT(13.0);
    nickName.text=self.dictionary[@"data"][@"nickname"];
    [bgView addSubview:nickName];
    
    UILabel * idLabel=[[UILabel alloc]initWithFrame:CGRectMake(avatarImage.right+4.5*KScaleW, nickName.bottom+5*KScaleH, bgView.width-32*KScaleW, 7*KScaleH)];
    idLabel.textAlignment=NSTextAlignmentLeft;
       idLabel.textColor=[UIColor whiteColor];
      idLabel.text=[NSString stringWithFormat:@"ID:%@",self.dictionary[@"data"][@"live_uid"]];
       idLabel.font=APP_NORMAL_FONT(10.0);
       [bgView addSubview:idLabel];
    
    UIImageView   *   clearBgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"record_base"]];
    clearBgImage.frame=CGRectMake(SCREEN_WIDTH-89*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+23*KScaleH, 79*KScaleW, 29*KScaleH);
    clearBgImage.contentMode=UIViewContentModeScaleToFill;
    clearBgImage.userInteractionEnabled=YES;
    [self.bgImage addSubview:clearBgImage];
    
    UIButton *  moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,clearBgImage.width/2 , clearBgImage.height)];
    [moreBtn setImage:[UIImage imageNamed:@"record_more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [clearBgImage addSubview:moreBtn];
    
    UIButton * closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(clearBgImage.width/2, 0, clearBgImage.width/2, clearBgImage.height)];
    [closeBtn setImage:[UIImage imageNamed:@"record_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [clearBgImage addSubview:closeBtn];
    player = [[TXVodPlayer alloc] init];
    player.vodDelegate=self;
    [player startPlay:self.dictionary[@"data"][@"url"]];
    [player setRenderMode:RENDER_MODE_FILL_EDGE];
    player.loop=YES;
    
    _playableProgress=[[UISlider alloc]initWithFrame:CGRectMake(64.5*KScaleW, SCREEN_HEIGHT-39.25*KScaleH, SCREEN_WIDTH-129*KScaleW, 2.5*KScaleH)];
       _playableProgress.maximumValue = 0;
       _playableProgress.minimumValue = 0;
       _playableProgress.value = 0;
       [_playableProgress setThumbImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 10)] forState:UIControlStateNormal];
        _playableProgress.backgroundColor=[UIColor clearColor];
       [_playableProgress setMaximumTrackTintColor:[UIColor clearColor]];
       _playableProgress.userInteractionEnabled = NO;
       [self.view addSubview:_playableProgress];
       
       _playProgress=[[UISlider alloc]initWithFrame:CGRectMake(64.5*KScaleW, SCREEN_HEIGHT-39.25*KScaleH, SCREEN_WIDTH-129*KScaleW, 2.5*KScaleH)];
       _playProgress.maximumValue = 0;
       _playProgress.minimumValue = 0;
       _playProgress.value = 0;
       _playProgress.continuous = NO;
      _playableProgress.backgroundColor=[UIColor colorWithHexString:@"#ffffff" alpha:1.0];
       [_playProgress addTarget:self action:@selector(onSeek:) forControlEvents:(UIControlEventValueChanged)];
       [_playProgress addTarget:self action:@selector(onSeekBegin:) forControlEvents:(UIControlEventTouchDown)];
       [_playProgress addTarget:self action:@selector(onDrag:) forControlEvents:UIControlEventTouchDragInside];
       [_playProgress setThumbImage:[UIImage imageNamed:@"record_slider"] forState:UIControlStateNormal];
       [self.view addSubview:_playProgress];
    
    _playStart=[[UILabel alloc]initWithFrame:CGRectMake(0,_playProgress.centerY-4*KScaleH , 64.5*KScaleW, 8*KScaleH)];
    _playStart.textColor=[UIColor whiteColor];
    _playStart.text=@"00:00:00";
    [self.view addSubview:_playStart];
    _playStart.textAlignment=NSTextAlignmentCenter;
    _playStart.font=APP_BOLD_FONT(10.0);
     
    _playDuration=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-64.5,_playProgress.centerY-4*KScaleH , 64.5*KScaleW, 8*KScaleH)];
      _playDuration.textColor=[UIColor whiteColor];
      _playDuration.text=@"00:00:00";
      [self.view addSubview:_playDuration];
      _playDuration.textAlignment=NSTextAlignmentCenter;
      _playDuration.font=APP_BOLD_FONT(10.0);
}
#pragma -- UISlider - play seek
-(void)onSeek:(UISlider *)slider{
    [player seek:_sliderValue];
    _trackingTouchTS = [[NSDate date]timeIntervalSince1970]*1000;
    _startSeek = NO;
    NSLog(@"vod seek drag end");
}

-(void)onSeekBegin:(UISlider *)slider{
    _startSeek = YES;
    NSLog(@"vod seek drag begin");
}

-(void)onDrag:(UISlider *)slider {
    float progress = slider.value;
    int intProgress = progress + 0.5;
    _playStart.text = [NSString stringWithFormat:@"%02d:%02d",(int)(intProgress / 60), (int)(intProgress % 60)];
    _sliderValue = slider.value;
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
    [player removeVideoWidget];
    [player stopPlay];
     _playStart.text = @"00:00:00";
    [_playDuration setText:@"00:00:00"];
    [_playProgress setValue:0];
    [_playProgress setMaximumValue:0];
    [_playableProgress setValue:0];
    [_playableProgress setMaximumValue:0];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [player removeVideoWidget];
    [player stopPlay];
     _playStart.text = @"00:00:00";
    [_playDuration setText:@"00:00:00"];
    [_playProgress setValue:0];
    [_playProgress setMaximumValue:0];
    [_playableProgress setValue:0];
    [_playableProgress setMaximumValue:0];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [player removeVideoWidget];
    [player stopPlay];
     _playStart.text = @"00:00:00";
    [_playDuration setText:@"00:00:00"];
    [_playProgress setValue:0];
    [_playProgress setMaximumValue:0];
    [_playableProgress setValue:0];
    [_playableProgress setMaximumValue:0];
}
-(void)moreClick{
    
    [MainHandle getLiveRecordShareWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token live_record_id:[self.recordId intValue]  success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
               if ([dic[@"code"] intValue]==200) {
                   bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                               [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                   alertV.shareTitle=dic[@"data"][@"title"];
                   alertV.shareDesc=dic[@"data"][@"desc"];
                   alertV.imageUrl=dic[@"data"][@"thumb"];
                   alertV.url=dic[@"data"][@"url"];
               }else{
//                   [self.view toast:dic[@"msg"]];
               }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param
{
    
    NSDictionary* dict = param;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (EvtID == PLAY_EVT_RCV_FIRST_I_FRAME) {
             [player setupVideoWidget:self.bgImage insertIndex:0];
        }
        
        if (EvtID == PLAY_EVT_VOD_LOADING_END || EvtID == PLAY_EVT_VOD_PLAY_PREPARED) {
          
        }
        
        if (EvtID == PLAY_EVT_PLAY_BEGIN) {


        } else if (EvtID == PLAY_EVT_PLAY_PROGRESS) {
            if (_startSeek) {
                return;
            }
            float progress = [dict[EVT_PLAY_PROGRESS] floatValue];
            float duration = [dict[EVT_PLAY_DURATION] floatValue];
            NSLog(@"%f",progress);
            int intProgress = progress + 0.5;
            _playStart.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intProgress / 60), (int)(intProgress % 60)];
            [_playProgress setValue:progress];
            
            int intDuration = duration + 0.5;
            if (duration > 0 && _playProgress.maximumValue != duration) {
                [_playProgress setMaximumValue:duration];
                [_playableProgress setMaximumValue:duration];
                _playDuration.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
            }
            [_playableProgress setValue:[dict[EVT_PLAYABLE_DURATION] floatValue]];
            return ;
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

@end
