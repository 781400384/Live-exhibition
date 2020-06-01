//
//  PublishVideoViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/22.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublishVideoViewController : BaseViewController
@property (nonatomic, strong) NSDictionary  *  dic;
@property (nonatomic, copy)  NSString       *  videoUrl;
@property (nonatomic, strong) UIImage       *  defaultImage;
@end

NS_ASSUME_NONNULL_END
