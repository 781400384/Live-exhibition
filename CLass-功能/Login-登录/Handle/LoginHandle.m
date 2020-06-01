//
//  LoginHandle.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "LoginHandle.h"

@implementation LoginHandle
/// 登录
/// @param phone <#phone description#>
/// @param pwd <#pwd description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)loginWithPhone:(NSString *)phone pwd:(NSString *)pwd type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary  *  dic=@{@"user_login":phone,
                           @"password":pwd,
                           @"login_type":[NSNumber numberWithInt:type]
                           
    };
    NSLog(@"1111=%@",dic);
    [HttpTools postWithPath:API_LOGIN params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
        
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 普通用户注册
/// @param phone <#phone description#>
/// @param code <#code description#>
/// @param pwd <#pwd description#>
/// @param rePwd <#rePwd description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)registerWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd rePwd:(NSString *)rePwd type:(int)type  success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"mobile":phone,
                         @"code":code,
                         @"password":pwd,
                         @"re_pwd":rePwd,
                         @"source_type":[NSNumber numberWithInt:type]
    };
    [HttpTools postWithPath:API_COUSTOMER_REGISTER params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 获取短信验证码
/// @param phone <#phone description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getMsgCodeWithPhone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"mobile":phone};
    [HttpTools postWithPath:API_GET_MSG params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 忘记密码
/// @param phone <#phone description#>
/// @param code <#code description#>
/// @param pwd <#pwd description#>
/// @param rePwd <#rePwd description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)forgetWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd rePwd:(NSString *)rePwd success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"mobile":phone,
                         @"code":code,
                         @"password":pwd,
                         @"re_pwd":rePwd
    };
    [HttpTools postWithPath:API_FORGET_PWD params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
/// 忘记密码获取短信验证码
/// @param phone <#phone description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)getForMsgCodeWithPhone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"mobile":phone};
    [HttpTools postWithPath:API_GET_FOR_MSG params:dic loading:NO success:^(id  _Nonnull json) {
           success(json);
       } failure:^(NSError * _Nonnull error) {
           failed(error);
       }];
}
/// 第三方登录
/// @param openId <#openId description#>
/// @param Logintype <#Logintype description#>
/// @param nickName <#nickName description#>
/// @param avatar <#avatar description#>
/// @param sex <#sex description#>
/// @param type <#type description#>
/// @param success <#success description#>
/// @param failed <#failed description#>
+(void)thirdLoginWithOpenId:(NSString *)openId type:(int)Logintype nickName:(NSString *)nickName avatar:(NSString *)avatar sex:(NSString *)sex type:(int)type success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary * dic=@{@"openid":openId,
                         @"login_type":[NSNumber numberWithInt:Logintype],
                         @"nickname":nickName,
                         @"head_path":avatar,
                         @"sex":sex,
                         @"source_type":[NSNumber  numberWithInt:type]
    };
    NSLog(@"传入的参数==%@",dic);
    [HttpTools postWithPath:API_LOGIN_THIRD params:dic loading:NO success:^(id  _Nonnull json) {
        success(json);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}
@end
