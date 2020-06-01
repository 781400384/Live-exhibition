//
//  SearchUserTableViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchUserTableViewCell : UITableViewCell
@property (nonatomic, strong) SearchUserModel  *     model;
@property (nonatomic, strong) UIImageView      *     avatarImg;
@property (nonatomic, strong) UILabel          *     nickName;
@property (nonatomic, strong) UILabel          *     descripeLabel;
@property (nonatomic, strong) UIImageView      *     sexImg;
@property (nonatomic, strong) UIButton         *     attentionBtn;
@property (nonatomic, strong) UIView           *     lineView;
@end

NS_ASSUME_NONNULL_END
