//
//  CoustomerRegisterViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LoginSuccessBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface CoustomerRegisterViewController : BaseViewController
@property (nonatomic, copy) NSString     *    type;//0-注册,1-忘记密码
@property (nonatomic, copy) LoginSuccessBlock         loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
