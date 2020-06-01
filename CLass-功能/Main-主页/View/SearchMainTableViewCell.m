//
//  SearchMainTableViewCell.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SearchMainTableViewCell.h"

@implementation SearchMainTableViewCell
-(void)layoutSubviews{
    [self addSubview:self.indexNum];
    [self.indexNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(15*KScaleW);
    }];
    [self addSubview:self.hotWords];
    [self.hotWords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.indexNum.mas_right).offset(7.5*KScaleW);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(UILabel *)indexNum{
    if (!_indexNum) {
        _indexNum=[[UILabel alloc]init];
        _indexNum.backgroundColor=[UIColor colorWithHexString:@"#B8B8B8"];
        _indexNum.textColor=[UIColor whiteColor];
        _indexNum.font=APP_NORMAL_FONT(10.0);
        _indexNum.textAlignment=NSTextAlignmentCenter;
        [_indexNum setRadius:7.5*KScaleW];
    }
    return _indexNum;
}
-(UILabel *)hotWords{
    if (!_hotWords) {
        _hotWords=[[UILabel alloc]init];
        _hotWords.textColor=COLOR_333;
        _hotWords.textAlignment=NSTextAlignmentCenter;
        _hotWords.font=APP_NORMAL_FONT(16.0);
    }
    return _hotWords;
}
@end
