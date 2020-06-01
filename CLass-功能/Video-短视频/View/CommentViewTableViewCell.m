//
//  CommentViewTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CommentViewTableViewCell.h"
#import "VideoHandle.h"
@implementation CommentViewTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(35*KScaleW);
    }];
    
    [self addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImg.mas_right).offset(15*KScaleW);
        make.centerY.mas_equalTo(self.avatarImg.mas_centerY);
    }];
    [self addSubview:self.cmmentLabel];
    [self.cmmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImg.mas_right).offset(15*KScaleW);
        make.top.mas_equalTo(self.nickName.mas_bottom).offset(2*KScaleH);
        make.width.mas_equalTo(240*KScaleW);
    }];
//    [self addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.left.mas_equalTo(self.avatarImg.)
//    }];
    [self addSubview:self.praiseBtn];
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*KScaleH);
        make.right.mas_equalTo(-16*KScaleW);
        make.width.height.mas_equalTo(18*KScaleW);
    }];
    [self addSubview:self.praiseNum];
    [self.praiseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.praiseBtn.mas_bottom).offset(3*KScaleH);
        make.centerX.mas_equalTo(self.praiseBtn.mas_centerY);
    }];
}
-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg=[[UIImageView alloc]init];
        _avatarImg.contentMode=UIViewContentModeScaleToFill;
        _avatarImg.clipsToBounds=YES;
        _avatarImg.userInteractionEnabled=YES;
        [_avatarImg setRadius:17.5];
    }
    
    return _avatarImg;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc]init];
        _nickName.textAlignment=NSTextAlignmentCenter;
        _nickName.font=APP_BOLD_FONT(15.0);
        _nickName.textColor=[UIColor colorWithHexString:@"#000000"];
    }
    return _nickName;
}
-(UILabel *)cmmentLabel{
    if (!_cmmentLabel) {
           _cmmentLabel=[[UILabel alloc]init];
           _cmmentLabel.textAlignment=NSTextAlignmentLeft;
           _cmmentLabel.font=APP_NORMAL_FONT(15.0);
           _cmmentLabel.textColor=[UIColor colorWithHexString:@"#666666"];
        _cmmentLabel.numberOfLines=0;
       }
       return _cmmentLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.font=APP_NORMAL_FONT(12.0);
        _timeLabel.textColor=[UIColor colorWithHexString:@"#666666"];
              
    }
    return _timeLabel;
}
-(UIButton *)praiseBtn{
    if (!_praiseBtn) {
        _praiseBtn=[[UIButton alloc]init];
        [_praiseBtn setImage:[UIImage imageNamed:@"commeent_cancel_praise"] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"comment_praise"] forState:UIControlStateSelected];
        [_praiseBtn addTarget:self action:@selector(prasiseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}

-(UILabel *)praiseNum{
    if (!_praiseNum) {
        _praiseNum=[[UILabel alloc]init];
        _praiseNum.textAlignment=NSTextAlignmentCenter;
        _praiseNum.font=APP_NORMAL_FONT(10.0);
        _praiseNum.textColor=[UIColor colorWithHexString:@"#999999"];
    }
    return _praiseNum;
}
-(void)prasiseClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if ([self.model.is_spot intValue]==0) {
        if (sender.selected==YES) {
            [self praise];
        }else{
            [self cancelPraise];
        }
    }else{
        if (sender.selected==YES) {
                  [self cancelPraise];
              }else{
                  [self praise];
              }
    }
}
-(void)setModel:(CommendModel *)model{
    _model=model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.head_path] placeholderImage:[UIImage imageNamed:@"comment_default"]];
    self.nickName.text=model.nickname;
    self.cmmentLabel.text=[NSString stringWithFormat:@"%@   %@",model.content,model.addTime];
//    self.timeLabel.text=model.addTime;
    self.praiseNum.text=model.spot_num;
    if ([model.is_spot intValue]==0) {
          [_praiseBtn setImage:[UIImage imageNamed:@"commeent_cancel_praise"] forState:UIControlStateNormal];
          [_praiseBtn setImage:[UIImage imageNamed:@"comment_praise"] forState:UIControlStateSelected];
    }else{
        [_praiseBtn setImage:[UIImage imageNamed:@"commeent_cancel_praise"] forState:UIControlStateSelected];
        [_praiseBtn setImage:[UIImage imageNamed:@"comment_praise"] forState:UIControlStateNormal];
    }
}
-(void)praise{
    
    [VideoHandle prasieVideoWithSpotid:[self.model.video_comment_id intValue] UIID:[[UserInfoDefaults userInfo].uid intValue] type:1 success:^(id  _Nonnull obj) {
        
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)cancelPraise{
    [VideoHandle cancelPraiseVideoWithSpotid:[self.model.video_comment_id intValue] UIID:[[UserInfoDefaults userInfo].uid intValue] type:1 success:^(id  _Nonnull obj) {
        
    } failed:^(id  _Nonnull obj) {
        
    }];
}
@end
