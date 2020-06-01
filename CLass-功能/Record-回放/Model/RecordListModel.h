//
//  RecordListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/15.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordListModel : NSObject
@property (nonatomic, copy) NSString    * live_uid;//1, #正在直播用户ID
@property (nonatomic, copy) NSString    * title; //正在直播标题
@property (nonatomic, copy) NSString    * thumb; //正在直播封面图
@property (nonatomic, copy) NSString    * cate_son_title;//二级分类名称
@property (nonatomic, copy) NSString    * cate_parent_title;//一级分类名称
@property (nonatomic, copy) NSString    * play_num;//直播次数
@property (nonatomic, copy) NSString    * play_type;//0-正在直播 1-精彩回放
@property (nonatomic, copy) NSString    * live_record_id;//直播回放ID
@property (nonatomic, copy) NSString    * is_screen;//是否横屏 0-竖屏 1-横屏
@property (nonatomic, copy) NSString    * live_type;//直播间是否设置密码0-否 1-是
@end

NS_ASSUME_NONNULL_END
