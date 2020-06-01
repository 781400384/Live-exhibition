//
//  MineHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "MineHandle.h"

/// <#Description#>
@implementation MineHandle
/// 获取设置列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getSettingListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools postWithPath:API_GET_AGREEMENT params:nil loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 验证是否直播
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)verfiLiveWithSucc:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"uid":[NSNumber numberWithInt:[[UserInfoDefaults userInfo].uid intValue]],
                           @"token":[UserInfoDefaults userInfo].token
    };
    [HttpTools postWithPath:API_VERFI_LIVE params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取我的直播记录
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getLiveNoteWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_GET_LIVE_NOTE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取我的预约记录
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)orderLiveWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_GET_ORDER_LIVE params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)getCompanyListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"page":[NSNumber numberWithInt:page]
       };
    [HttpTools postWithPath:API_GET_COMPANYLIST params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
  
      
}

/// 获取个人兴趣标签
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getIntersetLabelWithUid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                           @"token":token
         };
    [HttpTools postWithPath:API_GET_INTERSET params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
     
}
/// 修改用户信息
/// @param uid <#uid description#>
/// @param token <#token description#>

/// @param nickName <#nickName description#>
/// @param sign <#sign description#>
/// @param sex <#sex description#>
/// @param labelIds <#labelIds description#>
/// @param birthday <#birthday description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)updateUserInfoWithUid:(int)uid token:(NSString *)token  nickName:(NSString *)nickName sign:(NSString *)sign sex:(NSString *)sex label_ids:(NSString *)labelIds birthday:(NSString *)birthday success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"nickname":nickName,
                         @"user_sign":sign,
                         @"sex":sex,
                         @"birthday":birthday,
                         @"label_ids":labelIds
    };
    NSLog(@"个人资料传入的参数=%@",dic);
    [HttpTools postWithPath:API_UPDATE_USERINDO params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
   
}
+(void)uploadAvatarImageWith:(UIImage *)avatarImg Uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token
    };
    [HttpTools uploadImageWithPath:API_UPDATE_USERINDO params:dic thumbName:@"head_path" images:avatarImg success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
       
    } progress:^(CGFloat progress) {
        
    }];
}
/// 获取我的喜欢列表
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMyVideoLikeListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_GET_VIDEOLIKE params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)getMyVideoListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"page":[NSNumber numberWithInt:page]
    };
    [HttpTools postWithPath:API_MY_VIODEOLIST params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 上传企业墙单张照片
/// @param img <#img description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)uploadCompanyImgWithImage:(UIImage *)img success:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools uploadImageWithPath:API_UPLOAD_COMPANYIMG params:nil thumbName:@"thumb" images:img success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    } progress:^(CGFloat progress) {
        
    }];
}
/// 添加企业墙
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param pictureImg <#pictureImg description#>
/// @param title <#title description#>
/// @param desc <#desc description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)addCompanyImgWithUid:(int)uid tokenL:(NSString *)token pictureImg:(NSString *)pictureImg title:(NSString *)title desc:(NSString *)desc success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"picture_ids":pictureImg,
                         @"title":title,
                         @"desc":desc
    };
    [HttpTools postWithPath:API_ADD_COMPANY params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
         failed(error);
    }];
}
+(void)deleCompanyWithwallId:(NSString *)wallId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"user_wall_id":wallId,
                         @"uid":[NSNumber numberWithInt:uid],
                         @"token":token
    };
    [HttpTools postWithPath:API_DELETE_COMPANY params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 编辑企业墙
/// @param uiid <#uiid description#>
/// @param token <#token description#>
/// @param bgImg <#bgImg description#>
/// @param typeId <#typeId description#>
/// @param sign <#sign description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)editCompanyWithUid:(int)uiid token:(NSString *)token bgImg:(UIImage *)bgImg typeId:(NSString *)typeId sign:(NSString *)sign success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uiid],
                         @"token":token,
                         @"cate_ids":typeId,
                         @"user_sign":sign
    };
    [HttpTools uploadImageWithPath:API_EDIT_COMPANY params:dic thumbName:@"bg_img" images:bgImg success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    } progress:^(CGFloat progress) {
        
    }];
}
/// 获取企业墙详情
/// @param uid <#uid description#>
/// @param wallId <#wallId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCmpanyInfoDetailWithUid:(int)uid wallId:(NSString *)wallId success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"user_wall_id":wallId
    };
    [HttpTools postWithPath:API_GET_COMPANYDETAIL params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 点赞企业墙
/// @param wallId <#wallId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)praiseCompanyWithWallId:(int)wallId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"user_wall_id":[NSNumber numberWithInt:wallId],
                         @"token":token
       };
       [HttpTools postWithPath:API_PRAISE_COMPANY params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 获取用户信息分享
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param visit_uid <#visit_uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getInfoShareWithUid:(int)uid token:(NSString *)token visit_uid:(int)visit_uid success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                        @"visit_uid":[NSNumber numberWithInt:visit_uid],
                        @"token":token
          };
          [HttpTools postWithPath:API_GET_INFO_SHARE params:dic loading:NO success:^(id  _Nonnull json) {
              success(json);
          } failure:^(NSError * _Nonnull error) {
              failed(error);
          }];
}
/// 获取七牛云token
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getQiNiuTokenWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    [HttpTools postWithPath:API_GET_QINIUTOKEN params:nil loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
+(void)publishVideoWithUid:(int)uid token:(NSString *)token title:(NSString *)title thumb:(NSString *)thumb url:(NSString *)url success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"uid":[NSNumber numberWithInt:uid],
                         @"token":token,
                         @"title":title,
                         @"thumb":thumb,
                         @"url":url,
                         @"cate_id":[NSNumber numberWithInt:2]};
    [HttpTools postWithPath:API_PUBLISH_VIDEO params:dic loading:NO success:^(id  _Nonnull json) {
         success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
