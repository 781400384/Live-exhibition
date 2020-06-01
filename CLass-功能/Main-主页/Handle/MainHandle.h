//
//  MainHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainHandle : BaseHandle
/// 获取首页分类数据
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMainPageInfoListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

+(void)getTypelistWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取分类下的直播和回放
/// @param cateID <#cateID description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCategoaryWithCateId:(int)cateID page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;


/// 获取直播预告列表
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionListWithPage:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取直播预告详情
/// @param exhibitionId <#exhibitionId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionDetailWithExhibitionId:(int)exhibitionId uid:(int)uid  token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 预约展会
/// @param exhibitionId <#exhibitionId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)orderExhibitionWithExhibitionId:(int)exhibitionId uid:(int)uid  token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 搜索
/// @param page <#page description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param keyWord <#keyWord description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)searchWithpage:(int)page uid:(int)uid token:(NSString *)token keyWord:(NSString *)keyWord type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 关注用户
/// @param userId <#userId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>关注用户
+(void)attentionUserWithUserId:(int)userId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取关注用户列表
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getFollowListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 取消关注用户
/// @param userId <#userId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)cancelAttentionWithUserId:(int)userId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取直播回访分享接口
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param live_record_id <#live_record_id description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getLiveRecordShareWithUid:(int)uid token:(NSString *)token live_record_id:(int)live_record_id success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取展会分享接口
/// @param exhibition_id <#exhibition_id description#>
/// @param uid <#uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionShreWithExhibition_id:(int)exhibition_id Uid:(int)uid success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
