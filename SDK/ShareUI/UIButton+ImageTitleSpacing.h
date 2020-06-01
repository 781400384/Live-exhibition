//
//  UIButton+ImageTitleSpacing.h
//  LzhAlertView
//
//  Created by 刘中华 on 2019/12/10.
//  Copyright © 2019 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LZHButtonEdgeInsetsStyle) {
    LZHButtonEdgeInsetsStyleTop, // image在上，label在下
    LZHButtonEdgeInsetsStyleLeft, // image在左，label在右
    LZHButtonEdgeInsetsStyleBottom, // image在下，label在上
    LZHButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(LZHButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
