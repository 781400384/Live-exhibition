//
//  MyVideoOrLikeViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVideoOrLikeViewController : BaseViewController
@property (nonatomic, copy) NSString     *     type;//0-我的喜欢,1-我的视频
@property (nonatomic, copy) NSString     *     uid;
@end

NS_ASSUME_NONNULL_END
