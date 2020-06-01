//
//  LiveListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveListModel : NSObject
@property (nonatomic, copy) NSString      *     live_uid;//直播用户uid
@property (nonatomic, copy) NSString      *     title;//直播标题
@property (nonatomic, copy) NSString      *     thumb;//直播封面图
@property (nonatomic, copy) NSString      *     cate_son_title;//直播子分类名称
@property (nonatomic, copy) NSString      *     play_num;//观看数量
@property (nonatomic, copy) NSString      *     play_type;//直播类型 0-正在直播 1-精彩回放
@property (nonatomic, copy) NSString      *     live_record_id;//直播回放ID
@property (nonatomic, copy) NSString      *     is_screen;//是否横屏 0-竖屏 1-横屏
@property (nonatomic, copy) NSString      *     live_type;//直播间是否设置密码0-否 1-是
@end

NS_ASSUME_NONNULL_END
