//
//  NaviView.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NaviView : UIView
@property (nonatomic, strong) UIButton         *            leftItemButton;
@property (nonatomic, strong) UIButton         *            rightItemButton;
@property (nonatomic, strong) UILabel          *            naviTitleLabel;
@property (nonatomic, strong) UIImageView      *            image;
@property (nonatomic, strong) UILabel          *            rightTitleLabel;

@end

NS_ASSUME_NONNULL_END
