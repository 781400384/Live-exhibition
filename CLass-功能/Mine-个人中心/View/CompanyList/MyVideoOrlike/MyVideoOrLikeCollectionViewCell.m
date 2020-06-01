//
//  MyVideoOrLikeCollectionViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MyVideoOrLikeCollectionViewCell.h"

@implementation MyVideoOrLikeCollectionViewCell
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
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,self.width,self.height);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];

//    [self.layer addSublayer:gl];
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height);
    }];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,self.width,self.height);
//        
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
//        gl.locations = @[@(0.0),@(1.0)];
//    
//        [self.bgImage.layer addSublayer:gl];
    [self.bgImage addSubview:self.watchNum];
    [self.watchNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10*KScaleW);
        make.bottom.mas_equalTo(-5*KScaleH);
    }];
    [self.bgImage addSubview:self.watchImg];
    [self.watchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.watchNum.mas_left).offset(-3.5*KScaleW);
        make.centerY.mas_equalTo(self.watchNum.mas_centerY);
    }];
   
}
-(UIImageView  *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.clipsToBounds=YES;
        _bgImage.userInteractionEnabled=YES;
        [_bgImage setRadius:5*KScaleH];
        _bgImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _bgImage;
}

-(UIImageView *)watchImg{
    if (!_watchImg) {
        _watchImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_heart_small"]];
        _watchImg.clipsToBounds=YES;
        _watchImg.contentMode=UIViewContentModeScaleAspectFit;
        [_watchImg setRadius:5.0*KScaleH];
    }
    return _watchImg;
}
-(UILabel *)watchNum{
    if (!_watchNum) {
        _watchNum=[[UILabel alloc]init];
        _watchNum.textColor=[UIColor whiteColor];
        _watchNum.textAlignment=NSTextAlignmentCenter;
        _watchNum.font=APP_NORMAL_FONT(12);
        _watchNum.text=@"11万";
    }
    return _watchNum;
}
-(void)setImageListModel:(CompanyImageListModel *)imageListModel{
    _imageListModel=imageListModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:imageListModel.thumb]];
    self.watchNum.text=imageListModel.spot_num;
    
}
-(void)setVideoLikemodel:(MyVideoLikeModel *)videoLikemodel{
    _videoLikemodel=videoLikemodel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:videoLikemodel.thumb]];
    self.watchNum.text=videoLikemodel.spot_num;
}
-(void)setVideoListModel:(MyVideoListModel *)videoListModel{
    _videoListModel=videoListModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:videoListModel.thumb]];
    self.watchNum.text=videoListModel.play_num;
}
@end
