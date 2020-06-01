//
//  AvatarSetViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "AvatarSetViewController.h"
#import "LCActionAlertView.h"
#import "MineHandle.h"
@interface AvatarSetViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
     MBProgressHUD *  hud;
}
@property (nonatomic, strong)  UIImageView    *    avatarImage;
@end

@implementation AvatarSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    [self.naviView.leftItemButton setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
    [self ConfigUI];
}
-(void)ConfigUI{
    
   self.avatarImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"avatar_set_default"]];
  
    [self.view addSubview:self.avatarImage];
    
    UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-120*KScaleW)/2, self.avatarImage.bottom+32.5*KScaleH, 120*KScaleW, 35*KScaleH)];
    btn.backgroundColor=[UIColor blackColor];
    [btn setRadius:2.5*KScaleH];
    [btn setTitle:@"更换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#E5E5E5"] forState:UIControlStateNormal];
    btn.titleLabel.font=APP_NORMAL_FONT(16.0);
    btn.layer.borderColor=COLOR_999.CGColor;
    btn.layer.borderWidth=0.5*KScaleW;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick{
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
}
#pragma mark - 上传头像
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
    [self.avatarImage setImage:rightImage];
   hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.label.text=@"上传中";
    [MineHandle uploadAvatarImageWith:rightImage Uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"头像返回=%@",dic);
        if ([dic[@"code"] intValue]==200) {
            UserInfoModel  *  model=[UserInfoModel mj_objectWithKeyValues:dic[@"data"]];
                       [UserInfoDefaults  saveUserInfo:model];
                       //修改融云信息
                       RCUserInfo *user = [RCUserInfo new];
                       user.name = model.nickname;;
            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:model.uid];
            [self.view toast:@"修改成功"];
                          [hud hideAnimated:YES];
        }else{
            [self.view toast:dic[@"msg"]];
            [hud hideAnimated:YES];
                           [self.view toast:@"修改失败"];
        }
    } failed:^(id  _Nonnull obj) {
        [hud hideAnimated:YES];
                       [self.view toast:@"修改失败"];
    }];
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

@end
