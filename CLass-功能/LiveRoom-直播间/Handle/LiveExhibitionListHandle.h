//
//  LiveExhibitionListHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveExhibitionListHandle : BaseHandle
/// 获取直播展会分类
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionListWithUid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
