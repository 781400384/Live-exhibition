//
//  CommendModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommendModel : NSObject
@property (nonatomic, copy) NSString      *      video_comment_id;
@property (nonatomic, copy) NSString      *      content;
@property (nonatomic, copy) NSString      *      addTime;
@property (nonatomic, copy) NSString      *      spot_num;
@property (nonatomic, copy) NSString      *      head_path;
@property (nonatomic, copy) NSString      *      nickname;
@property (nonatomic, copy) NSString      *      is_spot;
@end

NS_ASSUME_NONNULL_END
