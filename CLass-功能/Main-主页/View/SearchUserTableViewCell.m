//
//  SearchUserTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SearchUserTableViewCell.h"

@implementation SearchUserTableViewCell

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
    [self addSubview:self.sexImg];
    [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickName.mas_right).offset(12*KScaleW);
        make.centerY.mas_equalTo(self.nickName.mas_centerY);
    }];
    [self addSubview:self.descripeLabel];
    [self.descripeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.avatarImg.mas_right).offset(12*KScaleW);
         make.top.mas_equalTo(self.nickName.mas_bottom).offset(9*KScaleW);
        make.width.mas_equalTo(200*KScaleW);
    }];
    [self addSubview:self.attentionBtn];
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-15*KScaleW);
        make.width.mas_equalTo(50*KScaleW);
        make.height.mas_equalTo(22.75*KScaleH);
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
-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn=[[UIButton alloc]init];
        [_attentionBtn setRadius:11.36*KScaleW];
        _attentionBtn.titleLabel.font=APP_NORMAL_FONT(12.0);
        [_attentionBtn addTarget:self action:@selector(attentioon:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionBtn;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _lineView;
}
-(void)setModel:(SearchUserModel *)model{
    _model=model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.head_path]];
    self.nickName.text=model.nickname;
    self.descripeLabel.text=model.user_sign;
    if ([model.user_type intValue]==1) {
        self.sexImg.image=[UIImage imageNamed:@"mine_company_type"];
    }else{
        if ([model.sex isEqualToString:@"男"]) {
            self.sexImg.image=[UIImage imageNamed:@"mine_man"];
        }else{
             self.sexImg.image=[UIImage imageNamed:@"mine_women"];
        }
    }
    if ([model.is_follow intValue]==0||![UserInfoDefaults isLogin]) {
        [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [self.attentionBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        self.attentionBtn.backgroundColor=APP_NAVI_COLOR;
    }else{
        [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.attentionBtn setTitle:@"关注" forState:UIControlStateSelected];
        [self.attentionBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
        self.attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
        self.attentionBtn.layer.borderWidth=0.5*KScaleW;
        self.attentionBtn.layer.borderColor=APP_NAVI_COLOR.CGColor;
    }
}
-(void)attentioon:(UIButton *)sender{
    sender.selected=!sender.selected;
    if ([self.model.is_follow intValue]==0||![UserInfoDefaults isLogin]){
    if (sender.selected) {
         [self.attentionBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
         self.attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
          self.attentionBtn.layer.borderWidth=0.5*KScaleW;
          self.attentionBtn.layer.borderColor=APP_NAVI_COLOR.CGColor;
    }else{
         [self.attentionBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
               self.attentionBtn.backgroundColor=APP_NAVI_COLOR;
    }

    }else{
        if (sender.selected) {
           [self.attentionBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
                   self.attentionBtn.backgroundColor=APP_NAVI_COLOR;
        }else{ [self.attentionBtn setTitleColor:APP_NAVI_COLOR forState:UIControlStateNormal];
                    self.attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
                     self.attentionBtn.layer.borderWidth=0.5*KScaleW;
                     self.attentionBtn.layer.borderColor=APP_NAVI_COLOR.CGColor;   self.attentionBtn.backgroundColor=[UIColor colorWithHexString:@"#ffffff"];
        }
    }
}
@end
