//
//  VideoPlayerView.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/5.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListModel.h"
#import "MyVideoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerView : UIView
@property (nonatomic, strong) VideoListModel   *    model;
@property (nonatomic, strong) MyVideoListModel *    myModel;
@property (nonatomic, strong) UIButton              *backBtn;
@property (nonatomic, strong) UIImageView         *coverImage;
@property (nonatomic, retain)  UISlider           *playProgress;
@property (nonatomic, retain)  UIButton           *playBtn;
@property (nonatomic, retain)  UIImageView        *avatarImage;
@property (nonatomic, retain)  UIButton           *attentionBtn;
@property (nonatomic, retain)  UIButton           *praiseBtn;
@property (nonatomic, retain)  UILabel            *praiseNum;
@property (nonatomic, retain)  UIButton           *judgeBtn;
@property (nonatomic, retain)  UILabel            *judgeLabel;
@property (nonatomic, retain)  UIButton           *shareBtn;
@property (nonatomic, retain)  UILabel            *shareLabel;
@property (nonatomic, retain)  UILabel            *titleLabel;
@property (nonatomic, retain)  UILabel            *descripeLabel;

-(void)showPlayBtn;
-(void)hidePlayBtn;
@end

NS_ASSUME_NONNULL_END
