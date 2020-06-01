//
//  SearchVideoModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchVideoModel : NSObject
@property (nonatomic, copy) NSString     *      video_id;
@property (nonatomic, copy) NSString     *      title;
@property (nonatomic, copy) NSString     *      thumb;
@property (nonatomic, copy) NSString     *      play_num;
@property (nonatomic, copy) NSString     *      nickname;
@end

NS_ASSUME_NONNULL_END
