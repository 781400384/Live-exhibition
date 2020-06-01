//
//  VideoHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VideoHandle.h"

@implementation VideoHandle
/// 获取短视频列表
/// @param page <#page description#>
/// @param uid <#uid description#>
/// @param cateId <#cateId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getVideoListWuthPage:(int)page uid:(int)uid cateId:(NSString *)cateId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber  numberWithInt:page],
                         @"uid":[NSNumber numberWithInt:uid],
                         @"cate_id":cateId
    };
    [HttpTools postWithPath:API_GET_VIDEO_LIST params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取被访问用户信息
/// @param uid <#uid description#>
/// @param visit_uid <#visit_uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getOtherUserInfoWithUid:(int)uid visit_uid:(int)visit_uid success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"visit_uid":[NSNumber numberWithInt:visit_uid],
                         @"token":[UserInfoDefaults userInfo].token
    };
    NSLog(@"访问参数==%@",dic);
    [HttpTools postWithPath:API_GET_OTHER_INFO params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
}
/// 获取视频评论列表
/// @param videoId <#videoId description#>
/// @param uid <#uid description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCommentListWithVideoId:(int)videoId uid:(int)uid page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"video_id":[NSNumber numberWithInt:videoId],
                         @"uid":[NSNumber numberWithInt:uid],
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_GET_COMMENT_LIST params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 用户发布评论
/// @param videoId <#videoId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param content <#content description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)sendJudgeWithVideoId:(int)videoId uid:(int)uid tken:(NSString *)token content:(NSString *)content success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"video_id":[NSNumber numberWithInt:videoId],
                         @"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"content":content
    };
    
    [HttpTools postWithPath:API_SEND_JUDGE params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)getVideoShareWithVideoId:(int)videod uid:(int)uid success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"video_id":[NSNumber numberWithInt:videod],
                            @"uid":[NSNumber numberWithInt:uid],
       };
       [HttpTools postWithPath:API_GET_VIDEO_SHARE params:dic loading:NO success:^(id  _Nonnull json) {
            success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
+(void)prasieVideoWithSpotid:(int)spotiD UIID:(int)UID type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"spot_id":[NSNumber numberWithInt:spotiD],
                         @"uid":[NSNumber numberWithInt:UID],
                         @"type":[NSNumber numberWithInt:type]
    };
    [HttpTools postWithPath:APII_PRAISE_VIDEO params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

+(void)cancelPraiseVideoWithSpotid:(int)spotiD UIID:(int)UID type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"spot_id":[NSNumber numberWithInt:spotiD],
                         @"uid":[NSNumber numberWithInt:UID],
                         @"type":[NSNumber numberWithInt:type]
    };
    [HttpTools postWithPath:API_CANCEL_PRAISE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)getShareCountWithVideoId:(int)videod uid:(int)uid success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"video_id":[NSNumber numberWithInt:videod],
                               @"uid":[NSNumber numberWithInt:uid],
          };
          [HttpTools postWithPath:API_GET_SHARE_COUNT params:dic loading:NO success:^(id  _Nonnull json) {
               success(json);
          } failure:^(NSError * _Nonnull error) {
              failed(error);
          }];
    
}
@end
