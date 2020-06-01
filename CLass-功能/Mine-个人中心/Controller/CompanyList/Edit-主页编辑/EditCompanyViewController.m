//
//  EditCompanyViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "EditCompanyViewController.h"
#import "VideoLiveTextView.h"
#import "LCActionAlertView.h"
#import "MainHandle.h"
#import "MainPageListModel.h"
#import "MineHandle.h"

#define NeedStartMargin 10   // 首列起始间距
#define NeedFont 14   // 需求文字大小
#define NeedBtnHeight 25   // 按钮
@interface EditCompanyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,LDImagePickerDelegate>{
    UIImageView   *  bgImage;
    MBProgressHUD *  hud;
}
@property (nonatomic, strong) NSArray  *  array;
@property (nonatomic, strong) UIButton *  lastBtn;
@property (nonatomic, strong) VideoLiveTextView   *   textView;
@property (nonatomic, strong) NSMutableArray              *             exhibitionList;
@property (nonatomic, strong) NSMutableArray      *    dataList;
@end

@implementation EditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"编辑主页";
    self.naviView.rightTitleLabel.text=@"保存";
    [self loadData];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)rightTitleLabelTap{
    if ([self.textView.text isEmpty]) {
        [self.view toast:@"请输入描述内容"];
        return;
    }
    if (self.dataList.count
        ==0) {
        [self.view toast:@"请选择行业标签"];
        return;
    }
  
    NSString *text = [self.dataList componentsJoinedByString:@","];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MineHandle editCompanyWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token bgImg:bgImage.image typeId:text sign:self.textView.text success:^(id  _Nonnull obj) {
                   NSDictionary * dic=(NSDictionary *)obj;
                  
                   if ([dic[@"code"] intValue]==200) {
                       [self.navigationController popToRootViewControllerAnimated:YES];
                        [self.view toast:@"修改成功"];
                       [hud hideAnimated:YES];
                   }else{
                       [self.view toast:@"修改失败"];
                        [hud hideAnimated:YES];
                   }
                   
                   NSLog(@"obj==%@",obj);
               } failed:^(id  _Nonnull obj) {
                   [self.view toast:@"请求超时，请重新编辑"];
                    [hud hideAnimated:YES];
               }];
            
      

   
}
-(void)loadData{
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
          
          [MainHandle getTypelistWithSuccess:^(id  _Nonnull obj) {
                 NSDictionary * dic=(NSDictionary *)obj;
                         NSLog(@"dic==%@",dic);
                      if ([dic[@"code"] intValue]==200) {
                          
                          self.exhibitionList=[MainPageListModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                          [self configUI];
                          [hud hideAnimated:YES];
                                }
                       
             } failed:^(id  _Nonnull obj) {
                 [hud hideAnimated:YES];
                 [self.view toast:@"加载失败"];
             }];
        });
 
   
}
-(void)configUI{
   bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, 200*KScaleH)];
    bgImage.userInteractionEnabled=YES;
    bgImage.image=[UIImage imageNamed:@"companyInfo_uploadImage"];
    bgImage.clipsToBounds=YES;
    bgImage.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:bgImage];
   
    UIButton  *  upload=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150*KScaleW)/2, bgImage.height-67.5*KScaleH, 150*KScaleW, 35*KScaleH)];
    [upload setRadius:2.5*KScaleH];
    [upload setTitle:@"上传公司背景墙" forState:UIControlStateNormal];
    [upload setTitleColor:COLOR_333 forState:UIControlStateNormal];
    upload.titleLabel.font=APP_NORMAL_FONT(14.0);
    [bgImage addSubview:upload];
    [upload addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    upload.backgroundColor=[UIColor whiteColor];
    
    UILabel  *  idIlabel=[[UILabel alloc]initWithFrame:CGRectMake(15.5*KScaleW, bgImage.bottom+24*KScaleH, SCREEN_WIDTH-15.5*KScaleW, 15.5*KScaleH)];
    idIlabel.textAlignment=NSTextAlignmentLeft;
    idIlabel.font=APP_BOLD_FONT(16.0);
    idIlabel.textColor=COLOR_333;
    idIlabel.text=@"所属行业数据";
    [self.view addSubview:idIlabel];
    
    
    float butX = NeedStartMargin;
     float butY =idIlabel.bottom+ 14.5*KScaleH;
     CGFloat height=25*KScaleH;
    
    for(int i = 0; i < self.exhibitionList.count; i++){
        MainPageListModel  *  model=self.exhibitionList[i];
            //宽度自适应计算宽度
            NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
            CGRect frame_W = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            
            //宽度计算得知当前行不够放置时换行计算累加Y值
            if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
                butX = NeedStartMargin;
                butY += (NeedBtnHeight+10);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
                height+=NeedBtnHeight+10;
            }
            //设置计算好的位置数值
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX,butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
            //设置内容
        [btn addTarget:self action:@selector(selecType:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:model.title forState:UIControlStateNormal];
            btn.tag = i;
            //设置圆角
            btn.layer.cornerRadius =2.5;//2.0是圆角的弧度，根据需求自己更改
            [btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
        [btn setTitleColor:APP_NAVI_COLOR forState:UIControlStateSelected];
            btn.backgroundColor=[UIColor whiteColor];
             
            btn.layer.borderWidth=0.5*KScaleW;
            btn.layer.borderColor=[UIColor colorWithHexString:@"#e5e5e5"].CGColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            butX = CGRectGetMaxX(btn.frame)+15;
            [self.view addSubview:btn];
        if (i==self.exhibitionList.count-1) {
            self.lastBtn=btn;
        }
        }
    UILabel  *   descripeLabel=[[UILabel alloc]initWithFrame:CGRectMake(15.5*KScaleW, self.lastBtn.bottom+14.5*KScaleH, SCREEN_WIDTH-15*KScaleW, 15.5*KScaleH)];
    descripeLabel.textAlignment=NSTextAlignmentLeft;
    descripeLabel.font=APP_BOLD_FONT(16.0);
    descripeLabel.textColor=COLOR_333;
    descripeLabel.text=@"公司介绍";
    [self.view addSubview:descripeLabel];
    
    self.textView = [[VideoLiveTextView alloc]initWithFrame:CGRectMake(15,descripeLabel.bottom+15*KScaleH, SCREEN_WIDTH-30*KScaleW, 121.5)];
          // 设置颜色
          self.textView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
          // 设置提示文字
          self.textView.placehoder = @"可简单的介绍公司~";
          // 设置提示文字颜色
          self.textView.placehoderColor = [UIColor colorWithHexString:@"#666666"];
          // 设置textView的字体
          self.textView.font = APP_NORMAL_FONT(16.0);
          // 设置内容是否有弹簧效果
          self.textView.alwaysBounceVertical = YES;
          // 设置textView的高度根据文字自动适应变宽
          self.textView.isAutoHeight = YES;
          // 添加到视图上
          [self.view addSubview:self.textView];
    
    
    
}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
//    UIImage *rightImage = [UIImage imageWithData:imgData];
//    [bgImage setImage:rightImage];
//    
//    
//}
//
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

-(void)upload{
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.allowsEditing = YES;
//    [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
//        if (index==0) {
//            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:imagePickerController animated:YES completion:nil];
//        }else{
//            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            [self presentViewController:imagePickerController animated:YES completion:nil];
//        }
//    } canceled:^{
//
//    }];
    
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
     [bgImage setImage:editedImage];
   

}

-(void)selecType:(UIButton *)sender{
    sender.selected=!sender.selected;
    MainPageListModel   *    model=self.exhibitionList[sender.tag];
    NSLog(@"modelID=%@",model.cate_id);
    if (sender.selected==YES) {
        [self.dataList addObject:model.cate_id];
     
    }else{
        [self.dataList removeObject:model.cate_id];
    }
}
-(NSMutableArray *)exhibitionList{
    if (!_exhibitionList) {
        _exhibitionList=[NSMutableArray array];
    }
    return _exhibitionList;
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
@end
