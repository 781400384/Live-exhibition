//
//  NewHttpTools.m
//  VideoLive
//
//  Created by 纪明 on 2020/2/27.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "NewHttpTools.h"

@implementation NewHttpTools
+(instancetype)shareManager{
    
    static NewHttpTools  *  manager=nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager
        =[[self alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    return manager;
}
-(instancetype)initWithBaseURL:(NSURL *)url{
    self=[super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.timeoutInterval=10;
        self.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Acceept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        self.securityPolicy.allowInvalidCertificates=YES;
    }
    return self;
}
-(void)requseetWithMethod:(HTTPMethod)method WithPath:(NSString *)path withParams:(NSDictionary *)params withSuccessBlock:(requestSuccessBlock)success withFailureBlock:(requestFailureBlock)failed{
    switch (method) {
        case GET:
        {
            [self GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed(error);
            }];
        }
            break;
        case POST:{
            [self POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed(error);
                
            }];
        }
            break;
        default:
            break;
    }
}
-(void)requseetWithMethod:(HTTPMethod)method WithPath:(NSString *)path withParams:(NSDictionary *)params image:(UIImage *)image thumbName:(NSString *)imageKey withSuccessBlock:(requestSuccessBlock)success withFailureBlock:(requestFailureBlock)failed{
    NSData  *  imageData= UIImagePNGRepresentation(image);
    NSDate *date = [NSDate date];
             NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
             [formatter setDateFormat:@"yyyyMMddHHmmss"];
             NSString *dateString = [formatter stringFromDate:date];
    
    [self POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFileData:imageData name:imageKey fileName:[NSString stringWithFormat:@"%@.png",dateString] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

@end
