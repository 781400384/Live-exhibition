//
//  CreateCompanyInfoTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "CreateCompanyInfoTableViewCell.h"

@implementation CreateCompanyInfoTableViewCell

-(void)layoutSubviews{
    [self addSubview:self.addImage];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(7.5*KScaleH);
        make.width.mas_equalTo(200*KScaleW);
        make.height.mas_equalTo(112.5*KScaleH);
    }];
    [self.addImage addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(30*KScaleW);
        make.height.mas_equalTo(18*KScaleH);
    }];
}
-(UIImageView  *)addImage{
    if (!_addImage) {
        _addImage=[[UIImageView alloc]init];
        _addImage.contentMode=UIViewContentModeScaleAspectFit;
        _addImage.clipsToBounds=YES;
        _addImage.userInteractionEnabled=YES;
    }
    return _addImage;
}
-(void)setModel:(ImageModel *)model{
    _model=model;
    [_addImage sd_setImageWithURL:[NSURL URLWithString:model.path]];
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[UIButton alloc]init];
        [_closeBtn setImage:[UIImage imageNamed:@"companyInfo_close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}
@end
