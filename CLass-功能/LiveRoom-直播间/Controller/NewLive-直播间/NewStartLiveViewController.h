//
//  NewStartLiveViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewStartLiveViewController : BaseViewController
@property (nonatomic, strong) NSDictionary    *  dic;
@property (nonatomic, strong) AlivcLivePushConfig   *   liveConfig;
@end

NS_ASSUME_NONNULL_END
