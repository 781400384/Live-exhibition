//
//  VideoViewModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoViewModel : NSObject
@property (nonatomic, assign) BOOL  has_more;

- (void)refreshNewListWithTypeId:(int)TypeId Success:(void(^)(NSArray *list))success
                            failure:(void(^)(NSError *error))failure;

- (void)refreshMoreListWithTypeId:(int)TypeId Success:(void(^)(NSArray *list))success
                            failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
