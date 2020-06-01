//
//  RecordHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface RecordHandle : BaseHandle


/// 获取回放列表
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordListWiithPage:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;


/// 获取二级回访列表
/// @param page <#page description#>
/// @param typeId <#typeId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordListSecWithPage:(int)page exhibitionTypeId:(NSString *)typeId success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取回放视频详情
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param recordId <#recordId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getRecordDetailWithUdi:(int)uid token:(NSString *)token recordId:(int)recordId success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取视频详情接口
/// @param uid <#uid description#>
/// @param videoId <#videoId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getVideoDetailWithUid:(int)uid videoId:(int)videoId success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
