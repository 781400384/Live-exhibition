//
//  ZMCusCommentListContentCell.h
//  ZM
//
//  Created by Kennith.Zeng on 2018/8/29.
//  Copyright © 2018年 Kennith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"
@interface ZMCusCommentListContentCell : UITableViewCell
- (void)configData:(id)data;
@property (nonatomic, strong) CommendModel   *  model;
@end
