//
//  MyVidePlayViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
#import "MyVideoListModel.h"
#import "MyVideoPlayerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyVidePlayViewController : BaseViewController
@property (nonatomic, strong) MyVideoListModel   *    model;
@property (nonatomic, strong) MyVideoPlayerView    *   playerView;
@end

NS_ASSUME_NONNULL_END
