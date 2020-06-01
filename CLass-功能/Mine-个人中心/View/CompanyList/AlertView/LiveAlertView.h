//
//  LiveAlertView.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveAlertView : UIView
- (void)showView;
-(void)dismissAlertView;
@property (nonatomic,strong) UIButton  *    startVideo;
@property (nonatomic, strong)  UIButton  *    startLive;
@end

NS_ASSUME_NONNULL_END
