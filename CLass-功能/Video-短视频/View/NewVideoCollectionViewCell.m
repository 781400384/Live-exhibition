//
//  NewVideoCollectionViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/5.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "NewVideoCollectionViewCell.h"
#import "VideoListModel.h"
@implementation NewVideoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
      CAGradientLayer *gl = [CAGradientLayer layer];
          gl.frame = CGRectMake(0,0,self.width,self.height-20.5*KScaleH);
          
          gl.startPoint = CGPointMake(0, 0);
          gl.endPoint = CGPointMake(1, 1);
          gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
          gl.locations = @[@(0.0),@(1.0)];
      
          [self.bgImage.layer addSublayer:gl];
    }
    return self;
}
-(void)layoutSubviews{
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self);
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(195*KScaleH);
    }];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//           gl.frame = CGRectMake(0,0,self.width,195*KScaleH);
//           
//           gl.startPoint = CGPointMake(0, 0);
//           gl.endPoint = CGPointMake(1, 1);
//           gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
//           gl.locations = @[@(0.0),@(1.0)];
//       
//           [self.bgImage.layer addSublayer:gl];
//    [self.bgImage addSubview:self.avatarImg];
//    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10*KScaleW);
//        make.bottom.mas_equalTo(-10*KScaleH);
//        make.height.width.mas_equalTo(20);
//    }];

    [self.bgImage addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*KScaleW);
        make.bottom.mas_equalTo(-4.5*KScaleH);
    }];
    [self.bgImage addSubview:self.playNum];
    [self.playNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-4.5*KScaleH);
        make.right.mas_equalTo(-9.5*KScaleW);
    }];
    [self.bgImage addSubview:self.playImg];
    [self.playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.playNum.mas_left).offset(-2.5*KScaleW);
        make.centerY.mas_equalTo(self.playNum.mas_centerY);
        make.width.mas_equalTo(9*KScaleW);
        make.height.mas_equalTo(11.5*KScaleH);
    }];
    [self addSubview:self.desc];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.bgImage.mas_bottom).offset(7*KScaleH);
        make.width.mas_equalTo(self.width);
    }];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,self.width,self.height);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];
//
//    [self.layer addSublayer:gl];
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.clipsToBounds=YES;
        _bgImage.contentMode=UIViewContentModeScaleToFill;
        _bgImage.userInteractionEnabled=YES;
        [_bgImage setRadius:5.0];
    }
    return _bgImage;
}

-(UILabelSet *)desc{
    if (!_desc) {
        _desc=[[UILabelSet alloc]init];
        _desc.textColor=COLOR_333;
        _desc.font=APP_BOLD_FONT(14.0);
        _desc.textAlignment=NSTextAlignmentLeft;
        _desc.numberOfLines=0;
    }
    return _desc;
}
-(UIImageView *)playImg{
    if (!_playImg) {
        _playImg=[[UIImageView alloc]init];
        _playImg.clipsToBounds=YES;
        _playImg.contentMode=UIViewContentModeScaleAspectFit;
        _playImg.userInteractionEnabled=YES;
        _playImg.image=[UIImage imageNamed:@"video_playImg"];
       
    }
    return _playImg;
}
//-(UIImageView *)avatarImg{
//    if (!_avatarImg) {
//        _avatarImg=[[UIImageView alloc]init];
//        _avatarImg.clipsToBounds=YES;
//        _avatarImg.contentMode=UIViewContentModeScaleToFill;
//        _avatarImg.userInteractionEnabled=YES;
//        [_avatarImg setRadius:10.0];
//    }
//    return _avatarImg;
//}

-(UILabel *)playNum{
    if (!_playNum) {
       _playNum=[[UILabel alloc]init];
        _playNum.textColor=[UIColor whiteColor];
        _playNum.font=APP_NORMAL_FONT(12.0);
        _playNum.textAlignment=NSTextAlignmentCenter;
       
    }
    return _playNum;
}
-(UILabel *)nickName{
    if (!_nickName) {
       _nickName=[[UILabel alloc]init];
        _nickName.textColor=[UIColor whiteColor];
        _nickName.font=APP_NORMAL_FONT(12.0);
        _nickName.textAlignment=NSTextAlignmentCenter;
       
    }
    return _nickName;
}
-(void)setModel:(VideoListModel *)model{
    _model=model;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
    self.desc.text=model.title;
    self.nickName.text=model.nickname;
    self.playNum.text=model.play_num;
//    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.head_path] placeholderImage:[UIImage imageNamed:@""]];
}
@end
