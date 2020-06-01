//
//  MainCollectionViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell
//- (void)setBounds:(CGRect)bounds {
//
//    [super setBounds:bounds];
//
//    self.contentView.frame = bounds;
//
//}
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
//      self. translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height-20.5*KScaleH);
    }];
    [self.bgImage addSubview:self.bgView];
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,self.width,self.height-20.5*KScaleH);
//
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
//        gl.locations = @[@(0.0),@(1.0)];
//
//        [self.bgImage.layer addSublayer:gl];
        [self setRadius:7.5];
    CGFloat watchSize=[self getWidthWithTitle:self.videoType.text font:APP_NORMAL_FONT(12.0)];
          self.bgView.width=watchSize+10*KScaleW;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5*KScaleH);
        make.right.mas_equalTo(-5*KScaleW);
//         self.bgView.width=watchSize+10*KScaleW;
        make.width.mas_equalTo(watchSize+10*KScaleW);
        make.height.mas_equalTo(15*KScaleH);
    }];
    [self.bgView addSubview:self.videoType];
    [self.videoType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.bgView.mas_width);
        make.height.mas_equalTo(self.bgView.mas_height);
    }];
    [self.bgImage addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*KScaleW);
        make.bottom.mas_equalTo(-6*KScaleH);
    }];
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
    [self  addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImage.mas_bottom).offset(7*KScaleH);
        make.height.mas_equalTo(14*KScaleH);
        make.width.mas_equalTo(self.mas_width);
        make.left.mas_equalTo(self.bgImage.mas_left);
    }];
    
    
    
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,self.width,self.height);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0].CGColor];
//    gl.locations = @[@(0.0),@(1.0)];
//
//    [self.layer addSublayer:gl];
//    [self setRadius:7.5];

}
-(UIImageView  *)bgImage{
    if (!_bgImage) {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.clipsToBounds=YES;
        _bgImage.userInteractionEnabled=YES;
        [_bgImage setRadius:7.5*KScaleH];
        _bgImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _bgImage;
}
-(UILabel *)videoType{
    if (!_videoType) {
        _videoType=[[UILabel alloc]init];
        _videoType.textColor=[UIColor whiteColor];
        _videoType.backgroundColor=RGBA(0, 0, 0, 0.6);
        [_videoType setRadius:7.5*KScaleH];
        _videoType.textAlignment=NSTextAlignmentCenter;
        _videoType.font=APP_NORMAL_FONT(10);
        _videoType.text=@"正在直播";
    }
    return _videoType;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel=[[UILabel alloc]init];
        _typeLabel.textColor=[UIColor whiteColor];
        [_typeLabel setRadius:7.5*KScaleH];
        _typeLabel.textAlignment=NSTextAlignmentCenter;
        _typeLabel.font=APP_NORMAL_FONT(12);
        _typeLabel.text=@"正在直播";
    }
    return _typeLabel;
}
-(UIImageView *)watchImg{
    if (!_watchImg) {
        _watchImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_watch"]];
        _watchImg.clipsToBounds=YES;
        _watchImg.contentMode=UIViewContentModeScaleAspectFit;
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

-(UILabelSet *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabelSet alloc]init];
        _titleLabel.textColor=COLOR_333;
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.font=APP_BOLD_FONT(14);
//        _titleLabel.numberOfLines=0;
        _titleLabel.text=@"测试数据假数据";
        
    }
    return _titleLabel;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=RGBA(0, 0, 0, 0.4);
        [_bgView setRadius:7.5*KScaleH];
    }
    return _bgView;
}
-(void)setLiveModel:(LiveListModel *)liveModel{
    _liveModel=liveModel;
    if ([liveModel.play_type isEqualToString:@"0"]) {
        self.videoType.text=@"正在直播";
    }
    if ([liveModel.play_type isEqualToString:@"1"]) {
           self.videoType.text=@"精彩回放";
       }
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:liveModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
    self.typeLabel.text=liveModel.cate_son_title;
    self.watchNum.text=liveModel.play_num;
    self.titleLabel.text=liveModel.title;
}
-(void)setExhibitionModel:(ExihibitionListModel *)exhibitionModel{
    _exhibitionModel=exhibitionModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:exhibitionModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
      CGFloat watchSize=[self getWidthWithTitle:exhibitionModel.startTime font:APP_NORMAL_FONT(12.0)];
    if (watchSize>50*KScaleW) {
        self.bgView.width=watchSize+10*KScaleW;
    }else{
        self.bgView.width=50*KScaleW;
    }
    self.videoType.text=exhibitionModel.startTime;
    self.titleLabel.text=exhibitionModel.title;
}
-(void)setRecordModel:(RecordMainModel *)recordModel{
    _recordModel=recordModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:recordModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
       self.watchNum.text=recordModel.play_num;
       self.titleLabel.text=recordModel.title;
}
-(void)setRecordListModel:(RecordListModel *)recordListModel{
    _recordListModel=recordListModel;
      [self.bgImage sd_setImageWithURL:[NSURL URLWithString:recordListModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
        self.watchNum.text=recordListModel.play_num;
        self.titleLabel.text=recordListModel.title;
        self.typeLabel.text=recordListModel.cate_parent_title;
    if ([recordListModel.play_type isEqualToString:@"0"]) {
         self.videoType.text=@"正在直播";
    }
    if ([recordListModel.play_type isEqualToString:@"1"]) {
        self.videoType.text=@"精彩回放";
    }
}
-(void)setSearchLiveModel:(SearchLiveModel *)searchLiveModel{
    _searchLiveModel=searchLiveModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:searchLiveModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
           self.watchNum.text=searchLiveModel.play_num;
           self.titleLabel.text=searchLiveModel.title;
           self.typeLabel.text=searchLiveModel.cate_parent_title;
       if ([searchLiveModel.play_type isEqualToString:@"0"]) {
            self.videoType.text=@"正在直播";
       }
       if ([searchLiveModel.play_type isEqualToString:@"1"]) {
           self.videoType.text=@"精彩回放";
       }
}
-(void)setSearchVideoModel:(SearchVideoModel *)searchVideoModel{
    _searchVideoModel=searchVideoModel;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:searchVideoModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
              self.watchNum.text=searchVideoModel.play_num;
              self.titleLabel.text=searchVideoModel.title;
              self.typeLabel.text=searchVideoModel.nickname;
        
}
-(void)setLiveNoteModel:(MineLiveNote *)liveNoteModel{
    _liveNoteModel=liveNoteModel;
    self.titleLabel.text=liveNoteModel.title;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:liveNoteModel.thumb]];
     self.watchNum.text=liveNoteModel.play_num;
}
-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
