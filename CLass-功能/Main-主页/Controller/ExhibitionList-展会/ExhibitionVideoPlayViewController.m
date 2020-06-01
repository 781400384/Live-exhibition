//
//  ExhibitionVideoPlayViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ExhibitionVideoPlayViewController.h"
@import TXLiteAVSDK_UGC;
@interface ExhibitionVideoPlayViewController ()<TXVodPlayListener>{
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
@property (nonatomic, retain)  UIButton           *playBtn;
@end

@implementation ExhibitionVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
   
  
}
-(void)configUI{
    
    self.bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bgImage.userInteractionEnabled=YES;
    self.bgImage.clipsToBounds=YES;
    self.bgImage.contentMode=UIViewContentModeScaleToFill;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:self.path]];
    [self.view addSubview:self.bgImage];
     [self.bgImage addSubview:self.playBtn];
             [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.centerX.mas_equalTo(self.bgImage.mas_centerX);
                 make.centerY.mas_equalTo(self.bgImage.mas_centerY);
             }];
//    UIView   *  bgView=[[UIView alloc]initWithFrame:CGRectMake(10.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+20*KScaleH, 120*KScaleW, 34*KScaleH)];
//    bgView.backgroundColor=[UIColor colorWithHexString:@"#000000" alpha:0.8];
//    bgView.userInteractionEnabled=YES;
//    [bgView setRadius:16.75*KScaleH];
//    [self.bgImage addSubview:bgView];
    
 
    
  
    
//    UIImageView   *   clearBgImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"record_base"]];
//    clearBgImage.frame=CGRectMake(SCREEN_WIDTH-89*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+23*KScaleH, 79*KScaleW, 29*KScaleH);
//    clearBgImage.contentMode=UIViewContentModeScaleToFill;
//    clearBgImage.userInteractionEnabled=YES;
//    [self.bgImage addSubview:clearBgImage];
//
//    UIButton *  moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,clearBgImage.width/2 , clearBgImage.height)];
//    [moreBtn setImage:[UIImage imageNamed:@"record_more"] forState:UIControlStateNormal];
//    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
//    [clearBgImage addSubview:moreBtn];
    
    UIButton * closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-43.5*KScaleW,IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 39.5*KScaleW, 29*KScaleH)];
    [closeBtn setImage:[UIImage imageNamed:@"record_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImage addSubview:closeBtn];
    player = [[TXVodPlayer alloc] init];
    player.vodDelegate=self;
    [player startPlay:self.url];
    [player setRenderMode:RENDER_MODE_FILL_EDGE];
    player.loop=YES;
    
    _playableProgress=[[UISlider alloc]initWithFrame:CGRectMake(64.5*KScaleW, SCREEN_HEIGHT-28.25*KScaleH, SCREEN_WIDTH-129*KScaleW, 2.5*KScaleH)];
       _playableProgress.maximumValue = 0;
       _playableProgress.minimumValue = 0;
       _playableProgress.value = 0;
       [_playableProgress setThumbImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(20, 10)] forState:UIControlStateNormal];
        _playableProgress.backgroundColor=[UIColor clearColor];
       [_playableProgress setMaximumTrackTintColor:[UIColor clearColor]];
       _playableProgress.userInteractionEnabled = NO;
       [self.view addSubview:_playableProgress];
       
       _playProgress=[[UISlider alloc]initWithFrame:CGRectMake(64.5*KScaleW, SCREEN_HEIGHT-29.25*KScaleH, SCREEN_WIDTH-129*KScaleW, 2.5*KScaleH)];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [player pause];
    self.playBtn.hidden=NO;
}
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn=[[UIButton alloc]init];
        [_playBtn setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(resuse) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.hidden=YES;
    }
    return _playBtn;
}
-(void)resuse{
    [player resume];
    self.playBtn.hidden=YES;
}
@end
