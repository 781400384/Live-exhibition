//
//  LiveExhibitionListHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LiveExhibitionListHandle.h"

@implementation LiveExhibitionListHandle
/// 获取直播展会分类
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionListWithUid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token
    };
    [HttpTools postWithPath:API_GET_LIVE_EXHIBITION params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
