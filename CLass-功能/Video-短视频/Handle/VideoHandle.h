//
//  VideoHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/16.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoHandle : BaseHandle
/// 获取短视频列表
/// @param page <#page description#>
/// @param uid <#uid description#>
/// @param cateId <#cateId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getVideoListWuthPage:(int)page uid:(int)uid cateId:(NSString *)cateId success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取被访问用户详情
/// @param uid <#uid description#>
/// @param visit_uid <#visit_uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getOtherUserInfoWithUid:(int)uid visit_uid:(int)visit_uid success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取视频评论列表

/// @param uid <#uid description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCommentListWithVideoId:(int)videoId uid:(int)uid page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 用户发布评论
/// @param videoId <#videoId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param content <#content description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)sendJudgeWithVideoId:(int)videoId uid:(int)uid tken:(NSString *)token content:(NSString *)content success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取短视频分享链接
/// @param videod <#videod description#>
/// @param uid <#uid description#>
/// @param shareType <#shareType description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getVideoShareWithVideoId:(int)videod uid:(int)uid  success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 短视频点赞
/// @param spotiD <#spotiD description#>
/// @param UID <#UID description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)prasieVideoWithSpotid:(int)spotiD UIID:(int)UID type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 取消点赞
/// @param spotiD <#spotiD description#>
/// @param UID <#UID description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)cancelPraiseVideoWithSpotid:(int)spotiD UIID:(int)UID type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取视频分享总次数
/// @param videod <#videod description#>
/// @param uid <#uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getShareCountWithVideoId:(int)videod uid:(int)uid  success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
