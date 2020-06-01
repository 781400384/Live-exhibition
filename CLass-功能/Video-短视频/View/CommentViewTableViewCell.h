//
//  CommentViewTableViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentViewTableViewCell : UITableViewCell
@property (nonatomic, strong) CommendModel *   model;
@property (nonatomic, strong) UIImageView  *   avatarImg;
@property (nonatomic, strong) UILabel      *   nickName;
@property (nonatomic, strong) UILabel      *   timeLabel;
@property (nonatomic, strong) UILabel      *   cmmentLabel;
@property (nonatomic, strong) UIButton     *   praiseBtn;
@property (nonatomic, strong) UILabel      *   praiseNum;
@end

NS_ASSUME_NONNULL_END
