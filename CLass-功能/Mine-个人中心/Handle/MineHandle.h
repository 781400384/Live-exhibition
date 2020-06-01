//
//  MineHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineHandle : BaseHandle
/// 获取设置列表
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getSettingListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 验证直播
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)verfiLiveWithSucc:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取直播记录
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getLiveNoteWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取我的预约
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)orderLiveWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;
/// <#Description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCompanyListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取个人兴趣标签
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getIntersetLabelWithUid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

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
+(void)updateUserInfoWithUid:(int)uid token:(NSString *)token  nickName:(NSString *)nickName sign:(NSString *)sign sex:(NSString *)sex label_ids:(NSString *)labelIds birthday:(NSString *)birthday success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 上传头像
/// @param avatarImg <#avatarImg description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)uploadAvatarImageWith:(UIImage *)avatarImg Uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取我喜欢的视频列表
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMyVideoLikeListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取我的视频记录
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param page <#page description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMyVideoListWithUid:(int)uid token:(NSString *)token page:(int)page success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 上传企业墙单张照片
/// @param img <#img description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)uploadCompanyImgWithImage:(UIImage *)img success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 添加企业墙
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param pictureImg <#pictureImg description#>
/// @param title <#title description#>
/// @param desc <#desc description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)addCompanyImgWithUid:(int)uid tokenL:(NSString *)token pictureImg:(NSString *)pictureImg title:(NSString *)title desc:(NSString *)desc success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 删除企业墙
/// @param wallId <#wallId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)deleCompanyWithwallId:(NSString *)wallId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 编辑企业墙
/// @param uiid <#uiid description#>
/// @param token <#token description#>
/// @param bgImg <#bgImg description#>
/// @param typeId <#typeId description#>
/// @param sign <#sign description#>
/// @param success <#success description#>
/// @param failed <#failed description#>编辑企业墙
+(void)editCompanyWithUid:(int)uiid token:(NSString *)token bgImg:(UIImage *)bgImg typeId:(NSString *)typeId sign:(NSString *)sign success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取企业墙详情
/// @param uid <#uid description#>
/// @param wallId <#wallId description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getCmpanyInfoDetailWithUid:(int)uid wallId:(NSString *)wallId success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 点赞企业墙
/// @param wallId <#wallId description#>
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)praiseCompanyWithWallId:(int)wallId uid:(int)uid token:(NSString *)token success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取用户信息分享
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param visit_uid <#visit_uid description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getInfoShareWithUid:(int)uid token:(NSString *)token visit_uid:(int)visit_uid success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 获取七牛云token
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getQiNiuTokenWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/// 用户发布视频
/// @param uid <#uid description#>
/// @param token <#token description#>
/// @param title <#title description#>
/// @param thumb <#thumb description#>
/// @param url <#url description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)publishVideoWithUid:(int)uid token:(NSString *)token title:(NSString *)title thumb:(NSString *)thumb url:(NSString *)url success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
