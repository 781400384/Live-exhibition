//
//  MineLiveNote.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineLiveNote : NSObject
@property (nonatomic, copy) NSString    *    live_record_id;
@property (nonatomic, copy) NSString    *    title;
@property (nonatomic, copy) NSString    *    thumb;
@property (nonatomic, copy) NSString    *    play_num;
@property (nonatomic, copy) NSString    *    is_screen;
@end

NS_ASSUME_NONNULL_END
