//
//  NaviView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "NaviView.h"

@implementation NaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.leftItemButton];
    [self addSubview:self.naviTitleLabel];
    [self addSubview:self.rightItemButton];
    [self addSubview:self.rightTitleLabel];
      CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-15*KScaleW));
        make.top.mas_equalTo(y);
      
    }];
    
    
}

- (UIButton *)leftItemButton {
    
    if (!_leftItemButton) {
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftItemButton.frame = CGRectMake(13, y, 24*KScaleW,24*KScaleW);
        _leftItemButton.titleLabel.font = APP_MAIN_FONT;
        [_leftItemButton setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    }
    return _leftItemButton;
}
- (UIButton *)rightItemButton {
    
    if (!_rightItemButton) {
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.frame = CGRectMake(SCREEN_WIDTH-70, y, 65, self.height-y);
        _rightItemButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightItemButton;
}

- (UILabel *)rightTitleLabel {
    
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc]init];
        _rightTitleLabel.font = APP_MAIN_FONT;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [_rightTitleLabel sizeToFit];
        _rightTitleLabel.userInteractionEnabled = YES;
    }
    return _rightTitleLabel;
}

- (UILabel *)naviTitleLabel {
    
    if (!_naviTitleLabel) {
        
        CGFloat y = IS_X ? NAVI_SUBVIEW_Y_iphoneX : NAVI_SUBVIEW_Y_Normal;
        _naviTitleLabel = [[UILabel alloc]init];
            _naviTitleLabel.frame=CGRectMake(50*KScaleW, y, SCREEN_WIDTH-100*KScaleW, 15.5*KScaleH);
        _naviTitleLabel.textAlignment = NSTextAlignmentCenter;
        _naviTitleLabel.textColor = COLOR_333;
        _naviTitleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _naviTitleLabel.userInteractionEnabled=YES;
    }
    return _naviTitleLabel;
}

@end
