//
//  MyVideoLikeModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/4.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyVideoLikeModel : NSObject
@property (nonatomic, copy) NSString    *  video_id;
@property (nonatomic, copy) NSString    *  title;
@property (nonatomic, copy) NSString    *  thumb;
@property (nonatomic, copy) NSString    *  comment_num;
@property (nonatomic, copy) NSString    *  head_path;
@property (nonatomic, copy) NSString    *  is_spot;
@property (nonatomic, copy) NSString    *  play_num;
@property (nonatomic, copy) NSString    *  share_num;
@property (nonatomic, copy) NSString    *  spot_num;
@property (nonatomic, copy) NSString    *  uid;
@property (nonatomic, copy) NSString    *  url;
@property (nonatomic, copy) NSString    *  nickname;
@end

NS_ASSUME_NONNULL_END
