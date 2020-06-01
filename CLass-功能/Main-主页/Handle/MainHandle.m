//
//  MainHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MainHandle.h"

@implementation MainHandle

/// 获取首页分类数据
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMainPageInfoListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"parent_id":[NSNumber numberWithInt:0]};
    [HttpTools postWithPath:API_GET_PAGELIST params:nil loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)getTypelistWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"parent_id":[NSNumber numberWithInt:0]};
       [HttpTools postWithPath:API_GET_TYPE_LIST params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取分类下的直播或回放
/// @param cateID <#cateID description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCategoaryWithCateId:(int)cateID page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"cate_id":[NSNumber numberWithInt:cateID],
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_GET_LIVE_LIIIST params:dic loading:NO success:^(id  _Nonnull json) {
          success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
}
/// 获取直播预告列表
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionListWithPage:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber numberWithInt:page]};
    [HttpTools postWithPath:API_GET_EXHIBITION params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
}
/// 获取直播预告详情
/// @param exhibitionId <#exhibitionId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionDetailWithExhibitionId:(int)exhibitionId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary *  dic=@{@"exhibition_id":[NSNumber numberWithInt:exhibitionId],
                          @"uid":[NSNumber numberWithInt:uid],
                          @"token":token};
    [HttpTools postWithPath:API_GET_EXHIBITION_DETAIL params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
    
}
/// 预约展会
/// @param exhibitionId <#exhibitionId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)orderExhibitionWithExhibitionId:(int)exhibitionId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary *  dic=@{@"exhibition_id":[NSNumber numberWithInt:exhibitionId],
                             @"uid":[NSNumber numberWithInt:uid],
                             @"token":token};
       [HttpTools postWithPath:API_ORDER_EXHIBITION params:dic loading:NO success:^(id  _Nonnull json) {
            success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 搜索
/// @param page <#page description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param keyWord <#keyWord description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)searchWithpage:(int)page uid:(int)uid token:(NSString *)token keyWord:(NSString *)keyWord type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber numberWithInt:page],
                         @"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"keyword":keyWord,
                         @"search_type":[NSNumber numberWithInt:type]
    };
    [HttpTools postWithPath:API_SEARCH params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// G关注用户
/// @param userId <#userId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)attentionUserWithUserId:(int)userId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"touid":[NSNumber numberWithInt:userId],
                         @"uid":[NSNumber numberWithInt:uid],
                         @"token":token
    };
     [HttpTools postWithPath:API_ATTEITON_USER params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
+(void)getFollowListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"page":[NSNumber numberWithInt:page],
                           @"uid":[NSNumber numberWithInt:uid],
                           @"token":token
      };
       [HttpTools postWithPath:API_GET_FOLLOW params:dic loading:NO success:^(id  _Nonnull json) {
             success(json);
         } failure:^(NSError * _Nonnull error) {
             failed(error);
         }];
}
/// 取消关注
/// @param userId <#userId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)cancelAttentionWithUserId:(int)userId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"touid":[NSNumber numberWithInt:userId],
                            @"uid":[NSNumber numberWithInt:uid],
                            @"token":token
       };
        [HttpTools postWithPath:API_CANCEL_ATTENTION params:dic loading:NO success:^(id  _Nonnull json) {
              success(json);
          } failure:^(NSError * _Nonnull error) {
              failed(error);
          }];
}
/// 获取直播回放分享接口
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param live_record_id <#live_record_id description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getLiveRecordShareWithUid:(int)uid token:(NSString *)token live_record_id:(int)live_record_id success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"live_record_id":[NSNumber numberWithInt:live_record_id],
                               @"uid":[NSNumber numberWithInt:uid],
                         @"token":token
          };
           [HttpTools postWithPath:API_GET_RECORD_SHARE params:dic loading:NO success:^(id  _Nonnull json) {
                 success(json);
             } failure:^(NSError * _Nonnull error) {
                 failed(error);
             }];
}
/// 获取h展会分享接口
/// @param exhibition_id <#exhibition_id description#>
/// @param uid <#uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getExhibitionShreWithExhibition_id:(int)exhibition_id Uid:(int)uid success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"exhibition_id":[NSNumber numberWithInt:exhibition_id],
                                  @"uid":[NSNumber numberWithInt:uid]
             };
              [HttpTools postWithPath:API_GET_EXHIBITION_SHARE params:dic loading:NO success:^(id  _Nonnull json) {
                    success(json);
                } failure:^(NSError * _Nonnull error) {
                    failed(error);
                }];
}
@end
