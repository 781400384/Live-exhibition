//
//  MainCollectionViewCell.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListModel.h"
#import "ExihibitionListModel.h"
#import "RecordMainModel.h"
#import "RecordListModel.h"
#import "SearchLiveModel.h"
#import "MineLiveNote.h"
#import "SearchVideoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) LiveListModel       *    liveModel;
@property (nonatomic, strong) ExihibitionListModel   *         exhibitionModel;
@property (nonatomic, strong) RecordMainModel  *    recordModel;
@property (nonatomic, strong) RecordListModel  *    recordListModel;
@property (nonatomic, strong) SearchLiveModel  *    searchLiveModel;
@property (nonatomic, strong) SearchVideoModel *    searchVideoModel;
@property (nonatomic, strong) MineLiveNote     *    liveNoteModel;
@property (nonatomic, strong) UIImageView      *    bgImage;
@property (nonatomic, strong) UILabel          *    typeLabel;
@property (nonatomic, strong) UIView           *    bgView;
@property (nonatomic, strong) UILabel          *    videoType;
@property (nonatomic, strong) UIImageView      *    watchImg;
@property (nonatomic, strong) UILabel          *    watchNum;
@property (nonatomic, strong) UILabelSet          *    titleLabel;
@end

NS_ASSUME_NONNULL_END
