//
//  ExihibitionListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExihibitionListModel : NSObject
@property (nonatomic, copy) NSString       *       exhibition_id;//展会ID
@property (nonatomic, copy) NSString       *       thumb;//展会封面图
@property (nonatomic, copy) NSString       *       startTime;//展会时间
@property (nonatomic, copy) NSString       *       title;//展会名称
@end

NS_ASSUME_NONNULL_END
