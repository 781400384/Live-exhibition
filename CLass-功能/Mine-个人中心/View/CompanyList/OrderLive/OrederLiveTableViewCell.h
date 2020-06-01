//
//  OrederLiveTableViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderLiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrederLiveTableViewCell : UITableViewCell
@property (nonatomic, strong) OrderLiveModel   *     model;
@property (nonatomic, strong) UIImageView      *     logoImg;
@property (nonatomic, strong) UILabel          *     titleLabel;
@property (nonatomic, strong) UILabel          *     timeLabel;
@property (nonatomic, strong) UILabel          *     typeLabel;
@property (nonatomic, strong) UILabel          *     numLabel;
@end

NS_ASSUME_NONNULL_END
