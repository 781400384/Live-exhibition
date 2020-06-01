//
//  CompanyForgetViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginSuccessBlock)(void);
@interface CompanyForgetViewController : BaseViewController
@property (nonatomic, copy) LoginSuccessBlock         loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
