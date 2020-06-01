//
//  SearchUserModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/17.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchUserModel : NSObject
@property (nonatomic, copy) NSString     *     uid;
@property (nonatomic, copy) NSString     *     head_path;
@property (nonatomic, copy) NSString     *     sex;
@property (nonatomic, copy) NSString     *     nickname;
@property (nonatomic, copy) NSString     *     user_sign;
@property (nonatomic, copy) NSString     *     is_follow;//是否关注 0-未关注 1-已关注
@property (nonatomic, copy) NSString     *     user_type;//用户类型 0-普通用户 1-参展商
@end

NS_ASSUME_NONNULL_END
