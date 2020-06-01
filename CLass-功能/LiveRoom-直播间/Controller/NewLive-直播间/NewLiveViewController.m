//
//  NewLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "NewLiveViewController.h"
#import "LCActionAlertView.h"
#import "LiveHandle.h"
#import "LiveExhibitionTypeViewController.h"
#import "SRWebSocket.h"
#import "NewStartLiveViewController.h"
#import "StartLiveLeftViewController.h"
#import "BeautyViewController.h"
@interface NewLiveViewController ()<AlivcLivePusherInfoDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherNetworkDelegate,AlivcLivePusherBGMDelegate,AlivcLivePusherSnapshotDelegate,AlivcLivePusherCustomFilterDelegate,AlivcLivePusherCustomDetectorDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,SRWebSocketDelegate,LDImagePickerDelegate>{
      MBProgressHUD *  hud;
}
@property (nonatomic, strong) AlivcLivePushConfig   *   liveConfig;
@property (nonatomic, strong) AlivcLivePushConfig   *   config;
@property (nonatomic, strong) AlivcLivePusher       *   livePusher;
@property (nonatomic, strong) UIImageView           *   uploadImage;
@property (nonatomic, strong) UITextField           *   titleTF;
@property (nonatomic, strong) SRWebSocket           *   webSocket;
@property (nonatomic, strong) UIButton              *   leftBtn;
@property (nonatomic, strong) UIButton              *   portaitBtn;
@property (nonatomic, strong) NSString              *   workID;
@property (nonatomic, strong) NSDictionary          *   liveDid;
@end

@implementation NewLiveViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    [self initConfig];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
//    [self.livePusher stopPreview];
    NSUserDefaults * defaultes=[NSUserDefaults standardUserDefaults];
          [defaultes removeObjectForKey:@"shareLiveType"];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//     [self.livePusher stopPreview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self initConfig];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initConfig];
    [self configUI];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess:) name:ShareSuccessNotification object:nil];
    NSUserDefaults * defaultes=[NSUserDefaults standardUserDefaults];
       [defaultes removeObjectForKey:@"shareLiveType"];
   
}
-(void)initConfig{
  UIView  *  screView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    screView.userInteractionEnabled=YES;
      screView.clipsToBounds=YES;
      [self.view addSubview:screView];
    self.
    liveConfig = [[AlivcLivePushConfig alloc]init];
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
    [self.livePusher startPreview:self.view];
}
-(void)configUI{
    
  
     
    
    UIButton  *  closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(14.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleW, 18*KScaleW, 18*KScaleW)];
    [closeBtn setImage:[UIImage imageNamed:@"live_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    UIButton  *   carema=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-32.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleW, 18*KScaleW, 18*KScaleW)];
    [carema setImage:[UIImage imageNamed:@"live_carema"] forState:UIControlStateNormal];
     [carema setImage:[UIImage imageNamed:@"live_carema"] forState:UIControlStateSelected];
    [carema addTarget:self action:@selector(caremaFont:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carema];
    
    UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(15*KScaleW, 80*KScaleH, SCREEN_WIDTH-30*KScaleW, 100*KScaleH)];
    bgView.backgroundColor=[UIColor colorWithRed:17/255.0 green:17/255.0 blue:20/255.0 alpha:0.5];
    [self.view addSubview:bgView];
    [bgView setRadius:5];
    bgView.clipsToBounds=YES;
    bgView.userInteractionEnabled=YES;
    
    self.uploadImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_upload"]];
    self.uploadImage.frame=CGRectMake(15*KScaleW, 15*KScaleH, 105*KScaleW, bgView.height-30*KScaleH);
    self.uploadImage.userInteractionEnabled=YES;
    self.uploadImage.clipsToBounds=YES;
    self.uploadImage.contentMode=UIViewContentModeScaleAspectFill;
    [bgView addSubview:self.uploadImage];
    
    UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self btnClick];
      
     }];
     [self.uploadImage addGestureRecognizer:tap];
    
    self.titleTF=[[UITextField alloc]initWithFrame:CGRectMake(self.uploadImage.right+10.5*KScaleW, 15*KScaleH,bgView.width
                                                              -40.5*KScaleW,15.5*KScaleH)];
    self.titleTF.backgroundColor=[UIColor clearColor];
    self.titleTF.delegate=self;
    [bgView addSubview: self.titleTF];
      NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"好的标题能吸引更多用户哦！" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
 NSFontAttributeName:self.titleTF.font}];

         self.titleTF.attributedPlaceholder = attrString;

   
    self.titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleTF.font = [UIFont systemFontOfSize:13.f];
    self.titleTF.textColor=[UIColor whiteColor];
    
    UIButton  * workSel=[[UIButton alloc]initWithFrame:CGRectMake(self.uploadImage.right+10.5*KScaleW, self.uploadImage.bottom-20*KScaleH, 90*KScaleW, 20*KScaleH)];
    [workSel setTitle:@"添加行业分类" forState:UIControlStateNormal];
    workSel.titleLabel.font=APP_NORMAL_FONT(12.0);
    [workSel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workSel.backgroundColor=APP_NAVI_COLOR;
    [workSel addTarget:self action:@selector(selWork:) forControlEvents:UIControlEventTouchUpInside];
    [workSel setRadius:10.0];
    [bgView addSubview:workSel];
    
    for (int i=0; i<4; i++) {
        UIButton  *   shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(80*KScaleW+65.5*KScaleW*i, SCREEN_HEIGHT-131 *KScaleH, 21*KScaleW, 21*KScaleH)];
        NSArray  *  normalImg=@[@"qq_whit",@"zone_white",@"wx_white",@"friends_white"];
        NSArray  *  selImg=@[@"QQ",@"QQ空间",@"微信好友",@"微信朋友圈"];
        [shareBtn setImage:[UIImage imageNamed:normalImg[i]] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:selImg[i]] forState:UIControlStateSelected];
        shareBtn.tag=i+100;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareBtn];
    }
    
    UIButton * beautyBtn=[[UIButton alloc]initWithFrame:CGRectMake(15*KScaleW, SCREEN_HEIGHT-90 *KScaleH, 115*KScaleW, 40*KScaleH)];
    beautyBtn.backgroundColor=[UIColor whiteColor];
    [beautyBtn setImage:[UIImage imageNamed:@"live_Beauty"] forState:UIControlStateNormal];
    [beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
    [beautyBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
    beautyBtn.titleLabel.font=APP_NORMAL_FONT(15.0);
    [self.view addSubview:beautyBtn];
    [beautyBtn setRadius:20*KScaleH];
    [beautyBtn addTarget:self action:@selector(startBeauty) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton  *  startLive=[[UIButton alloc]initWithFrame:CGRectMake(beautyBtn.right+15*KScaleW, SCREEN_HEIGHT-90 *KScaleH, 215*KScaleW, 40*KScaleH)];
    startLive.backgroundColor=APP_NAVI_COLOR;
       [startLive setTitle:@"开始直播" forState:UIControlStateNormal];
       [startLive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       startLive.titleLabel.font=APP_NORMAL_FONT(15.0);
       [self.view addSubview:startLive];
       [startLive setRadius:20*KScaleH];
       [startLive addTarget:self action:@selector(startLive) forControlEvents:UIControlEventTouchUpInside];
    

//     self.liveConfig = [[AlivcLivePushConfig alloc]init];
//        self.liveConfig.resolution = AlivcLivePushResolution540P;
//        self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.liveConfig];
//        [self.livePusher setInfoDelegate:self];
//        [self.livePusher setErrorDelegate:self];
//        [self.livePusher setNetworkDelegate:self];
//        [self.livePusher setBGMDelegate:self];
//        [self.livePusher setSnapshotDelegate:self];
//        [self.livePusher setCustomFilterDelegate:self];
//        [self.livePusher setCustomDetectorDelegate:self];
//        [self.livePusher startPreview:screView];
}
#pragma mark - 关闭画面
-(void)close{
   
    [self.livePusher stopPreview];
    if([LandScreenTool isOrientationLandscape]){
    [LandScreenTool forceOrientation: UIInterfaceOrientationPortrait];
    }
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 转化摄像头
-(void)caremaFont:(UIButton *)sender{
    [self.livePusher switchCamera];
    NSUserDefaults  *  defaults=[NSUserDefaults standardUserDefaults];

    sender.selected=!sender.selected;
    if (sender.selected) {
        self.config.cameraType=AlivcLivePushCameraTypeFront;
         NSLog(@"%ld",(long)self.config.cameraType);
        [defaults setObject:@"1" forKey:@"caremaType"];
        
    }else{
        self.config.cameraType=AlivcLivePushCameraTypeBack;
         NSLog(@"%ld",(long)self.config.cameraType);
          [defaults setObject:@"0" forKey:@"caremaType"];
    }
   
}
#pragma mark - 上传封面图片
-(void)btnClick{
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//                             imagePickerController.delegate = self;
//                             imagePickerController.allowsEditing = NO;
//                             [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
//                                 if (index==0) {
//                                     imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//                                     [self presentViewController:imagePickerController animated:YES completion:nil];
//                                 }else{
//                                     imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                                     [self presentViewController:imagePickerController animated:YES completion:nil];
//                                 }
//                             } canceled:^{
//
//                             }];
    
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
           imagePicker.delegate = self;
    [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
                                     if (index==0) {
                                          [imagePicker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:(250*KScaleW-50)/SCREEN_WIDTH];
                                     }else{
                                          [imagePicker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:(250*KScaleW-50)/SCREEN_WIDTH];
                                     }
                                 } canceled:^{
    
                                 }];

}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    
 
     [self.uploadImage setImage:editedImage];
  

}




//#pragma mark - 上传头像
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
//    UIImage *rightImage = [UIImage imageWithData:imgData];
//    [self.uploadImage setImage:rightImage];
//
//
//}
//-(UIImage *)fixOrientation:(UIImage *)aImage {
//    if (aImage.imageOrientation == UIImageOrientationUp)
//        return aImage;
//
//    CGAffineTransform transform = CGAffineTransformIdentity;
//
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//        default:
//            break;
//    }
//
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//        default:
//            break;
//    }
//
//    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
//                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
//                                             CGImageGetColorSpace(aImage.CGImage),
//                                             CGImageGetBitmapInfo(aImage.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (aImage.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
//            break;
//
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
//            break;
//    }
//
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}
#pragma mark - 获取行业分类
-(void)selWork:(UIButton *)sender{
    LiveExhibitionTypeViewController  *  vc=[[LiveExhibitionTypeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.returnValueBlock = ^(NSString *passedValue, NSString *typeId) {
        [sender setTitle:passedValue forState:UIControlStateNormal];
        self.workID=typeId;
        
    };
}
#pragma mark - 分享
-(void)shareClick:(UIButton *)sender{
     sender.selected=!sender.selected;
       for (int i=0; i<4; i++) {
           if (sender.tag==100+i) {
               sender.selected=YES;
               NSString  *  str=[NSString stringWithFormat:@"%d",i+1];
               NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
               [userDefaults setObject:str forKey:@"shareLiveType"];
               continue;
           }
           UIButton  *  btn=(UIButton *)[self.view viewWithTag:i+100];
           btn.selected=NO;
       }
}

#pragma mark - 设置美颜参数

-(void)startBeauty{
    BeautyViewController  *  vc=[[BeautyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    vc.returnValueBlock = ^(NSString *beauty) {
        self.liveConfig.beautyOn = true; // 开启美颜
        self.liveConfig.beautyMode = AlivcLivePushBeautyModeNormal;//设定为高级美颜
        self.liveConfig.beautyWhite = [beauty intValue]; // 美白范围0-100
        self.liveConfig.beautyBuffing = [beauty intValue]; // 磨皮范围0-100
        self.liveConfig.beautyRuddy = [beauty intValue];// 红润设置范围0-100
        self.liveConfig.beautyBigEye = [beauty intValue];// 大眼设置范围0-100
        self.liveConfig.beautyThinFace = [beauty intValue];// 瘦脸设置范围0-100
        self.liveConfig.beautyShortenFace = [beauty intValue];// 收下巴设置范围0-100
        self.liveConfig.beautyCheekPink = [beauty intValue];// 腮红设置范围0-100;
    };
}

#pragma mark - 开启直播
-(void)startLive{
    if ([self.titleTF.text isEmpty]) {
        [self.view toast:@"请输入直播标题"];
        return;
    }
    if ([self.workID isEmpty]) {
        [self.view toast:@"请选择行业分类"];
        return;
    }
    if (self.uploadImage.image==nil) {
        [self.view toast:@"请上传封面图片"];
        return;
    }
    [self createLive];
}
#pragma mark - 横屏直播
-(void)leftClick:(UIButton *)sender{
    sender.selected=!sender.selected;
 
}
//MARK: - 视图旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if ([LandScreenTool isOrientationLandscape]) {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
             } completion:nil];
         }
         else {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 self.view.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
             } completion:nil];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     }];
}
-(void)dealloc{
      [[NSNotificationCenter defaultCenter] removeObserver:self name:ShareSuccessNotification object:nil];
}
-(void)shareWithDesc:(NSString *)desc imageUrl:(NSString *)imageUrl title:(NSString *)title videoUrl:(NSString *)videoUrl withDic:(NSDictionary *)dic{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:desc
                                images:imageUrl
                                   url:[NSURL URLWithString:videoUrl]
                                 title:title
                                  type:SSDKContentTypeAuto];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
   int type=[[userDefaults objectForKey:@"shareLiveType"] intValue];
    NewStartLiveViewController  *  vc=[[NewStartLiveViewController alloc]init];
     vc.dic=dic;
    
    switch (type) {
        case 4:{
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:{
[self.navigationController pushViewController:vc animated:NO];
                       
                    }
                        break;
                        
                    default:
                        {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                        }
                        break;
                }
            }];
            
        }
            break;
            case 3:{
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
[self.navigationController pushViewController:vc animated:NO];
                          
                        }
                            break;
                            
                        default:
                            {
                                [self.navigationController popToRootViewControllerAnimated:YES];
                                
                            }
                            break;
                    }
                }];
                
            }
            
            break;
            case 2:{
                [ShareSDK share:SSDKPlatformSubTypeQZone parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
//
                              [self.navigationController pushViewController:vc animated:NO];
                        }
                            break;
                            
                        default:
                            {
                                [self.navigationController popToRootViewControllerAnimated:YES];
//                                 [self createLive];
                            }
                            break;
                    }
                }];
                
            }
            
            break;
            case 1:{
                [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
                         
[self.navigationController pushViewController:vc animated:NO];
                             
                        }
                            break;{
                                [self.navigationController popToRootViewControllerAnimated:YES];
                                
                            }
                            
                        default:
                            break;
                    }
                }];
                
            }
            
            break;
            
        default:
            break;
    }
}
-(void)createLive{
     NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NewStartLiveViewController  *  vc=[[NewStartLiveViewController alloc]init];
                               
                               
         hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [LiveHandle createLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token title:self.titleTF.text thumb:self.uploadImage.image isScreen:0 exhibition_id:[self.workID intValue] success:^(id  _Nonnull obj) {

           NSDictionary * dic=(NSDictionary *)obj;
           if ([dic[@"code"] intValue]==200) {
                [hud hideAnimated:YES];
                [LiveHandle updateLiveTypeWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token stream:dic[@"data"][@"stream"] success:^(id  _Nonnull obj) {
                    NSDictionary * dictionary=(NSDictionary *)obj;
                    if ([dictionary[@"code"] intValue]==200) {
                        int type=[[userDefaults objectForKey:@"shareLiveType"] intValue];
                         if (type==0) {
                               vc.dic=dic;
                             [self.navigationController pushViewController:vc animated:NO];
                         }else{
                              [LiveHandle getLiveShareWithUid:[[UserInfoDefaults userInfo].uid intValue]  token:[UserInfoDefaults userInfo].token liveUid:[[UserInfoDefaults userInfo].uid intValue]  stream:dic[@"data"][@"stream"] success:^(id  _Nonnull obj) {
                                          NSDictionary  *  shareDic=(NSDictionary *)obj;
                                  if ([dic[@"code"] intValue]==200) {
                                                     [self shareWithDesc:shareDic[@"data"][@"desc"] imageUrl:shareDic[@"data"][@"thumb"] title:shareDic[@"data"][@"title"] videoUrl:shareDic[@"data"][@"url"] withDic:dic];
                                                 }else{
                                                     [self.view toast:dic[@"msg"]];
                                                 }
                                     } failed:^(id  _Nonnull obj) {

                                     }];


                    }
                    }else
                    {
                        [self.view toast:dic[@"msg"]];
                    }
                      } failed:^(id  _Nonnull obj) {

                      }];
           }else{
                [hud hideAnimated:YES];
               [self.view toast:dic[@"msg"]];
           }


       } failed:^(id  _Nonnull obj) {
           [self.view toast:@"请求超时，请重试"];
            [hud hideAnimated:YES];
       }];
}

@end
