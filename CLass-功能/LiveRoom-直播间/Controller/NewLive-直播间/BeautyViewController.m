//
//  BeautyViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BeautyViewController.h"

#import "TKYSlider.h"
//整个屏幕的宽
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//整个屏幕的高
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//适配机型比例
#define kWidthScale (kScreenWidth / 375.0)
#define kHeightScale (kScreenHeight / 667.0)
//RGB颜色
#define kRGBColor(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//APP主题色
#define kMainColour kUIColorFromRGB(0xe6e6e6, 1)

@interface BeautyViewController ()<AlivcLivePusherInfoDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherNetworkDelegate,AlivcLivePusherBGMDelegate,AlivcLivePusherSnapshotDelegate,AlivcLivePusherCustomFilterDelegate,AlivcLivePusherCustomDetectorDelegate>
@property (nonatomic, strong) AlivcLivePushConfig   *   liveConfig;
@property (nonatomic, strong) AlivcLivePusher       *   livePusher;
@property (nonatomic, strong) UILabel               *   numLabel;
@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initConfigUI];
    [self configUI];
}
-(void)initConfigUI{
    
    UIView  *  screView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
       screView.userInteractionEnabled=YES;
       screView.clipsToBounds=YES;
       [self.view addSubview:screView];
       
             self.liveConfig = [[AlivcLivePushConfig alloc]init];
             self.liveConfig.resolution = AlivcLivePushResolution540P;
               self.liveConfig.previewDisplayMode=ALIVC_LIVE_PUSHER_PREVIEW_ASPECT_FILL;
             self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.liveConfig];
             [self.livePusher startPreview:screView];

}
-(void)configUI{
    UIButton  *  closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(14.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleW, 18*KScaleW, 18*KScaleW)];
      [closeBtn setImage:[UIImage imageNamed:@"live_close"] forState:UIControlStateNormal];
      [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:closeBtn];
    
    UIButton  *   save=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleW, 60*KScaleW, 18*KScaleW)];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [save addTarget:self action:@selector(saveBlock) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:save];
    
    
    TKYSlider *slider = [[TKYSlider alloc] initWithFrame:CGRectMake(71.5*KScaleW,SCREEN_HEIGHT-65*KScaleH, SCREEN_WIDTH-91.5*KScaleW
                                                                    , 2*KScaleH)];
       slider.minimumValue = 0;// 设置最小值
       slider.maximumValue = 100;// 设置最大值
       slider.value = 60;// 设置初始值
       // UIImage *image= [self OriginImage:[UIImage imageNamed:@"slide_btn"] scaleToSize:CGSizeMake(35, 35)];
       [slider setThumbImage:[UIImage imageNamed:@"slide_btn"] forState:UIControlStateNormal];
       [slider setThumbImage:[UIImage imageNamed:@"slide_btn"] forState:UIControlStateHighlighted];
       
       slider.continuous = YES;// 放开手值才确定下来
       slider.minimumTrackTintColor = kRGBColor(34, 130, 255, 1); //滑轮左边颜色，如果设置了左边的图片就不会显示
       slider.maximumTrackTintColor = kRGBColor(238, 238, 238, 1); //滑轮右边颜色，如果设置了右边的图片就不会显示
       [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
       [self.view addSubview:slider];
    
    
    
    
    self.numLabel=[[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, slider.centerY-6*KScaleH, 71.5*KScaleW, 12*KScaleH)];
    self.numLabel.textAlignment=NSTextAlignmentCenter;
    self.numLabel.textColor=[UIColor whiteColor];
    self.numLabel.font=APP_NORMAL_FONT(12.0);
    self.numLabel.text=@"60%";
    [self.view addSubview:self.numLabel];
}
- (void)sliderValueChanged:(UISlider *)slider{
    NSString  * str=[NSString stringWithFormat:@"%.lf",slider.value];;
    NSString  *  str1=@"%";
    self.numLabel.text=[NSString stringWithFormat:@"%@%@",str,str1];
    
    self.liveConfig.beautyOn = true; // 开启美颜
          self.liveConfig.beautyMode = AlivcLivePushBeautyModeNormal;//设定为高级美颜
          self.liveConfig.beautyWhite = [str intValue]; // 美白范围0-100
          self.liveConfig.beautyBuffing = [str intValue]; // 磨皮范围0-100
          self.liveConfig.beautyRuddy = [str intValue];// 红润设置范围0-100
          self.liveConfig.beautyBigEye = [str intValue];// 大眼设置范围0-100
          self.liveConfig.beautyThinFace = [str intValue];// 瘦脸设置范围0-100
          self.liveConfig.beautyShortenFace = [str intValue];// 收下巴设置范围0-100
          self.liveConfig.beautyCheekPink = [str intValue];// 腮红设置范围0-100
}
-(void)close{
   
    [self.livePusher stopPreview];
    if([LandScreenTool isOrientationLandscape]){
    [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
    }
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveBlock{
    if (self.returnValueBlock) {
        //将自己的值传出去，完成传值
        self.returnValueBlock( self.numLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
