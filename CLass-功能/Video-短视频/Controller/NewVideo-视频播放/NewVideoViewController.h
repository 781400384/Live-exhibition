//
//  NewVideoViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoListModel.h"
#import "VideoPlayerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewVideoViewController : BaseViewController
@property (nonatomic, strong) VideoListModel   *    model;
@property (nonatomic, strong) VideoPlayerView    *   playerView;
@end

NS_ASSUME_NONNULL_END
