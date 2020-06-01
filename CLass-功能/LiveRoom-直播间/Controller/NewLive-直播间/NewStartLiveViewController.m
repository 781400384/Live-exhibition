//
//  NewStartLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "NewStartLiveViewController.h"
#import "SRWebSocket.h"
#import "LiveHandle.h"
#import "bottomAlertView.h"
#import "UIView+CLSetRect.h"
#import "CLInputToolbar.h"
@interface NewStartLiveViewController ()<AlivcLivePusherInfoDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherNetworkDelegate,AlivcLivePusherBGMDelegate,AlivcLivePusherSnapshotDelegate,AlivcLivePusherCustomFilterDelegate,AlivcLivePusherCustomDetectorDelegate,SRWebSocketDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AlivcLivePusher       *   livePusher;
@property (nonatomic, strong) SRWebSocket           *   webSocket;
@property (nonatomic, strong) UIView                *   playView;
@property (nonatomic, strong) UITableView           *   tableView;
@property (nonatomic, strong) NSMutableArray        *   dataList;
@property (nonatomic, strong) NSMutableArray        *   userList;
@property (nonatomic, strong) NSDictionary          *   dictionary;
@property (nonatomic, strong) CLInputToolbar *inputToolbar;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation NewStartLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webSocket.delegate=nil;
       [self.webSocket close];
   
        [self configUIPortait];
   
}

//竖屏直播
-(void)configUIPortait{
    UIView  *  screView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    screView.userInteractionEnabled=YES;
      screView.clipsToBounds=YES;
      [self.view addSubview:screView];
           self.liveConfig = [[AlivcLivePushConfig alloc]init];
           self.liveConfig.resolution = AlivcLivePushResolution540P;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString  *  carema=[userDefaults objectForKey:@"caremaType"];
    if ([carema intValue]==0) {
        self.liveConfig.cameraType=AlivcLivePushCameraTypeFront;
    }else{
          self.liveConfig.cameraType=AlivcLivePushCameraTypeBack;
    }
           self.livePusher = [[AlivcLivePusher alloc] initWithConfig:self.liveConfig];
           self.liveConfig.previewDisplayMode=ALIVC_LIVE_PUSHER_PREVIEW_ASPECT_FILL;
           [self.livePusher setInfoDelegate:self];
           [self.livePusher setErrorDelegate:self];
           [self.livePusher setNetworkDelegate:self];
           [self.livePusher setBGMDelegate:self];
           [self.livePusher setSnapshotDelegate:self];
           [self.livePusher setCustomFilterDelegate:self];
           [self.livePusher setCustomDetectorDelegate:self];
           [self.livePusher startPreview:screView];
            NSString   *   str=self.dic[@"data"][@"push_url"];
            [self.livePusher startPushWithURL:str];
            self.webSocket=[[SRWebSocket alloc]initWithURL:[NSURL URLWithString:self.dic[@"data"][@"chartServer"]]];
            self.webSocket.delegate=self;
            [self.webSocket open];
          
    UIView    *  avatarBgView=[[UIView alloc]initWithFrame:CGRectMake(10.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleH, 140*KScaleW, 34*KScaleH)];
    avatarBgView.backgroundColor=RGBA(0, 0, 0, 0.5);
    avatarBgView.userInteractionEnabled=YES;
    avatarBgView.clipsToBounds=YES;
    [avatarBgView setRadius:17*KScaleH];
    [self.view addSubview:avatarBgView];
    UIImageView   *  avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*KScaleW, 2*KScaleH, 30*KScaleW, 30*KScaleH)];
    [avatarImg sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path]];
    [avatarImg setRadius:15*KScaleW];
    avatarImg.clipsToBounds=YES;
    avatarImg.userInteractionEnabled=YES;
    [avatarBgView addSubview:avatarImg];
    
    UILabel   *  nickNamee=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+4.5*KScaleW, 4*KScaleH, 60*KScaleW, 13*KScaleH)];
    nickNamee.textAlignment=NSTextAlignmentLeft;
    nickNamee.font=APP_NORMAL_FONT(13.0);
    nickNamee.textColor=[UIColor whiteColor];
    nickNamee.text=[UserInfoDefaults userInfo].nickname;
    [avatarBgView addSubview:nickNamee];
    
    UILabel   *  IDLabel=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+4.5*KScaleW, nickNamee.bottom+5*KScaleH, 58*KScaleW, 7*KScaleH)];
    IDLabel.textAlignment=NSTextAlignmentLeft;
    IDLabel.text=[NSString stringWithFormat:@"ID:%@",[UserInfoDefaults userInfo].uid];
    IDLabel.textColor=[UIColor colorWithHexString:@"#F0F0F0"];
    IDLabel.font=APP_NORMAL_FONT(10.0);
    [avatarBgView addSubview:IDLabel];
    UIView   *    seeLiveView=[[UIView alloc]initWithFrame:CGRectMake(avatarBgView.right+10*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleH, 40*KScaleW, 34*KScaleH)];
       
       seeLiveView.backgroundColor=RGBA(0, 0, 0, 0.5);
       seeLiveView.userInteractionEnabled=YES;
       seeLiveView.clipsToBounds=YES;
       [seeLiveView setRadius:17.75*KScaleH];
       [self.view addSubview:seeLiveView];
       
       UIImageView  *   eyeImg=[[UIImageView alloc]initWithFrame:CGRectMake((seeLiveView.width-14*KScaleW)/2, 4*KScaleH, 14*KScaleW, 14*KScaleW)];
       eyeImg.image=[UIImage imageNamed:@"liveing_num"];
       [seeLiveView addSubview:eyeImg];
       eyeImg.contentMode=UIViewContentModeScaleAspectFit;
       
       
       UILabel  *   numLabel=[[UILabel  alloc]initWithFrame:CGRectMake(0, eyeImg.bottom+0.5*KScaleH, seeLiveView.width, 9*KScaleH)];
       numLabel.textAlignment=NSTextAlignmentCenter;
       numLabel.font=APP_NORMAL_FONT(10.0);
       numLabel.textColor=[UIColor whiteColor];
       [seeLiveView addSubview:numLabel];
       numLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.dataList.count];
       

    
    UIButton  *  closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44*KScaleW, SCREEN_HEIGHT-44*KScaleH, 34*KScaleW, 34*KScaleH)];
    [closeBtn setImage:[UIImage imageNamed:@"liveing_close"] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton  *   shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-88*KScaleW, SCREEN_HEIGHT-44*KScaleH,  34*KScaleW, 34*KScaleH)];
    [shareBtn setImage:[UIImage imageNamed:@"liveing_share"] forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton  *  textBtn=[[UIButton alloc]initWithFrame:CGRectMake(10*KScaleW, SCREEN_HEIGHT-44*KScaleH, 124*KScaleW, 34*KScaleH)];
    [textBtn setImage:[UIImage imageNamed:@"liveing_text"] forState:UIControlStateNormal];
    [textBtn addTarget:self action:@selector(textClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:textBtn];
    [self setTextViewToolbar];
    [self.tableView reloadData];
    
      [self scrollToBottom];
    
}
-(void)setTextViewToolbar {
    
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActions:)];
    [self.maskView addGestureRecognizer:tap];
    [self.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    self.inputToolbar = [[CLInputToolbar alloc] init];
    self.inputToolbar.textViewMaxLine = 3;
    self.inputToolbar.fontSize = 18;
    self.inputToolbar.placeholder = @"请输入...";
    __weak __typeof(self) weakSelf = self;
    [self.inputToolbar inputToolbarSendText:^(NSString *text) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
//        [strongSelf.btn setTitle:text forState:UIControlStateNormal];
        // 清空输入框文字
        NSDictionary  *  user=@{@"uid":[UserInfoDefaults userInfo].uid,
                                       @"nickname":[UserInfoDefaults userInfo].nickname,
                                       @"user_login":[UserInfoDefaults userInfo].user_login,
                                       @"sex":[UserInfoDefaults userInfo].sex,
                                       @"head_path":[UserInfoDefaults userInfo].head_path,
                                       @"user_sign":[UserInfoDefaults userInfo].user_sign,
                                       @"mobile":[UserInfoDefaults userInfo].mobile,
                                       @"token":[UserInfoDefaults userInfo].token,
                                       @"user_type":[UserInfoDefaults userInfo].user_type,
                                       @"level":[UserInfoDefaults userInfo].level,
                                       @"level_path":[UserInfoDefaults userInfo].level_path,
                                       @"is_corpse":@"1"
               };
                NSString * json=[NSString stringWithFormat:@"%@:%@",[UserInfoDefaults userInfo].nickname,text];
               NSDictionary  *  dic=@{@"msgType":@"CHATROOM",@"roomID":self.dic[@"data"][@"room_id"],@"targetId":self.dic[@"data"][@"room_id"],
                                      @"content":json,@"extra":user,@"sendTime":[self getNowTime]
               };
         NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
               [self.webSocket send:data];
        [strongSelf.inputToolbar bounceToolbar];
        strongSelf.maskView.hidden = YES;
    }];
    [self.maskView addSubview:self.inputToolbar];
   
}
-(void)closeBtn{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.livePusher stopPush];
//    [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
//        NSLog(@"关闭直播间%@",obj);
//        } failed:^(id  _Nonnull obj) {
//
//    }];
//     [self.livePusher stopPreview];
//    [self.webSocket close];
    NSUserDefaults * defaultes=[NSUserDefaults standardUserDefaults];
    [defaultes removeObjectForKey:@"caremaType"];
    [self addCloseView];
}
-(void)shareClick{
    [LiveHandle getLiveShareWithUid:[[UserInfoDefaults userInfo].uid intValue]  token:[UserInfoDefaults userInfo].token liveUid:[[UserInfoDefaults userInfo].uid intValue]  stream:self.dic[@"data"][@"stream"] success:^(id  _Nonnull obj) {
         NSDictionary  *  dic=(NSDictionary *)obj;
                if ([dic[@"code"] intValue]==200) {
                    bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                    alertV.shareTitle=dic[@"data"][@"title"];
                    alertV.shareDesc=dic[@"data"][@"desc"];
                    alertV.imageUrl=dic[@"data"][@"thumb"];
                    alertV.url=dic[@"data"][@"url"];
                }else{
//                    [self.view toast:dic[@"msg"]];
                }
    } failed:^(id  _Nonnull obj) {
        
    }];

}
#pragma mark - 输入聊天
-(void)textClick{
    self.maskView.hidden = NO;
       [self.inputToolbar popToolbar];
}
-(void)tapActions:(UITapGestureRecognizer *)tap {
    [self.inputToolbar bounceToolbar];
    self.maskView.hidden = YES;
}
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSData  *  data=[message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([dic[@"content"] isEmpty]) {
        
    }else{
    [self.dataList addObject:dic];
    [self.tableView reloadData];
        [self scrollToBottom];}
    NSLog(@"聊天s室罅隙%@",dic);
}
- (void)onSystemError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
    NSLog(@"推流error==%@",error);
}
- (void)onSDKError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
      NSLog(@"SDKerror==%@",error);
}
- (void)onConnectFail:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
       NSLog(@"链接error==%@",error);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell11"];
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.textLabel.backgroundColor=RGBA(0, 0, 0, 0.5);
        CGFloat watchSize=[self getWidthWithTitle:[self.dataList[indexPath.row] valueForKey:@"content"] font:APP_NORMAL_FONT(13.0)];
       cell.textLabel.numberOfLines=0;
      cell.textLabel.width=watchSize;
     cell.backgroundColor=[UIColor clearColor];
     cell.textLabel.text=[self.dataList[indexPath.row] valueForKey:@"content"];
     [cell.textLabel setRadius:5.0];
     cell.textLabel.textColor=[UIColor randomColor];
     cell.textLabel.font=APP_NORMAL_FONT(13.0);
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
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
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(10*KScaleW,382*KScaleH, 255*KScaleW, 235*KScaleH) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 15.0f;
        tableView.backgroundColor=[UIColor clearColor];
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor=[UIColor clearColor];
        tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView = tableView;
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(void)scrollToBottom {
    if (self.dataList.count > 0) {
        if ([self.tableView numberOfRowsInSection:0] > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.tableView numberOfRowsInSection:0]-1) inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
}
- (void)applicationWillResignActive:(NSNotification *)notification {
    // 如果退后台不需要继续推流，则停止推流
    if ([self.livePusher isPushing]) {
        [self.livePusher stopPush];
    }
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {

    [self.livePusher startPushWithURLAsync:self.dic[@"data"][@"push_url"]];
}
-(NSMutableArray *)userList{
    
    if (!_userList) {
        _userList=[NSMutableArray array];
    }
    return _userList;
}
- (NSString *)getNowTime{

    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", time];
    return timeSp;
}
-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

-(void)addCloseView{
    
    [self.livePusher stopPush];
        [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
            NSLog(@"关闭直播间%@",obj);
            NSDictionary * dic=(NSDictionary *)obj;
            if ([dic[@"code"] intValue]==200) {
                UIImageView  *  bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [bgImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path]];
                bgImage.userInteractionEnabled=YES;
                bgImage.contentMode=UIViewContentModeScaleAspectFill;
                [self.view addSubview:bgImage];
                
                UILabel  *  noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 170*KScaleH, SCREEN_WIDTH, 45*KScaleH)];
                noticeLabel.textColor=[UIColor whiteColor];
                noticeLabel.textAlignment=NSTextAlignmentCenter;
                noticeLabel.font=APP_BOLD_FONT(24.0);
                noticeLabel.text=@"直播已结束";
                [bgImage addSubview:noticeLabel];
                
                UIImageView  *  avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-105*KScaleW)/2, noticeLabel.bottom+ 50*KScaleH, 105*KScaleW, 105*KScaleW)];
                [avatarImg setRadius:52.5*KScaleW];
                avatarImg.contentMode=UIViewContentModeScaleAspectFill;
                [avatarImg sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path]];
                [bgImage addSubview:avatarImg];
                avatarImg.clipsToBounds=YES;
                
                UIView  *  bgView=[[UIView alloc]initWithFrame:CGRectMake(40*KScaleW, avatarImg.centerY, SCREEN_WIDTH-80*KScaleW, 189*KScaleH)];
                bgView.backgroundColor=RGBA(0, 0, 0, 0.4);
                [bgView setRadius:10*KScaleH];
                [bgImage addSubview:bgView];
                
                UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(0,( bgView.height-1*KScaleH)/2, bgView.width, 1*KScaleH)];
                lineView.backgroundColor=[UIColor colorWithHexString:@"#666666"];
                [bgView addSubview:lineView];
                
                UILabel  *  timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+26*KScaleH, bgView.width/2, 14*KScaleH)];
                timeLabel.textAlignment=NSTextAlignmentCenter;
                timeLabel.textColor=[UIColor whiteColor];
                timeLabel.font=APP_NORMAL_FONT(18.0);
                [bgView addSubview:timeLabel];
                
                UILabel  *  numLabel=[[UILabel alloc]initWithFrame:CGRectMake(bgView.width/2, lineView.bottom+26*KScaleH, bgView.width/2, 14*KScaleH)];
                   numLabel.textAlignment=NSTextAlignmentCenter;
                   numLabel.textColor=[UIColor whiteColor];
                   numLabel.font=APP_NORMAL_FONT(18.0);
                   [bgView addSubview:numLabel];
                
                UILabel * timeTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, timeLabel.bottom+10*KScaleH, bgView.width/2, 14*KScaleH)];
                
                timeTitle.textAlignment=NSTextAlignmentCenter;
                timeTitle.textColor=[UIColor whiteColor];
                timeTitle.font=APP_NORMAL_FONT(18.0);
                timeTitle.text=@"直播时长";
                [bgView addSubview:timeTitle];
                
                UILabel * numTitle=[[UILabel alloc]initWithFrame:CGRectMake(bgView.width/2, timeLabel.bottom+10*KScaleH, bgView.width/2, 14*KScaleH)];
                   
                   numTitle.textAlignment=NSTextAlignmentCenter;
                   numTitle.textColor=[UIColor whiteColor];
                   numTitle.font=APP_NORMAL_FONT(18.0);
                   numTitle.text=@"观看人数";
                   [bgView addSubview:numTitle];
                
                UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(40*KScaleW, bgView.bottom+120.5*KScaleH, SCREEN_WIDTH-80*KScaleW, 40*KScaleH)];
                    btn.backgroundColor=APP_NAVI_COLOR;
                      [btn setRadius:20.0];
                      [btn setTitle:@"返回首页" forState:UIControlStateNormal];
                      [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                  //    [btn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
                      btn.titleLabel.font=APP_NORMAL_FONT(18.0);
                      [bgImage addSubview:btn];
                      [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
                timeLabel.text=[NSString stringWithFormat:@"%@" ,dic[@"data"][@"duration"]];
                numLabel.text=[NSString stringWithFormat:@"%@" ,dic[@"data"][@"play_num"]];
            }
            } failed:^(id  _Nonnull obj) {
        
        }];
         [self.livePusher stopPreview];
        [self.webSocket close];
    
}
-(void)closeClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
