//
//  CreateCompanyInfoTableViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CreateCompanyInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) ImageModel     *    model;
@property (nonatomic, strong) UIImageView    *    addImage;
@property (nonatomic, strong) UIButton       *    closeBtn;
@end

NS_ASSUME_NONNULL_END
