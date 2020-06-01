//
//  RecordHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "RecordHandle.h"

@implementation RecordHandle
/// 获取回放列表
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordListWiithPage:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber  numberWithInt:page]};
    [HttpTools  postWithPath:API_GET_RECORD params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取二级回放列表
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordListSecWithPage:(int)page exhibitionTypeId:(NSString *)typeId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber  numberWithInt:page],
                         @"exhibition_id":typeId
    };
       [HttpTools  postWithPath:API_GET_RECORD_LIST params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取播放视频详情
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param recordId <#recordId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordDetailWithUdi:(int)uid token:(NSString *)token recordId:(int)recordId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"live_record_id":[NSNumber numberWithInt:recordId]
    };
    [HttpTools postWithPath:API_GET_RECORD_DETAL params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
}
/// 获取视频详情接口
/// @param uid <#uid description#>
/// @param videoId <#videoId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getVideoDetailWithUid:(int)uid videoId:(int)videoId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                            @"video_id":[NSNumber numberWithInt:videoId]
       };
       [HttpTools postWithPath:API_GET_VIDEO_DETAI params:dic loading:NO success:^(id  _Nonnull json) {
            success(json);
       } failure:^(NSError * _Nonnull error) {
            failed(error);
       }];
}
@end
