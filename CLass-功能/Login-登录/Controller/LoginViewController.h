//
//  LoginViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/7.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LoginSuccessBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController
@property (nonatomic, copy) LoginSuccessBlock         loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
