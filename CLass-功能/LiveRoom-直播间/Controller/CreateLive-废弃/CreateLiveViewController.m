//
//  CreateLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CreateLiveViewController.h"
#import "VideoLiveTextView.h"
#import "LCActionAlertView.h"
#import "LiveExhibitionTypeViewController.h"
#import "LiveWorkTypeViewController.h"

@interface CreateLiveViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
//,AlivcLiveRoomNotifyDelegate,AlivcInteractiveLiveRoomAuthDelegate,AlivcInteractiveNotifyDelegate,AlivcInteractiveLiveRoomErrorDelegate,AlivcLiveRoomNetworkNotifyDelegate,AlivcLiveRoomPusherNotifyDelegate
@property (nonatomic, strong) UITableView    *   tableView;
@property (nonatomic, strong) NSArray        *   titleList;
@property (nonatomic, strong) NSMutableArray *   detailList;
@property (nonatomic, strong) VideoLiveTextView   *   textView;
@property (nonatomic, strong) UIImageView     *   bgImage;
//@property (nonatomic, strong) AlivcInteractiveLiveRoomConfig    *   roomConfig;
//@property (nonatomic, strong) AlivcInteractiveLiveRoom   *     liveRoom;
//@property (assign, nonatomic) BOOL     liveOn;
@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"创建直播";
    self.titleList=@[@"",@"直播标题",@"行业分类",@"展会分类",@"横竖屏",@"美颜",@"分享到"];
    [self tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text=self.detailList[indexPath.row];
    UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 22*KScaleH, 62.5*KScaleW, 17*KScaleH)];
       titleLabel.textColor=COLOR_333;
       titleLabel.textAlignment=NSTextAlignmentLeft;
       titleLabel.text=self.titleList[indexPath.row];
       titleLabel.font=APP_NORMAL_FONT(16.0);
       [cell addSubview:titleLabel];
       UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(15*KScaleW, 59*KScaleH, SCREEN_WIDTH-38*KScaleW, 0.5*KScaleH)];
       lineView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
       [cell addSubview:lineView];
    if (indexPath.row==0) {
        cell.accessoryType=UITableViewCellAccessoryNone;
       self.bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 211*KScaleH)];
        self.bgImage.image=[UIImage imageNamed:@"create_carema"];
        [cell addSubview:self.bgImage];
        self.bgImage.userInteractionEnabled=YES;
        self.bgImage.clipsToBounds=YES;
        self.bgImage.contentMode=UIViewContentModeScaleToFill;
        cell.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
        UIGestureRecognizer    *   tap=[[UIGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
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
        [self.bgImage addGestureRecognizer:tap];
    }else if(indexPath.row==1){
        self.textView = [[VideoLiveTextView alloc]initWithFrame:CGRectMake(14.5*KScaleW,titleLabel.bottom+10*KScaleH, SCREEN_WIDTH-29*KScaleW,cell.height-10*KScaleH)];
                         // 设置颜色
                         self.textView.backgroundColor = [UIColor whiteColor];
                         // 设置提示文字
                         self.textView.placehoder = @"输入你要直播的标题吧~";
                         // 设置提示文字颜色
                         self.textView.placehoderColor = COLOR_999;
                         // 设置textView的字体
                         self.textView.font = APP_NORMAL_FONT(14.0);
                         // 设置内容是否有弹簧效果
                         self.textView.alwaysBounceVertical = YES;
                         // 设置textView的高度根据文字自动适应变宽
                         self.textView.isAutoHeight = YES;
                         // 添加到视图上
                   [cell addSubview:self.textView];
          cell.backgroundColor=[UIColor whiteColor];
    }else  if (indexPath.row==6) {
        for (int i =0; i<4; i++) {
            UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(76*KScaleW+47.5*KScaleW*i, 18.5*KScaleH, 23*KScaleW, 23*KScaleH)];
            NSArray  *  btnImg=@[@"create_qq",@"create_ozone",@"create_wx",@"create_wx_friends"];
            [btn setImage:[UIImage imageNamed:btnImg[i]] forState:UIControlStateNormal];
            [cell addSubview:btn];
            btn.tag=i;
            [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            cell.backgroundColor=[UIColor whiteColor];
        }
    } else{
           cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_next"]];
           cell.backgroundColor=[UIColor whiteColor];
       }

    return cell;
}
-(void)share:(UIButton *)sender{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 2:{
            LiveWorkTypeViewController    *   vc=[[LiveWorkTypeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 3:{
            LiveExhibitionTypeViewController   *   vc=[[LiveExhibitionTypeViewController alloc]init];
            vc.returnValueBlock = ^(NSString *passedValue, NSString *typeId) {
                [self.detailList replaceObjectAtIndex:3 withObject:passedValue];
            };
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 4:{
            [LCActionAlertView showActionViewNames:@[@"横屏",@"竖屏"] completed:^(NSInteger index,NSString * name) {
                                                       if (index==0) {
                                                          
                                                       }else{
                                                       }
                                                   } canceled:^{

                                                   }];
        }
            break;
        case 5:
            break;
            
        default:
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==0) {
            return 221*KScaleH;
        }else if(indexPath.row==1){
            return 115*KScaleH;
        }else{
        return 59.5*KScaleH;
        }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
        return self.titleList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.naviView.bottom) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor=[UIColor colorWithHexString:@"#F1F1F1"];
        _tableView = tableView;
        tableView.separatorColor=[UIColor clearColor];
        tableView.tableFooterView=[self addFooterView];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}
-(UIView *)addFooterView{
    UIView  *  footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75.5*KScaleH)];
    footer.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    footer.userInteractionEnabled=YES;
    UIButton   *   startLive=[[UIButton alloc]initWithFrame:CGRectMake(47.5*KScaleW, 25*KScaleH, SCREEN_WIDTH-95*KScaleW, 40*KScaleH)];
    startLive.backgroundColor=APP_NAVI_COLOR;
    [startLive setRadius:20.0];
    [startLive setTitle:@"开始直播" forState:UIControlStateNormal];
    [startLive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startLive.titleLabel.font=APP_BOLD_FONT(15.0);
    [startLive addTarget:self action:@selector(startLive) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:startLive];
    return footer;
}
#pragma mark - 开始直播
-(void)startLive{
//    [AlivcInteractiveLiveBase setAppId:@""];
//    //设置用户信息
////    [AlivcInteractiveLiveBase  setUserInfo:@""];
////    //设置用户角色
////    [AlivcInteractiveLiveBase setUserRole:@""];
//
//    self.roomConfig = [[AlivcInteractiveLiveRoomConfig alloc] init];
//    self.roomConfig.region =  AlivcLiveRegionShangHai;
//    self.roomConfig.beautyOn =  YES;
//    self.roomConfig.cameraPosition = AlivcLiveCameraPositionFront;
//    self.roomConfig.resolution = AlivcLivePushResolution540P;
//    self.liveRoom = [[AlivcInteractiveLiveRoom alloc] initWithAppId:@"" config:self.roomConfig];
//    [self.liveRoom setRoomNotifyDelegate:self]; // 设置房间通知代理
//    [self.liveRoom setAuthDelegate:self]; // 设置鉴权通知代理
//    [self.liveRoom setInteractiveNotifyDelegate:self]; // 设置互动通知代理
//    [self.liveRoom setInteractiveLiveRoomErrorDelegate:self]; // 设置错误通知代理
//    [self.liveRoom setNetworkNotifyDelegate:self]; // 设置网络通知代理
//    [self.liveRoom setPusherNotifyDelegate:self]; // 主播端需要设置推流的代理
//    AlivcSts   *  sts=[[AlivcSts alloc]init];
//       sts.securityToken=@"";
//    [self.liveRoom login:sts];
//
//    LiveingViewController   *  vc=[[LiveingViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
//    AlivcUser  *  user=[[AlivcUser alloc]init];
//    user.userId=[UserInfoDefaults userInfo].uid;
//    [self.liveRoom enter:@"" user:user role:0 completion:^(AlivcLiveError *error, AlivcLiveRoomInfo *liveRoomInfo) {
//        //检查房间是否在直播
//        if(liveRoomInfo.roomStatus == AlivcRoomInfoRoomStatusOn) {
//            self.liveOn = YES;
//        }
////        //根据主播uid设置主播视频播放view
//        if(liveRoomInfo.anchorAppUid) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.liveRoom setRemoteView:vc.playerView micAppUid:liveRoomInfo.anchorAppUid];
//            });
//        }
//    }];
//
    
}

//- (void)onAlivcRoomUpMic:(NSString *)userId {
//     //主播开始直播通知
//}
//
//
//- (void)onStsWillBeExpireSoonWithAccessKey:(NSString *)accessKey secretKey:(NSString *)secretKey expireTime:(NSString *)expireTime token:(NSString *)token afterTime:(NSUInteger)time {
//   //token 即将过期，申请新的token
//    AlivcSts   *  sts=[[AlivcSts alloc]init];
//    sts.securityToken=token;
//    [self.liveRoom refreshSts:sts];
//}
//
////SDK 在STS Token 已经过期时会每隔10秒上报一次已经过期的通知。
//
//- (void)onStsExpiredWithAccessKey:(NSString *)accessKey secretKey:(NSString *)secretKey expireTime:(NSString *)expireTime token:(NSString *)token {
//    //token 已经过期，申请新的token
//    AlivcSts   *  sts=[[AlivcSts alloc]init];
//       sts.securityToken=token;
//       [self.liveRoom refreshSts:sts];
//}





- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
    [self.bgImage setImage:rightImage];
   
  
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
-(NSMutableArray *)detailList{
    if (!_detailList) {
        _detailList=[NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    }
    return _detailList;
}
@end
