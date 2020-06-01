//
//  MessageTableViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView      *     avatarImg;
@property (nonatomic, strong) UILabel          *     nickName;
@property (nonatomic, strong) UILabel          *     descripeLabel;
@property (nonatomic, strong) UIImageView      *     sexImg;
@property (nonatomic, strong) UILabel          *     timeLabel;
@property (nonatomic, strong) UIView           *     lineView;
@end

NS_ASSUME_NONNULL_END
