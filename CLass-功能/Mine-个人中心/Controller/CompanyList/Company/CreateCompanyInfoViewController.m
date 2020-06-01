//
//  CreateCompanyInfoViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CreateCompanyInfoViewController.h"
#import "CreateCompanyInfoTableViewCell.h"
#import "VideoLiveTextView.h"
#import "MineHandle.h"
#import "LCActionAlertView.h"
@interface CreateCompanyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,LDImagePickerDelegate>{
     MBProgressHUD *  hud;
}

@property (nonatomic, strong) UITableView    *    tableView;
@property (nonatomic, strong) NSMutableArray *    dataList;
@property (nonatomic, strong) NSMutableArray *    urlList;
@property (nonatomic, strong) VideoLiveTextView   *   textView;
@property (nonatomic, strong) UITextField    *    titleTF;
@end

@implementation CreateCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.naviTitleLabel.text=@"新建图文";
    self.naviView.rightTitleLabel.text=@"发表";
    [self configUI];
}
-(void)rightTitleLabelTap{
    if (self.urlList.count==0) {
        [self.view toast:@"请至少创传一张图片"];
        return;
    }
    if ([self.titleTF.text isEmpty]) {
         [self.view toast:@"请输入标题"];
        return;
    }
     NSString *str = [self.urlList componentsJoinedByString:@","];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text=@"上传中";
    [MineHandle addCompanyImgWithUid:[[UserInfoDefaults userInfo].uid intValue] tokenL:[UserInfoDefaults userInfo].token pictureImg:str title:self.titleTF.text desc:self.textView.text==nil?@"":self.textView.text success:^(id  _Nonnull obj) {
         NSDictionary * dic=(NSDictionary *)obj;
                if ([dic[@"code"] intValue]==200) {
                    [self.view toast:@"添加成功"];
                     [hud hideAnimated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
//                    [self.view toast:dic[@"msg"]];
                     [hud hideAnimated:YES];
                }
    } failed:^(id  _Nonnull obj) {
        [self.view toast:@"请求超时，请重新编辑"];
        [hud hideAnimated:YES];
    }];
}
-(void)configUI{
   self.textView = [[VideoLiveTextView alloc]initWithFrame:CGRectMake(230*KScaleW,self.naviView.bottom+59.5*KScaleH, SCREEN_WIDTH-240*KScaleW, SCREEN_HEIGHT-self.naviView.bottom-59.5*KScaleH)];
       // 设置颜色
       self.textView.backgroundColor = [UIColor whiteColor];
       // 设置提示文字
       self.textView.placehoder = @"可以进行介绍...";
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
    UIImage *   addImage=[UIImage imageNamed:@"companyInfo_add"];
       self.dataList=[NSMutableArray arrayWithObject:addImage];
       [self.tableView reloadData];
    
    
    self.titleTF=[[UITextField alloc]initWithFrame:CGRectMake(15*KScaleW, self.naviView.bottom+10*KScaleH, SCREEN_WIDTH-30*KScaleW, 30*KScaleH)];
               self.titleTF.backgroundColor=[UIColor whiteColor];
               self.titleTF.delegate=self;
               self.titleTF.tintColor=APP_NAVI_COLOR;
               [self.view addSubview:self.titleTF];
               NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"给图文写个标题吧...(不超过15字)"];
               [placeholder addAttribute:NSFontAttributeName
                                       value:[UIFont boldSystemFontOfSize:18.0]
                                       range:NSMakeRange(0, 15)];
               self.titleTF.attributedPlaceholder = placeholder;
               self.titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
               [self.titleTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       
}
-(void)textFieldDidChange:(UITextField *)textField
{
    
    CGFloat maxLength = 15;
    
   
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange)
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreateCompanyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ CreateCompanyInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.addImage.image=self.dataList[indexPath.row];
    [cell.closeBtn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    cell.closeBtn.tag=indexPath.row;
    if (indexPath.row==0) {
        cell.closeBtn.hidden=YES;
        UITapGestureRecognizer    *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
                   imagePicker.delegate = self;
            if (self.dataList.count>9) {
                [self.view toast:@"最多可上传9张图片"];
            }else{
               [LCActionAlertView showActionViewNames:@[@"照相机",@"本地相册"] completed:^(NSInteger index,NSString * name) {
                                                 if (index==0) {
                                                      [imagePicker showImagePickerWithType:ImagePickerCamera InViewController:self Scale:(250*KScaleW-50)/SCREEN_WIDTH];
                                                 }else{
                                                      [imagePicker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:(250*KScaleW-50)/SCREEN_WIDTH];
                                                 }
                                             } canceled:^{
                
                                             }];
                
            }
        }];
        [cell.addImage addGestureRecognizer:tap];
    }else{
        cell.closeBtn.hidden=NO;
        
    }
    return cell;
}
-(void)remove:(UIButton *)sender{
    [self.dataList removeObjectAtIndex:sender.tag];
    [self.urlList removeObjectAtIndex:sender.tag];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataList.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.naviView.bottom+59.5*KScaleH, 230*KScaleH, SCREEN_HEIGHT-self.naviView.bottom-59.5*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 127.5f;
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        tableView.showsVerticalScrollIndicator =NO;
        [self.view addSubview:tableView];
        _tableView = tableView;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}
#pragma mark - 上传图片处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation([self fixOrientation:image], 0.5);
    UIImage *rightImage = [UIImage imageWithData:imgData];
      hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text=@"上传中";
    [MineHandle uploadCompanyImgWithImage:rightImage success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
                if ([dic[@"code"] intValue]==200) {
                    [self.dataList addObject:rightImage];
                    [self.tableView reloadData];
//                    [self.urlList addObject:[NSString stringWithFormat:@"%@",dic[@"data"][@"picture_id"]]];
                  [self.view toast:@"上传成功"];
                [hud hideAnimated:YES];
                }else{
                     [hud hideAnimated:YES];
                  [self.view toast:@"上传失败"];
                }
       
         [self.urlList addObject:[NSString stringWithFormat:@"%@",dic[@"data"][@"picture_id"]]];
        NSLog(@"图片信息==%@",dic);
    } failed:^(id  _Nonnull obj) {
        [hud hideAnimated:YES];
        [self.view toast:@"请求超时，请重新上传"];
    }];
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text=@"上传中";
        [MineHandle uploadCompanyImgWithImage:editedImage success:^(id  _Nonnull obj) {
            NSDictionary * dic=(NSDictionary *)obj;
                    if ([dic[@"code"] intValue]==200) {
                        [self.dataList addObject:editedImage];
                        [self.tableView reloadData];
    //                    [self.urlList addObject:[NSString stringWithFormat:@"%@",dic[@"data"][@"picture_id"]]];
                      [self.view toast:@"上传成功"];
                    [hud hideAnimated:YES];
                    }else{
                         [hud hideAnimated:YES];
                      [self.view toast:@"上传失败"];
                    }
           
             [self.urlList addObject:[NSString stringWithFormat:@"%@",dic[@"data"][@"picture_id"]]];
            NSLog(@"图片信息==%@",dic);
        } failed:^(id  _Nonnull obj) {
            [hud hideAnimated:YES];
            [self.view toast:@"请求超时，请重新上传"];
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
-(NSMutableArray *)urlList{
    if (!_urlList) {
        _urlList=[NSMutableArray array];
    }
    return _urlList;
}
@end
