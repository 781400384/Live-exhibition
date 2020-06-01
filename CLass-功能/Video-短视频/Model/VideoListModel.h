//
//  VideoListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/15.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoListModel : NSObject
@property (nonatomic, copy) NSString     *   video_id;
@property (nonatomic, copy) NSString     *   title;
@property (nonatomic, copy) NSString     *   thumb;
@property (nonatomic, copy) NSString     *   spot_num;
@property (nonatomic, copy) NSString     *   comment_num;
@property (nonatomic, copy) NSString     *   share_num;
@property (nonatomic, copy) NSString     *   head_path;
@property (nonatomic, copy) NSString     *   nickname;
@property (nonatomic, copy) NSString     *   is_spot;//判断当前用户是否已经点赞 0否 1是
@property (nonatomic, copy) NSString     *   url;
@property (nonatomic, copy) NSString     *   is_follow;
@property (nonatomic, copy) NSString     *   uid;
@property (nonatomic, copy) NSString     *   play_num;
@end

NS_ASSUME_NONNULL_END
