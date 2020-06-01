//
//  SearchLiveModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchLiveModel : NSObject
@property (nonatomic, copy) NSString    *     live_uid;
@property (nonatomic, copy) NSString    *     title;
@property (nonatomic, copy) NSString    *     thumb;
@property (nonatomic, copy) NSString    *     cate_son_title;
@property (nonatomic, copy) NSString    *     cate_parent_title;
@property (nonatomic, copy) NSString    *     play_num;
@property (nonatomic, copy) NSString    *     play_type;
@property (nonatomic, copy) NSString    *     live_record_id;
@property (nonatomic, copy) NSString    *     is_screen;//是否横屏 0-竖屏 1-横屏
@property (nonatomic, copy) NSString    *     live_type;//直播间是否设置密码0-否 1-是
@end

NS_ASSUME_NONNULL_END
