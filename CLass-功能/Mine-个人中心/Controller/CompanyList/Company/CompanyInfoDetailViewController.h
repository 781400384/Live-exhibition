//
//  CompanyInfoDetailViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/15.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyInfoDetailViewController : BaseViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic,strong) UIViewController *VC;
@property (nonatomic, copy) NSString   *  companyId;
@property (nonatomic, copy) NSString   *  userType;
@end

NS_ASSUME_NONNULL_END
