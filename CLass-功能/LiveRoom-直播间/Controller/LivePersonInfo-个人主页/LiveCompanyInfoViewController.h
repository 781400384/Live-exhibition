//
//  LiveCompanyInfoViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <WMZPageController/WMZPageController.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveCompanyInfoViewController : WMZPageController
@property (nonatomic, copy) NSString  *  imageUrl;
@property (nonatomic, copy) NSString  *  uid;
@property (nonatomic, copy) NSString   *  userType;
@property (nonatomic, copy) NSString   *   showType;
@end

NS_ASSUME_NONNULL_END
