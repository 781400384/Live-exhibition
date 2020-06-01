//
//  NewVideoCollectionViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/5.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewVideoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) VideoListModel  *   model;
@property (nonatomic, strong) UIImageView     *   bgImage;
@property (nonatomic, strong) UILabelSet         *   desc;
//@property (nonatomic, strong) UIImageView     *   avatarImg;
@property (nonatomic, strong) UILabel         *   nickName;
@property (nonatomic, strong) UIImageView     *   playImg;
@property (nonatomic, strong) UILabel         *   playNum;
@end

NS_ASSUME_NONNULL_END
