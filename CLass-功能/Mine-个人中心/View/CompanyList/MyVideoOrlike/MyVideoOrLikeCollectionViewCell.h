//
//  MyVideoOrLikeCollectionViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyImageListModel.h"
#import "MyVideoLikeModel.h"
#import "MyVideoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyVideoOrLikeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CompanyImageListModel     *    imageListModel;
@property (nonatomic, strong) MyVideoLikeModel          *    videoLikemodel;
@property (nonatomic, strong) MyVideoListModel          *    videoListModel;
@property (nonatomic, strong) UIImageView      *    bgImage;
@property (nonatomic, strong) UIImageView      *    watchImg;
@property (nonatomic, strong) UILabel          *    watchNum;

@end

NS_ASSUME_NONNULL_END
