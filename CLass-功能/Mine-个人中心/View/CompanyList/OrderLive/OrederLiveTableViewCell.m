//
//  OrederLiveTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "OrederLiveTableViewCell.h"

@implementation OrederLiveTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(120*KScaleW);
        make.height.mas_equalTo(65*KScaleH);
    }];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImg.mas_right).offset(14.5*KScaleW);
        make.top.mas_equalTo(self.logoImg.mas_top);
    }];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.titleLabel.mas_left);
           make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6*KScaleH);
       }];
    [self addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.titleLabel.mas_left);
           make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(6*KScaleH);
       }];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*KScaleW);
        make.top.mas_equalTo(self.typeLabel.mas_top);
    }];
}
-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg=[[UIImageView alloc]init];
        _logoImg.contentMode=UIViewContentModeScaleToFill;
        [_logoImg setRadius:7.5*KScaleH];
    }
    return _logoImg;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=APP_NORMAL_FONT(16.0);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=COLOR_333;
        _titleLabel.text=@"测试数据";
    }
    return _titleLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.textColor=COLOR_999;
        _timeLabel.font=APP_NORMAL_FONT(12.0);
        _timeLabel.text=@"2020-01-01";
    }
    return _timeLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel=[[UILabel alloc]init];
        _typeLabel.textAlignment=NSTextAlignmentCenter;
        _typeLabel.textColor=COLOR_999;
        _typeLabel.font=APP_NORMAL_FONT(12.0);
        _typeLabel.text=@"已开始";
    }
    return _typeLabel;
}
-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel=[[UILabel alloc]init];
        _numLabel.textAlignment=NSTextAlignmentCenter;
        _numLabel.textColor=COLOR_999;
        _numLabel.font=APP_NORMAL_FONT(12.0);
        _numLabel.text=@"已开始";
    }
    return _numLabel;
}
-(void)setModel:(OrderLiveModel *)model{
    _model=model;
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.titleLabel.text=model.title;
    self.timeLabel.text=model.startTime;
    if ([model.status intValue]==0) {
        self.typeLabel.text=@"未开始";
    }
    if ([model.status intValue]==1) {
        self.typeLabel.text=@"进行中";
    }
    if ([model.status intValue]==2) {
        self.typeLabel.text=@"已结束";
    }
    self.numLabel.text=[NSString stringWithFormat:@"%@人预约",model.make_num];
}
@end
