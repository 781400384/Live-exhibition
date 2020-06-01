//
//  BaseViewController.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, strong) NaviView    *  naviView;
- (void)showLeftItemButton:(BOOL)show;
- (void)showRightItemButton:(BOOL)show;
- (void)leftDismiss;
- (void)rightTitleLabelTap;
@end

NS_ASSUME_NONNULL_END
