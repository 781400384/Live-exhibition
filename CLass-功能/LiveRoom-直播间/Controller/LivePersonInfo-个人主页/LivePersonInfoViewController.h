//
//  LivePersonInfoViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LivePersonInfoViewController : BaseViewController
@property (nonatomic, copy) NSString  *  imageUrl;
@property (nonatomic, copy) NSString  *  uid;

@property (nonatomic, copy) NSString   *   userType;//0-已关注,1-未关注
@end

NS_ASSUME_NONNULL_END
