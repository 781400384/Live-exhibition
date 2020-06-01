//
//  LiveUserModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/22.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveUserModel : NSObject
@property (nonatomic, copy) NSString     *   uid;
@property (nonatomic, copy) NSString     *   user_login;
@property (nonatomic, copy) NSString     *   nickname;
@property (nonatomic, copy) NSString     *   sex;
@property (nonatomic, copy) NSString     *   head_path;
@property (nonatomic, copy) NSString     *   user_sign;
@property (nonatomic, copy) NSString     *   mobile;
@property (nonatomic, copy) NSString     *   token;
@property (nonatomic, copy) NSString     *   user_type;
@property (nonatomic, copy) NSString     *   level;
@property (nonatomic, copy) NSString     *   level_path;
@property (nonatomic, copy) NSString     *   is_corpse;
@end

NS_ASSUME_NONNULL_END
