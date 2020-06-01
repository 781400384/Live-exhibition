//
//  LoginHandle.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginHandle : BaseHandle
/// 登录
/// @param phone <#phone description#>
/// @param pwd <#pwd description#>
/// @param type 0-普通用户 1-参展商
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)loginWithPhone:(NSString *)phone pwd:(NSString *)pwd type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 用户注册
/// @param phone <#phone description#>
/// @param code <#code description#>
/// @param pwd <#pwd description#>
/// @param rePwd <#rePwd description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)registerWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd rePwd:(NSString *)rePwd type:(int)type  success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取短信验证码
/// @param phone <#phone description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMsgCodeWithPhone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed;

/// 忘记密码
/// @param phone <#phone description#>
/// @param code <#code description#>
/// @param pwd <#pwd description#>
/// @param rePwd <#rePwd description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)forgetWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd rePwd:(NSString *)rePwd success:(SuccessBlock)success failed:(FailedBlock)failed;
/// 获取忘记密码短信验证码
/// @param phone <#phone description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getForMsgCodeWithPhone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed;


/// s第三方登录
/// @param openId <#openId description#>
/// @param Logintype <#Logintype description#>
/// @param nickName <#nickName description#>
/// @param avatar <#avatar description#>
/// @param sex <#sex description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)thirdLoginWithOpenId:(NSString *)openId type:(int)Logintype nickName:(NSString *)nickName avatar:(NSString *)avatar sex:(NSString *)sex type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed;
@end

NS_ASSUME_NONNULL_END
