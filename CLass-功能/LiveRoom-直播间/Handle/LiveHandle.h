//
//  LiveHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveHandle : BaseHandle
/// 创建直播
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param title <#title description#>
/// @param thumb <#thumb description#>
/// @param isScreen <#isScreen description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)createLiveWithUID:(int)uid token:(NSString *)token title:(NSString *)title thumb:(UIImage *)thumb isScreen:(int)isScreen exhibition_id:(int)exhibition_id success:(SuccessBlock)success failed:(FailedBlock)faled;
/// 关闭直播间
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)CloseLiveWithUID:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)faled;
/// 获取直播分享b
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param liveUid <#liveUid description#>
/// @param stream <#stream description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)getLiveShareWithUid:(int)uid token:(NSString *)token liveUid:(int)liveUid stream:(NSString *)stream success:(SuccessBlock)success failed:(FailedBlock)faled;;

/// 用户进入直播间
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param live_uid <#live_uid description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)userGetInWithUid:(int)uid token:(NSString *)token live_uid:(int)live_uid uccess:(SuccessBlock)success failed:(FailedBlock)faled;

/// 修改状态为正在直播
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param stream <#stream description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)updateLiveTypeWithUid:(int)uid token:(NSString *)token stream:(NSString *)stream success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
