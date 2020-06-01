//
//  PublishVideoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/22.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "PublishVideoViewController.h"
#import "VideoLiveTextView.h"
#import "LCActionAlertView.h"
#import "MineHandle.h"

#import "VideoHandle.h"
@interface PublishVideoViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    UIImageView  *  iconImg;
    MBProgressHUD *  hud;
}

@property (nonatomic, strong) VideoLiveTextView   *   textView;
@end

@implementation PublishVideoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    TXVodPlayer  *  player=[[TXVodPlayer alloc]init];
                               [player stopPlay];
                               [player removeVideoWidget];
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"发布视频";
    NSUserDefaults * defaultes=[NSUserDefaults standardUserDefaults];
    [defaultes removeObjectForKey:@"shareType"];
    [self configUI];
}

-(void)configUI{
    self.textView = [[VideoLiveTextView alloc]initWithFrame:CGRectMake(10*KScaleW,self.naviView.bottom+10*KScaleH, SCREEN_WIDTH-114*KScaleW, 145*KScaleH)];
    // 设置颜色
    self.textView.backgroundColor = [UIColor whiteColor];
    // 设置提示文字
    self.textView.placehoder = @"说点什么......";
    // 设置提示文字颜色
    self.textView.placehoderColor = COLOR_999;
    // 设置textView的字体
    self.textView.font = APP_NORMAL_FONT(16.0);
    // 设置内容是否有弹簧效果
    self.textView.alwaysBounceVertical = YES;
    // 设置textView的高度根据文字自动适应变宽
    self.textView.isAutoHeight = YES;
    // 添加到视图上
    [self.view addSubview:self.textView];
    
    iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-104*KScaleW, self.naviView.bottom+10*KScaleH, 87.5*KScaleW, 125.5*KScaleH)];
    [iconImg setRadius:5.0];
    iconImg.clipsToBounds=YES;
    iconImg.image=[self getVideoPreViewImage:[NSURL URLWithString:self.videoUrl]];
    iconImg.contentMode=UIViewContentModeScaleAspectFill;
    iconImg.userInteractionEnabled=YES;
    UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
         UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                    imagePickerController.delegate = self;
                                    imagePickerController.allowsEditing = NO;
                                    [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
                                        if (index==0) {
                                            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                            [self presentViewController:imagePickerController animated:YES completion:nil];
                                        }else{
                                            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                            [self presentViewController:imagePickerController animated:YES completion:nil];
                                        }
                                    } canceled:^{

                                    }];
       
      }];
      [iconImg addGestureRecognizer:tap];
    [self.view addSubview:iconImg];
    
    UIView  *  lineView=[[UIView alloc]initWithFrame:(CGRect)CGRectMake(15*KScaleW, self.textView.bottom, SCREEN_WIDTH-30*KScaleW, 0.5*KScaleH)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    [self.view addSubview:lineView];
    
    UILabel  *  noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+23.5*KScaleH, 97*KScaleW, 13*KScaleH)];
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    noticeLabel.font=APP_NORMAL_FONT(12.0);
    noticeLabel.textColor=COLOR_333;
    noticeLabel.text=@"同时分享到";
    [self.view addSubview:noticeLabel];
    
    for (int i =0; i<4; i++) {
        UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(noticeLabel.right+51.5*KScaleW*i, lineView.bottom+17*KScaleH, 32*KScaleW, 32*KScaleW)];
        NSArray  *  selImh=@[@"qq_whit",@"zone_white",@"wx_white",@"friends_white"];
        NSArray  *  normalImg=@[@"QQ",@"QQ空间",@"微信好友",@"微信朋友圈"];
        [btn setImage:[UIImage imageNamed:normalImg[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selImh[i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(shareType:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+100;
        [self.view addSubview:btn];
    }
    
    UIButton  *  PublishBtn=[[UIButton alloc]initWithFrame:CGRectMake(16*KScaleW, SCREEN_HEIGHT-61*KScaleH, SCREEN_WIDTH-32*KScaleW, 41*KScaleH)];
    [PublishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PublishBtn setTitle:@"发布" forState:UIControlStateNormal];
    PublishBtn.backgroundColor=APP_NAVI_COLOR;
    [PublishBtn setRadius:20.5*KScaleH];
    [PublishBtn addTarget:self action:@selector(publishVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PublishBtn];
    
}
-(void)publishVideo{
    
    if ([self.textView.text isEmpty]) {
        [self.view toast:@"请输入标题"];
        return;
    }
     hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
           [MineHandle getQiNiuTokenWithSuccess:^(id  _Nonnull obj) {
                        NSDictionary * dic=(NSDictionary *)obj;
               NSLog(@"dtoken=%@",dic);
               hud.label.text=@"上传中";
                        QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
                            builder.useHttps = YES;
                        }];
                        
                        NSString * token = dic[@"data"][@"token"];
                        NSString * key = [self serial];
                        NSData *imageData = UIImagePNGRepresentation(iconImg.image);
                        QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
               [upManager putData:imageData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                   if(info.ok){
                       NSLog(@"上传成功弄");
                       NSString *  imageUrl=[NSString stringWithFormat:@"https://qiniu.bjzhanbotest.com/%@",resp[@"key"]];
                       [MineHandle publishVideoWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token title:self.textView.text thumb:imageUrl url:self.videoUrl success:^(id  _Nonnull obj) {
                           NSDictionary * dic=(NSDictionary *)obj;
                            NSLog(@"d伤处=%@",dic);
                           if ([dic[@"code"] intValue]==200) {
                               [self.view toast:@"发布成功"];
                                [hud hideAnimated:YES];
                            NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
                             int type=[[userDefaults objectForKey:@"shareType"] intValue];
                               if (type==0) {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }else{
                               [VideoHandle getVideoShareWithVideoId:[dic[@"data"][@"video_id"] intValue] uid:[[UserInfoDefaults userInfo].uid intValue] success:^(id  _Nonnull obj) {
                                       NSDictionary  *  dic=(NSDictionary *)obj;
                                       if ([dic[@"code"] intValue]==200) {
                                           [self shareWithDesc:self.textView.text imageUrl:imageUrl title:self.textView.text videoUrl:self.videoUrl];
                                          
                                       }else{
                                           [self.view toast:dic[@"msg"]];
                                           
                                       }
                                   } failed:^(id  _Nonnull obj) {
                                       
                                   }];
                               }
                               
                               
                               
                           }
                       } failed:^(id  _Nonnull obj) {
                            [hud hideAnimated:YES];
                       }];
                   }else{
                       NSLog(@"上传失败");
                   };
               } option:nil];
                    } failed:^(id  _Nonnull obj) {
                         [hud hideAnimated:YES];
                    }];
    
    
    
}
-(void)shareType:(UIButton *)sender{
    sender.selected=!sender.selected;
    for (int i=0; i<4; i++) {
        if (sender.tag==100+i) {
            sender.selected=YES;
            NSString  *  str=[NSString stringWithFormat:@"%d",i+1];
            NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:str forKey:@"shareType"];
            continue;
        }
        UIButton  *  btn=(UIButton *)[self.view viewWithTag:i+100];
        btn.selected=NO;
    }
}
#define kRandomLength 10
- (NSString *)serial
{
    //1.UUIDString
//    NSString *string = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    //2.时间戳
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",time];
    
    //3.随机字符串kRandomLength位
    static const NSString *kRandomAlphabet = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    
//    //==> UUIDString去掉最后一项,再拼接上"时间戳"-"随机字符串kRandomLength位"
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array removeLastObject];
    [array addObject:timeStr];
    [array addObject:randomString];
    return [array componentsJoinedByString:@""];
}
#pragma mark - 上传图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
    [iconImg setImage:rightImage];
   
   
}
-(UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
-(void)shareWithDesc:(NSString *)desc imageUrl:(NSString *)imageUrl title:(NSString *)title videoUrl:(NSString *)videoUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:desc
                                images:imageUrl
                                   url:[NSURL URLWithString:videoUrl]
                                 title:title
                                  type:SSDKContentTypeAuto];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
   int type=[[userDefaults objectForKey:@"shareType"] intValue];
    
    switch (type) {
        case 1:{
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
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
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
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
                [ShareSDK share:SSDKPlatformSubTypeQZone parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
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
            case 4:{
                [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:{
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
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
 -(UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
  
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
@end
