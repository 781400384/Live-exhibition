//
//  MineBaseViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MineBaseViewController.h"
#import "LiveAlertView.h"
#import "AuthenticationViewController.h"
#import "CompanyInfoViewController.h"
#import "AvatarSetViewController.h"
#import "MyVideoOrLikeViewController.h"
#import "OrderLiveViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "MineHandle.h"
#import "PersonInfoViewController.h"
#import "LiveCompanyInfoViewController.h"
#import "NewLiveViewController.h"
#import "LiveNoteViewController.h"
#import <UGCKit/UGCKit.h>
#import "SeeLiveViewController.h"
#import <PLShortVideoKit/PLShortVideoKit.h>
#import "PublishVideoViewController.h"

#pragma mark - 视频录制

@interface MineBaseViewController ()<UITableViewDelegate,UITableViewDataSource,PLShortVideoUploaderDelegate>{
    UIImageView   *  avatarImg;
    UILabel  *  nickName;
    UIImageView  *  btn;
    UILabel  *  titleLabel;
    UILabel  *  idLabel;
     MBProgressHUD *  hud;
    
}
@property (nonatomic, strong) NSArray         *    companyTitleList;
@property (nonatomic, strong) NSArray         *    personTitleList;
@property (nonatomic, strong) NSArray         *    companyImgList;
@property (nonatomic, strong) NSArray         *    personImgList;
@property (nonatomic, strong) UITableView     *    tableView;
@end

@implementation MineBaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    if ([UserInfoDefaults isLogin]) {
        [self.tableView reloadData];
        [self reloadHeadInfo];
    }else{
        [self goLogin];
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:LoginSuccessNotification object:nil];
}
-(void)reload:(NSNotification *)wxLogin{
    [self.tableView reloadData];
     [self reloadHeadInfo];
    
    NSLog(@"111");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.companyTitleList=@[@"开播/直播",@"企业墙",@"企业视频",@"直播记录",@"我的喜欢",@"预约展览"];
    self.personTitleList=@[@"个人资料",@"我的喜欢",@"预约展览"];
    self.companyImgList=@[@"mine_live",@"mine_company",@"mine_video",@"mine_liveNote",@"mine_like",@"mine_order"];
    self.personImgList=@[@"mine_personInfo",@"mine_like",@"mine_order"];
   
   
}

-(UIView *)setHeaderView{
    UIImageView   *  headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 253.5*KScaleH)];
    headerView.image=[UIImage imageNamed:@"personal_bg"];
    headerView.userInteractionEnabled=YES;
    headerView.clipsToBounds=YES;
    headerView.contentMode=UIViewContentModeScaleAspectFill;
    avatarImg=[[UIImageView alloc]init];
    [avatarImg sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path] placeholderImage:[UIImage imageNamed:@"mine_avatar_default"]];
    avatarImg.frame=CGRectMake(13.5*KScaleW, 92.5*KScaleH, 64*KScaleW, 64*KScaleW);
    avatarImg.clipsToBounds=YES;
    [avatarImg setRadius:32*KScaleW];
    avatarImg.userInteractionEnabled=YES;
    UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        AvatarSetViewController   *  vc=[[AvatarSetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        vc.url=[UserInfoDefaults userInfo].head_path;
     
    }];
    [avatarImg addGestureRecognizer:tap];
    [headerView addSubview:avatarImg];
    
    nickName=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+8.5*KScaleW, avatarImg.top+13*KScaleH, 176.5*KScaleW, 19.5*KScaleH)];
    nickName.textColor=[UIColor whiteColor];
    nickName.font=APP_BOLD_FONT(20.0);
    nickName.textAlignment=NSTextAlignmentLeft;
    nickName.text=[UserInfoDefaults userInfo].nickname;
    [headerView addSubview:nickName];
    
    idLabel=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+8.5*KScaleW, nickName.bottom+10*KScaleH, 176.5*KScaleW, 11.5*KScaleH)];
    idLabel.textAlignment=NSTextAlignmentLeft;
    idLabel.font=APP_NORMAL_FONT(15.0);
    idLabel.text=[UserInfoDefaults userInfo].uid;
    idLabel.textColor=[UIColor whiteColor];
    [headerView addSubview:idLabel];
    
    UIButton   *   setting=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-36.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 22*KScaleW, 22*KScaleW)];
    [setting setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [setting addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:setting];
    
    btn=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-112.5*KScaleW, setting.bottom+51*KScaleH, 112.5*KScaleW, 40*KScaleH)];
    btn.image=[UIImage imageNamed:@"mine_company_radius"];
    btn.clipsToBounds=YES;
    btn.userInteractionEnabled=YES;
    btn.contentMode=UIViewContentModeScaleToFill;
    UITapGestureRecognizer   *  tapCompany=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
           LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
           vc.imageUrl=[UserInfoDefaults userInfo].head_path;
           vc.uid=[UserInfoDefaults userInfo].uid;
           vc.showType=@"0";
           [self.navigationController pushViewController:vc animated:NO];
       }];
       [btn addGestureRecognizer:tapCompany];
    [headerView addSubview:btn];
    if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
        btn.hidden=YES;
    }else{
        btn.hidden=NO;
    }
//    for ( int i=0; i<4; i++) {
//        UILabel  *   label=[[UILabel alloc]initWithFrame:CGRectMake(15*KScaleW+(SCREEN_WIDTH-15*KScaleW)/4*i, avatarImg.bottom+43.5*KScaleH, (SCREEN_WIDTH-15*KScaleW)/5, 15.5*KScaleH)];
//        label.textColor=[UIColor whiteColor];
//        label.font=APP_BOLD_FONT(16.0);
//        label.textAlignment=NSTextAlignmentLeft;
//        if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
//            label.text=@[@"1000沟通",@"1000关注",@"1000粉丝",@""][i];
//        }else{
//             label.text=@[@"1000获赞",@"1000沟通",@"1000关注",@"1000粉丝"][i];
//        }
//        titleLabel=label;
//        [headerView addSubview:label];
//    }
    return headerView;
}
#pragma mark - 设置点击事件
-(void)setting{
    SettingViewController   *  vc=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)reloadHeadInfo{
    UserInfoModel  *  model=[UserInfoDefaults userInfo];
     [avatarImg sd_setImageWithURL:[NSURL URLWithString:model.head_path] placeholderImage:[UIImage imageNamed:@"mine_avatar_default"]];
     nickName.text=model.nickname;
    idLabel.text=[NSString stringWithFormat:@"ID:%@",model.uid];
    if ([model.user_type isEqualToString:@"0"]) {
        btn.hidden=YES;
    }else{
        btn.hidden=NO;
    }
//    for ( int i=0; i<4; i++) {
//
//        if ([model.user_type isEqualToString:@"0"]) {
//            titleLabel.text=@[@"1000沟通",@"1000关注",@"1000粉丝",@""][i];
//        }else{
//             titleLabel.text=@[@"1000获赞",@"1000沟通",@"1000关注",@"1000粉丝"][i];
//        }
//    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell11"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
        cell.imageView.image=[UIImage imageNamed:self.personImgList[indexPath.row]];
        cell.textLabel.text=self.personTitleList[indexPath.row];
    }else{
     cell.imageView.image=[UIImage imageNamed:self.companyImgList[indexPath.row]];
        cell.textLabel.text=self.companyTitleList[indexPath.row];
        
    }
     cell.textLabel.font=APP_NORMAL_FONT(16.0);
     cell.textLabel.textColor=COLOR_333;
     cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_next"]];
  
    if (indexPath.row==1||indexPath.row==4) {
      UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(15*KScaleW, cell.height-0.5*KScaleH, SCREEN_WIDTH-30*KScaleW, 0.5*KScaleH)];
                lineView.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
              [cell addSubview:lineView];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    switch (indexPath.row) {
        case 0:{
            
            
            if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
                PersonInfoViewController * vc=[[PersonInfoViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
            }else{
                [MineHandle verfiLiveWithSucc:^(id  _Nonnull obj) {
                    NSDictionary * dic=(NSDictionary *)obj;
                    if ([dic[@"code"] intValue]==200) {
                        LiveAlertView  *  alert=[[LiveAlertView alloc]init];
                                              [alert showView];
                        [alert.startLive addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
#pragma mark - 开始直播
//                            SeeLiveViewController  *  vc=[[SeeLiveViewController alloc]init];
                            NewLiveViewController   *  vc=[[ NewLiveViewController alloc]init];
                            [self.navigationController pushViewController:vc animated:NO];
                              [alert dismissAlertView];
                        }];
                        [alert.startVideo addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                             UGCKitRecordViewController *recordViewController = [[UGCKitRecordViewController alloc] initWithConfig:nil theme:nil];
                            [self.navigationController pushViewController:recordViewController animated:NO];
                            [alert dismissAlertView];
                            
                            recordViewController.completion = ^(UGCKitResult *result) {
                                if (result.cancelled) {
                                     [self.navigationController popViewControllerAnimated:YES];
                                }else{
                                    [self processRecordedVideo:result.media];
                                    
                                }
                            };
                        }];
                    }else{
                        [self.view toast:dic[@"msg"]];
                    }
                    
                } failed:^(id  _Nonnull obj) {
                    
                }];
                       
            }
        }
             break;
        case 1:{
            if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
                MyVideoOrLikeViewController  *  lvc=[[MyVideoOrLikeViewController alloc]init];
                [self.navigationController pushViewController:lvc animated:NO];
                lvc.type=@"0";
                lvc.naviView.naviTitleLabel.text=@"我的喜欢";
                lvc.uid=[UserInfoDefaults userInfo].uid;
            }else{
            CompanyInfoViewController  *  vc=[[CompanyInfoViewController alloc]init];
                 vc.uid=[UserInfoDefaults userInfo].uid;
            [self.navigationController pushViewController:vc animated:NO];
                
            }
        }
             break;
        case 2:{
            if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
                OrderLiveViewController  *  vc=[[OrderLiveViewController alloc]init];
                [self.navigationController pushViewController:vc animated:NO];
                      }else{
            MyVideoOrLikeViewController  *  mvc=[[MyVideoOrLikeViewController alloc]init];
                          mvc.type=@"1";
            [self.navigationController pushViewController:mvc animated:NO];
                           mvc.uid=[UserInfoDefaults userInfo].uid;
                          mvc.naviView.naviTitleLabel.text=@"企业视频";
                          
                      }
            }
             break;
        case 3:{
            LiveNoteViewController  *  vc=[[LiveNoteViewController alloc]init];
            vc.uid=[UserInfoDefaults userInfo].uid;
            vc.naviView.naviTitleLabel.text=@"直播记录";
              [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 4:{
            MyVideoOrLikeViewController  *  lvc=[[MyVideoOrLikeViewController alloc]init];
            [self.navigationController pushViewController:lvc animated:NO];
             lvc.type=@"0";
             lvc.uid=[UserInfoDefaults userInfo].uid;
            lvc.naviView.naviTitleLabel.text=@"我的喜欢";
            }
        break;
        case 5:{
            OrderLiveViewController  *  vc=[[OrderLiveViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[UserInfoDefaults userInfo].user_type isEqualToString:@"0"]) {
        return self.personTitleList.count;
    }else{
    
        return self.companyTitleList.count;
        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50.0f;
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        tableView.tableHeaderView=[self setHeaderView];
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
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
       __weak __typeof(self)weakSelf = self;
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [weakSelf.tableView reloadData];
            [self reloadHeadInfo];
           

        });
    };
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 编辑

- (void)processRecordedVideo:(UGCKitMedia *)media {
// 实例化编辑控制器
    UGCKitEditViewController   *   ediit=[[UGCKitEditViewController alloc]initWithMedia:media config:nil theme:nil];
    [self.navigationController pushViewController:ediit animated:YES];
    ediit.onTapNextButton = ^(void (^finish)(BOOL shouldGenerate)) {
        finish(YES);
        ediit.completion = ^(UGCKitResult *result) {
            NSLog(@"视频信息%@",result.media);
            if (result.cancelled) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                //视频路径
                NSLog(@"1111");
              
                
                
                [MineHandle getQiNiuTokenWithSuccess:^(id  _Nonnull obj) {
                    NSDictionary * dic=(NSDictionary *)obj;
                    
                    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
                        builder.useHttps = YES;
                    }];
                    
                    NSString * token = dic[@"data"][@"token"];
                    NSString * key = [self serial];
                    NSString * filePath = result.media.videoPath;
                    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                      hud.label.text=@"视频生成中，请稍后";
                    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
                    [upManager putFile:filePath key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        if(info.ok)
                        {
                              TXVodPlayer  *  player=[[TXVodPlayer alloc]init];
                            [player stopPlay];
                            [player removeVideoWidget];
                            NSLog(@"请求成功");
                              [hud hideAnimated:YES];
                            PublishVideoViewController *  vc=[[PublishVideoViewController alloc]init];
                                [self.navigationController pushViewController:vc animated:NO];
                            vc.videoUrl=[NSString stringWithFormat:@"https://qiniu.bjzhanbotest.com/%@",resp[@"key"]];
                             vc.defaultImage=[self getVideoPreViewImage:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,resp[@"key"]]]];
//                            UIImage  *  url=[self getVideoPreViewImage:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp4",BaseURL,resp[@"15827206531630514478"]]]];
//                            NSLog(@"请求成功 %@",url);
                        }
                        else{
                            NSLog(@"失败");
                              [hud hideAnimated:YES];
                             [self.view toast:@"生成失败"];
                            //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                        }
                        NSLog(@"info ===== %@", info);
                        NSLog(@"resp ===== %@", resp);
                    }
                    option:nil];
                    
//                    QNUploadOption  *  uploadOption=[[QNUploadOption alloc]initWithProgressHandler:^(NSString *key, float percent) {
//                            NSLog(@"上传进度 %.2f  %@", percent,key);
//                    }];
                } failed:^(id  _Nonnull obj) {
                     [hud hideAnimated:YES];
                     [self.view toast:@"请求超时，请重试"];
                }];
                
                
            }
        };
    };
    
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
