//
//  LiveHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LiveHandle.h"
#import "NewHttpTools.h"
@implementation LiveHandle
/// 创建直播
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param title <#title description#>
/// @param thumb <#thumb description#>
/// @param isScreen <#isScreen description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)createLiveWithUID:(int)uid token:(NSString *)token title:(NSString *)title thumb:(UIImage *)thumb isScreen:(int)isScreen exhibition_id:(int)exhibition_id success:(SuccessBlock)success failed:(FailedBlock)faled{
    
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"title":title,
                         @"is_screen":[NSNumber numberWithInt:isScreen],
                         @"exhibition_id":[NSNumber numberWithInt:exhibition_id],
                         @"cate_id":[NSNumber numberWithInt:1]
    };
//    NewHttpTools   *  httols=[[NewHttpTools alloc]init];
//
//    NSString * str=[NSString stringWithFormat:@"https://api.bjzhanbotest.com/%@",API_CTEATE_LIVE];
//    [httols requseetWithMethod:POST WithPath:str withParams:dic image:thumb thumbName:@"thumb" withSuccessBlock:^(NSDictionary *dic) {
//         success(dic);
//    } withFailureBlock:^(NSError *error) {
//        faled(error);
//    }];
    
    [HttpTools uploadImageWithPath:API_CTEATE_LIVE params:dic thumbName:@"thumb" images:thumb success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        faled(error);
    } progress:^(CGFloat progress) {
        
    }];
}
/// 关闭直播
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param faled <#faled description#>
+(void)CloseLiveWithUID:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)faled{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
        @"token":token
    };
    [HttpTools postWithPath:API_CLOSE_LIVE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        faled(error);
    }];
    
}
+(void)getLiveShareWithUid:(int)uid token:(NSString *)token liveUid:(int)liveUid stream:(NSString *)stream success:(SuccessBlock)success failed:(FailedBlock)faled{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
        @"token":token,
                         @"live_uid":[NSNumber numberWithInt:liveUid],
                         @"stream":stream
    };
    [HttpTools postWithPath:API_GET_LIVE_SHARE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        faled(error);
    }];
}
+(void)userGetInWithUid:(int)uid token:(NSString *)token live_uid:(int)live_uid uccess:(SuccessBlock)success failed:(FailedBlock)faled{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
           @"token":token,
                            @"live_uid":[NSNumber numberWithInt:live_uid]
                         
       };
       [HttpTools postWithPath:API_USER_IN_LIVE params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           faled(error);
       }];
}
+(void)updateLiveTypeWithUid:(int)uid token:(NSString *)token stream:(NSString *)stream success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
        @"token":token,
                         @"stream":stream
                      
    };
    [HttpTools postWithPath:API_UPDATE_LIVETYPE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
