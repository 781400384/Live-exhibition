//
//  NewHttpTools.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/27.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef void (^requestSuccessBlock)(NSDictionary * dic);
typedef void (^requestFailureBlock)(NSError * error);

typedef enum{
    GET,
    POST,
    DELETE,
    PUT,
    HEAD
}HTTPMethod;
NS_ASSUME_NONNULL_BEGIN

@interface NewHttpTools : AFHTTPSessionManager
+(instancetype)shareManager;
-(void)requseetWithMethod:(HTTPMethod)method WithPath:(NSString *)path withParams:(NSDictionary *)params withSuccessBlock:(requestSuccessBlock)success withFailureBlock:(requestFailureBlock)failed;

-(void)requseetWithMethod:(HTTPMethod)method WithPath:(NSString *)path withParams:(NSDictionary *)params image:(UIImage *)image thumbName:(NSString *)imageKey   withSuccessBlock:(requestSuccessBlock)success withFailureBlock:(requestFailureBlock)failed;
@end

NS_ASSUME_NONNULL_END
