//
//  MessageTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*KScaleW);
        make.height.width.mas_equalTo(50*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImg.mas_right).offset(12*KScaleW);
        make.top.mas_equalTo(16*KScaleH);
    }];
    [self addSubview:self.descripeLabel];
    [self.descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.avatarImg.mas_right).offset(12*KScaleW);
         make.top.mas_equalTo(self.nickName.mas_bottom).offset(9*KScaleW);
    }];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nickName.mas_centerY);
        make.right.mas_equalTo(-15*KScaleW);
    }];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImg.mas_right);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5*KScaleH);
        make.right.mas_equalTo(0);
    }];
}
-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg=[[UIImageView alloc]init];
        _avatarImg.clipsToBounds=YES;
        _avatarImg.userInteractionEnabled=YES;
        [_avatarImg setRadius:25*KScaleW];
    }
    return _avatarImg;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc]init];
        _nickName.textColor=[UIColor colorWithHexString:@"#101010"];
        _nickName.textAlignment=NSTextAlignmentCenter;
        _nickName.font=APP_NORMAL_FONT(17.0);
    }
    return _nickName;
}
-(UILabel *)descripeLabel{
    if (!_descripeLabel) {
        _descripeLabel=[[UILabel alloc]init];
        _descripeLabel.textColor=[UIColor colorWithHexString:@"#666666"];
        _descripeLabel.textAlignment=NSTextAlignmentCenter;
        _descripeLabel.font=APP_NORMAL_FONT(14.0);
    }
    return _descripeLabel;
}
-(UIImageView *)sexImg{
    if (!_sexImg) {
        _sexImg=[[UIImageView alloc]init];
        _sexImg.clipsToBounds=YES;
        _sexImg.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _sexImg;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.font=APP_NORMAL_FONT(12.0);
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.textColor=[UIColor colorWithHexString:@"#666666"];
    }
    return _timeLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _lineView;
}

@end
