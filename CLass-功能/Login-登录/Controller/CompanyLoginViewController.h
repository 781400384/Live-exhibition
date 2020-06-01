//
//  CompanyLoginViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^LoginSuccessBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface CompanyLoginViewController : BaseViewController
@property (nonatomic, copy) LoginSuccessBlock         loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
