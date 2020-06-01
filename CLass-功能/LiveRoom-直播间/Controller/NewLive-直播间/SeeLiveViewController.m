//
//  SeeLiveViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SeeLiveViewController.h"
#import <AliyunPlayerSDK/AliyunPlayerSDK.h>
#import "SRWebSocket.h"
#import "LiveHandle.h"
#import "bottomAlertView.h"
#import "UIView+CLSetRect.h"
#import "CLInputToolbar.h"
#import "LiveCompanyInfoViewController.h"
#import "MainHandle.h"
#import "VideoHandle.h"
#import "LiveUserModel.h"
@interface SeeLiveViewController ()<UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate>{
    
    AliVcMediaPlayer *  player;
    UIButton  *  attentionBtn;
}
@property (nonatomic, strong) UIView   *   playerView;
@property (nonatomic, strong) SRWebSocket           *   webSocket;
@property (nonatomic, strong) UIView                *   playView;
@property (nonatomic, strong) UITableView           *   tableView;
@property (nonatomic, strong) NSMutableArray        *   dataList;
@property (nonatomic, strong) NSMutableArray        *   userList;
@property (nonatomic, strong) NSDictionary          *   dictionary;
@property (nonatomic, strong) CLInputToolbar *inputToolbar;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation SeeLiveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [player reset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
-(void)loadData{
    [LiveHandle userGetInWithUid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token live_uid:[self.liveUid intValue] uccess:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            self.dictionary=dic;
            self.userList=[LiveUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"corpse_list"]];
            [self configLeftUI];
        }else
        {
            
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)configLeftUI{
 
             
    self.webSocket=[[SRWebSocket alloc]initWithURL:[NSURL URLWithString:self.dictionary[@"data"][@"chartServer"]]];
    self.webSocket.delegate=self;
    [self.webSocket open];
    self.playerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
     self.playerView.backgroundColor=[UIColor whiteColor];
     self.playerView.userInteractionEnabled=YES;
     self.playerView.clipsToBounds=YES;
     [self.view addSubview:self.playerView];
     player=[[AliVcMediaPlayer alloc]init];
     [player create:self.playerView];
    if ([self.liveType isEqualToString:@"0"]) {
          player.scalingMode=scalingModeAspectFitWithCropping;
    }else{
        player.scalingMode=scalingModeAspectFit;
        
    }
     [player prepareToPlay:[NSURL URLWithString:self.dictionary[@"data"][@"pull_url"]]];
     [player play];
    
    
    UIView    *  avatarBgView=[[UIView alloc]initWithFrame:CGRectMake(10.5*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal+10*KScaleH, 140*KScaleW, 34*KScaleH)];
       avatarBgView.backgroundColor=RGBA(0, 0, 0, 0.5);
       avatarBgView.userInteractionEnabled=YES;
       avatarBgView.clipsToBounds=YES;
       [avatarBgView setRadius:17*KScaleH];
       [self.view addSubview:avatarBgView];
    
    
    [VideoHandle getOtherUserInfoWithUid:[[UserInfoDefaults userInfo].uid intValue] visit_uid:[self.dictionary[@"data"][@"live_uid"] intValue] success:^(id  _Nonnull obj) {
           NSDictionary * dic=(NSDictionary *)obj;
           NSLog(@"返回的个人信息=%@",dic);
           if ([dic[@"code"] intValue]==200) {
               UIImageView   *  avatarImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*KScaleW, 2*KScaleH, 30*KScaleW, 30*KScaleH)];
                     [avatarImg sd_setImageWithURL:[NSURL URLWithString:dic[@"data"][@"head_path"]]];
                     [avatarImg setRadius:15*KScaleW];
                     avatarImg.clipsToBounds=YES;
                     avatarImg.userInteractionEnabled=YES;
                     [avatarBgView addSubview:avatarImg];
                     
                  UITapGestureRecognizer   *    tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                  LiveCompanyInfoViewController   *  vc=[[LiveCompanyInfoViewController alloc]init];
                  [self.navigationController pushViewController:vc animated:NO];
                  vc.showType=@"1";
                  vc.uid=self.dictionary[@"data"][@"live_uid"];
                      [player pause];
                  }];
                  [avatarImg addGestureRecognizer:tap];
                  
                  
                     UILabel   *  nickNamee=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+4.5*KScaleW, 4*KScaleH, 60*KScaleW, 13*KScaleH)];
                     nickNamee.textAlignment=NSTextAlignmentLeft;
                     nickNamee.font=APP_NORMAL_FONT(13.0);
                     nickNamee.textColor=[UIColor whiteColor];
                     nickNamee.text=dic[@"data"][@"nickname"];
                     [avatarBgView addSubview:nickNamee];
                     
                     UILabel   *  IDLabel=[[UILabel alloc]initWithFrame:CGRectMake(avatarImg.right+4.5*KScaleW, nickNamee.bottom+5*KScaleH, 58*KScaleW, 7*KScaleH)];
                     IDLabel.textAlignment=NSTextAlignmentLeft;
                     IDLabel.text=[NSString stringWithFormat:@"ID:%@",self.dictionary[@"data"][@"room_id"]];
                     IDLabel.textColor=[UIColor colorWithHexString:@"#F0F0F0"];
                     IDLabel.font=APP_NORMAL_FONT(10.0);
                     [avatarBgView addSubview:IDLabel];
           }
           
       } failed:^(id  _Nonnull obj) {
           
       }];
      
       
      attentionBtn=[[UIButton alloc]initWithFrame:CGRectMake(avatarBgView.width-38*KScaleW, 5*KScaleH, 33*KScaleW, 24*KScaleH)];
//       attentionBtn.backgroundColor=APP_NAVI_COLOR;
//       [attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     attentionBtn.layer.borderWidth=0.5*KScaleW;
    attentionBtn.layer.borderColor=APP_NAVI_COLOR.CGColor;
       attentionBtn.titleLabel.font=APP_NORMAL_FONT(10.0);
    if ([self.dictionary[@"data"][@"is_follow"] intValue]==0) {
          [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
          [attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
          attentionBtn.backgroundColor=APP_NAVI_COLOR;
         [attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [attentionBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateSelected];
    }else
    {
        [attentionBtn setTitle:@"关注" forState:UIControlStateSelected];
        [attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [attentionBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
        [attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
       
    }
    
    [attentionBtn addTarget:self action:@selector(attentionUseer:) forControlEvents:UIControlEventTouchUpInside];
       [attentionBtn setRadius:11.75*KScaleW];
       [avatarBgView addSubview:attentionBtn];
       
    
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
    numLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.userList.count];
    
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
    
//    NSDictionary  *  user=@{@"uid":[UserInfoDefaults userInfo].uid,
//                            @"nickname":[UserInfoDefaults userInfo].nickname,
//                            @"user_login":[UserInfoDefaults userInfo].user_login,
//                            @"sex":[UserInfoDefaults userInfo].sex,
//                            @"head_path":[UserInfoDefaults userInfo].head_path,
//                            @"user_sign":[UserInfoDefaults userInfo].user_sign,
//                            @"mobile":[UserInfoDefaults userInfo].mobile,
//                            @"token":[UserInfoDefaults userInfo].token,
//                            @"user_type":[UserInfoDefaults userInfo].user_type,
//                            @"level":[UserInfoDefaults userInfo].level,
//                            @"level_path":[UserInfoDefaults userInfo].level_path,
//                            @"is_corpse":@"1"
//    };
//    NSString * json=[NSString stringWithFormat:@"%@进入了直播间",[UserInfoDefaults userInfo].nickname];
//    NSDictionary  *  dic=@{@"msgType":@"CHATROOM",@"roomID":self.dictionary[@"data"][@"room_id"],@"targetId":self.dictionary[@"data"][@"room_id"],
//                           @"content":json,@"extra":user,@"sendTime":[self getNowTime]
//    };
//    NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    [self.webSocket send:data];
    
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
        NSDictionary  *  dic=@{@"msgType":@"CHATROOM",@"roomID":self.dictionary[@"data"][@"room_id"],@"targetId":self.dictionary[@"data"][@"room_id"],
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    [LiveHandle CloseLiveWithUID:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSLog(@"关闭直播间%@",obj);
        } failed:^(id  _Nonnull obj) {
    
    }];
    
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
                NSDictionary  *  dic=@{@"msgType":@"CLOSE",@"roomID":self.dictionary[@"data"][@"room_id"],@"targetId":self.dictionary[@"data"][@"room_id"],
                                       @"content":@"",@"extra":user,@"sendTime":[self getNowTime]
                };
          NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                [self.webSocket send:data];
    [self.webSocket close];
    [player destroy];
}
-(void)shareClick{
    [LiveHandle getLiveShareWithUid:[[UserInfoDefaults userInfo].uid intValue]  token:[UserInfoDefaults userInfo].token liveUid:[[UserInfoDefaults userInfo].uid intValue]  stream:self.dictionary[@"data"][@"pull_url"] success:^(id  _Nonnull obj) {
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
    if ([dic[@"msgType"] isEqualToString:@"CLOSE"]) {
        [self setCloseView];
    }
    [self.dataList addObject:dic];
    [self.tableView reloadData];
    [self scrollToBottom];
    NSLog(@"聊天s室罅隙%@",dic);
}
- (void)onSystemError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
    NSLog(@"推流error==%@ %ld",error.errorDescription,(long)error.errorCode);
}
- (void)onSDKError:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
    NSLog(@"SDKerror==%@ %ld",error.errorDescription,(long)error.errorCode);
}
- (void)onConnectFail:(AlivcLivePusher *)pusher error:(AlivcLivePushError *)error{
    NSLog(@"链接error==%@ %ld",error.errorDescription,(long)error.errorCode);
    [pusher restartPush];
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
     cell.textLabel.textColor=[UIColor whiteColor];
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
-(void)attentionUseer:(UIButton *)sender{
    sender.selected=!sender.selected;
    if ([self.dictionary[@"data"][@"is_follow"] intValue]==0) {
        if (sender.selected) {
           
            if ([self.dictionary[@"data"][@"live_uid"] intValue] ==[[UserInfoDefaults userInfo].uid intValue]) {
                [self.view toast:@"自己不能关注自己哦~"];
            }else{
                [self attentionWithUid:[self.dictionary[@"data"][@"live_uid"] intValue]];
                           attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
                          
            }
        }else{
            [self cancelAttentioinWithUid:[self.dictionary[@"data"][@"live_uid"] intValue]];
            attentionBtn.backgroundColor=APP_NAVI_COLOR;
        }
    }else
    {
       if (sender.selected) {
           [self cancelAttentioinWithUid:[self.dictionary[@"data"][@"live_uid"] intValue]];
           attentionBtn.backgroundColor=APP_NAVI_COLOR;

        }else{
            [self attentionWithUid:[self.dictionary[@"data"][@"live_uid"] intValue]];
            attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
           
        }
    }
}
-(void)attentionWithUid:(int)Uid{
    [MainHandle attentionUserWithUserId:Uid uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
          
        }
        NSLog(@"f点击关注返回的信息===%@",dic);
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)cancelAttentioinWithUid:(int)uid{
    [MainHandle cancelAttentionWithUserId:uid uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
               if ([dic[@"code"] intValue]==200) {
                  
               }
               NSLog(@"f点击关注返回的信息===%@",dic);
    } failed:^(id  _Nonnull obj) {
        
    }];
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
-(void)setCloseView{
    UIView * bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.userInteractionEnabled=YES;
    
    bgView.clipsToBounds=YES;
    bgView.backgroundColor=RGBA(0, 0, 0, 0.4);
    [self.view addSubview:bgView];
    
    UILabel  *   noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 200*KScaleH, SCREEN_WIDTH, 15*KScaleH)];
    noticeLabel.textColor=[UIColor whiteColor];
    [bgView addSubview:noticeLabel];
    noticeLabel.textAlignment=NSTextAlignmentCenter;
    noticeLabel.font=APP_BOLD_FONT(15.0);
    noticeLabel.text=@"直播已结束";
    
    UIButton  *  btn=[[UIButton alloc]initWithFrame:CGRectMake(40*KScaleW, noticeLabel.bottom+100*KScaleH, SCREEN_WIDTH-60*KScaleW, 40*KScaleH)];
      btn.backgroundColor=APP_NAVI_COLOR;
        [btn setRadius:20.0];
        [btn setTitle:@"返回首页" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
        btn.titleLabel.font=APP_NORMAL_FONT(18.0);
        [bgView addSubview:btn];
        [btn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
}

@end
