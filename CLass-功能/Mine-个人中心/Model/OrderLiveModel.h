//
//  OrderLiveModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderLiveModel : NSObject
@property (nonatomic, copy) NSString     *    exhibition_id;
@property (nonatomic, copy) NSString     *    title;
@property (nonatomic, copy) NSString     *    thumb;
@property (nonatomic, copy) NSString     *    startTime;
@property (nonatomic, copy) NSString     *    endTime;
@property (nonatomic, copy) NSString     *    make_num;
@property (nonatomic, copy) NSString     *    status;
@end

NS_ASSUME_NONNULL_END
