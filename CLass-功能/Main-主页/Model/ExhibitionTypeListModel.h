//
//  ExhibitionTypeListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExhibitionTypeListModel : NSObject
@property (nonatomic, copy) NSString     *     exhibition_id;//#展会分类ID
@property (nonatomic, copy) NSString     *     title;//展会分类ID
@property (nonatomic, copy) NSString     *     thumb;//展会分类封面图
@property (nonatomic, copy) NSString     *     play_num;//展会分类播放量
@end

NS_ASSUME_NONNULL_END
