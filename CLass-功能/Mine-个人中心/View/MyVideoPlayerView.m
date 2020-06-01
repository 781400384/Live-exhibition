//
//  MyVideoPlayerView.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/26.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MyVideoPlayerView.h"
#import "VideoHandle.h"
#import "MainHandle.h"
@implementation MyVideoPlayerView

- (void)didMoveToWindow {
    if (self.window) {
        //创建通知
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess:) name:ShareSuccessNotification object:nil];
    }
}
 
 
//从当前window删除 相当于-viewDidUnload
- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow == nil) {
//移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ShareSuccessNotification object:nil];
    }
}
-(void)layoutSubviews{
    [self addSubview:self.coverImage];
     [self.coverImage addSubview:self.backBtn];
       [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.mas_equalTo(self);
       }];
       [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(15.0f);
           make.top.mas_equalTo(IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal);
           make.width.height.mas_equalTo(22.0f);
       }];
          [self.coverImage addSubview:self.descripeLabel];
          [self.descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(10*KScaleW);
              make.bottom.mas_equalTo(-16*KScaleH);
              make.width.mas_equalTo(209*KScaleW);
              make.height.mas_equalTo(24.5*KScaleH);
          }];
          [self.coverImage addSubview:self.titleLabel];
          [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(10*KScaleH);
              make.bottom.mas_equalTo(self.descripeLabel.mas_top).offset(-10.5*KScaleH);
          }];
          [self.coverImage addSubview:self.shareBtn];
          [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.right.mas_equalTo(-15*KScaleW);
              make.bottom.mas_equalTo(-33.5*KScaleH);
              make.width.height.mas_equalTo(32*KScaleW);
          }];
          [self.coverImage addSubview:self.shareLabel];
          [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.shareBtn.mas_centerX);
              make.top.mas_equalTo(self.shareBtn.mas_bottom).offset(2.5*KScaleH);
          }];
          [self.coverImage addSubview:self.judgeBtn];
          [self.judgeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(-15*KScaleW);
             make.bottom.mas_equalTo(self.shareBtn.mas_top).offset(-28.5*KScaleH);
             make.width.height.mas_equalTo(32*KScaleW);
          }];
          [self.coverImage addSubview:self.judgeLabel];
          [self.judgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.judgeBtn.mas_centerX);
              make.top.mas_equalTo(self.judgeBtn.mas_bottom).offset(2.5*KScaleH);
          }];
          [self.coverImage addSubview:self.praiseBtn];
          [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.right.mas_equalTo(-15*KScaleW);
              make.bottom.mas_equalTo(self.judgeBtn.mas_top).offset(-28.5*KScaleH);
              make.width.height.mas_equalTo(32*KScaleW);
          }];
          [self.coverImage addSubview:self.praiseNum];
          [self.praiseNum mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.praiseBtn.mas_centerX);
              make.top.mas_equalTo(self.praiseBtn.mas_bottom).offset(2.5*KScaleH);
          }];
          [self.coverImage addSubview:self.avatarImage];
          [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.praiseBtn.mas_centerX);
              make.bottom.mas_equalTo(self.praiseBtn.mas_top).offset(-32*KScaleH);
              make.height.width.mas_equalTo(50*KScaleW);
          }];
    [self.coverImage addSubview:self.attentionBtn];
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImage.mas_bottom).offset(-11*KScaleH);
        make.width.height.mas_equalTo(22*KScaleH);
        make.centerX.mas_equalTo(self.avatarImage.mas_centerX);
    }];
          [self.coverImage addSubview:self.playBtn];
          [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.coverImage.mas_centerX);
              make.centerY.mas_equalTo(self.coverImage.mas_centerY);
          }];
}
-(UIImageView *)coverImage{
    if (!_coverImage) {
        _coverImage=[[UIImageView alloc]init];
        _coverImage.contentMode=UIViewContentModeScaleToFill;
         [_coverImage sd_setImageWithURL:[NSURL URLWithString:self.myModel.thumb]];
        _coverImage.userInteractionEnabled=YES;
    }
    return _coverImage;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
    }
    return _backBtn;
}
-(UILabel  *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.text=[UserInfoDefaults userInfo].nickname;
        _titleLabel.font=APP_BOLD_FONT(16.0);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)descripeLabel{
    if (!_descripeLabel) {
        _descripeLabel=[[UILabel alloc]init];
        _descripeLabel.font=APP_NORMAL_FONT(15.0);
        _descripeLabel.numberOfLines=0;
        _descripeLabel.text=self.myModel.title;
        _descripeLabel.textColor=[UIColor whiteColor];
        _descripeLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _descripeLabel;
}
-(UILabel *)judgeLabel{
    if (!_judgeLabel) {
           _judgeLabel=[[UILabel alloc]init];
           _judgeLabel.font=APP_NORMAL_FONT(11.0);
           _judgeLabel.numberOfLines=0;
           _judgeLabel.textColor=[UIColor whiteColor];
           _judgeLabel.textAlignment=NSTextAlignmentLeft;
        _judgeLabel.text=[NSString stringWithFormat:@"%@", self.myModel.comment_num];
       }
       return _judgeLabel;
}
-(UILabel *)shareLabel{
    if (!_shareLabel) {
           _shareLabel=[[UILabel alloc]init];
           _shareLabel.font=APP_NORMAL_FONT(11.0);
           _shareLabel.numberOfLines=0;
           _shareLabel.textColor=[UIColor whiteColor];
           _shareLabel.textAlignment=NSTextAlignmentLeft;
         _shareLabel.text=[NSString stringWithFormat:@"%@",self.myModel.share_num];
       }
       return _shareLabel;
}
-(UILabel *)praiseNum{
    if (!_praiseNum) {
           _praiseNum=[[UILabel alloc]init];
           _praiseNum.font=APP_NORMAL_FONT(11.0);
           _praiseNum.numberOfLines=0;
           _praiseNum.textColor=[UIColor whiteColor];
           _praiseNum.textAlignment=NSTextAlignmentLeft;
        _praiseNum.text=[NSString stringWithFormat:@"%@",self.myModel.spot_num];
       }
       return _praiseNum;
}
-(UISlider *)playProgress{
    if (!_playProgress) {
        _playProgress=[[UISlider alloc]init];
        _playProgress.maximumValue = 0;
        _playProgress.minimumValue = 0;
        _playProgress.value = 0;
        _playProgress.continuous = NO;
        _playProgress.thumbTintColor=[UIColor colorWithHexString:@"#ffffff"];
        _playProgress.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _playProgress;
}
-(UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage=[[UIImageView alloc]init];
        _avatarImage.clipsToBounds=YES;
        _avatarImage.contentMode=UIViewContentModeScaleToFill;
        _avatarImage.userInteractionEnabled=YES;
        [_avatarImage setRadius:25*KScaleW];
        [_avatarImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDefaults userInfo].head_path]];
    }
    return _avatarImage;
}
-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn=[[UIButton alloc]init];
        [_attentionBtn setImage:[UIImage imageNamed:@"video_have_attention"] forState:UIControlStateNormal];
            
       
     
    }
    return _attentionBtn;
}
-(UIButton *)praiseBtn{
    if (!_praiseBtn) {
        _praiseBtn=[[UIButton alloc]init];
        [_praiseBtn setImage:[UIImage imageNamed:@"video_praise"] forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(praise:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _praiseBtn;
}
-(UIButton *)judgeBtn{
    if (!_judgeBtn) {
        _judgeBtn=[[UIButton alloc]init];
        [_judgeBtn setImage:[UIImage imageNamed:@"video_judge"] forState:UIControlStateNormal];
    }
    return _judgeBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn=[[UIButton alloc]init];
        [_shareBtn setImage:[UIImage imageNamed:@"video_share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn=[[UIButton alloc]init];
        [_playBtn setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        _playBtn.hidden=YES;
    }
    return _playBtn;
}

-(void)showPlayBtn{
     _playBtn.hidden=NO;
}
-(void)hidePlayBtn{
    _playBtn.hidden=YES;
}
-(void)praise:(UIButton *)sender{
    [self toast:@"自己不能给自己点赞"];
}

-(void)shareSuccess:(NSNotification *)share{
    NSLog(@"1111");
    self.shareLabel.text=[NSString stringWithFormat:@"%d",[self.shareLabel.text intValue]+1];
    [VideoHandle getShareCountWithVideoId:[self.myModel.video_id intValue] uid:[[UserInfoDefaults userInfo].uid intValue] success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"视频分享%@",dic);
        
    } failed:^(id  _Nonnull obj) {
        
    }];
}



@end
