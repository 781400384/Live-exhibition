//
//  CompanyImageListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyImageListModel : NSObject
@property (nonatomic, copy) NSString     *    user_wall_id;
@property (nonatomic, copy) NSString     *    title;
@property (nonatomic, copy) NSString     *    desc;
@property (nonatomic, copy) NSString     *    thumb;
@property (nonatomic, copy) NSString     *    spot_num;
@property (nonatomic, copy) NSString     *    comment_num;
@property (nonatomic, copy) NSString     *    share_num;
@property (nonatomic, copy) NSString     *    wall_uid;

@end

NS_ASSUME_NONNULL_END
