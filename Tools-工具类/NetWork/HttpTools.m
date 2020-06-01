//
//  HttpTools.m
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#import "HttpTools.h"
#import "AFNetworking/AFNetworking.h"
#import <Reachability/Reachability.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface AFHttpClient:AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
@implementation AFHttpClient
+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURL] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 10;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end

@implementation HttpTools
+(void)getWitPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    //判断网络状态
 
    
    if (![self requestBeforeJudgeConnect]) {

        
        return;
    }
    NSDictionary *requestParams;
    
    if (params==nil) {
        requestParams = nil;
    }else{
        requestParams = params;
    }
    
    
    //获取完整的url路径
    NSString * url = [BaseURL stringByAppendingPathComponent:path];
    
    
    [[AFHttpClient sharedClient]  GET:url parameters:requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            

            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
            success(responseObject);
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{

            failure(error);
          
            
        });
        
    }];
    
}

#pragma mark - 网络判断
+(BOOL)requestBeforeJudgeConnect
{
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        //printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params responseCache:(HttpResponseCacheBlock)cache success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
     NSString * url = [BaseURL stringByAppendingPathComponent:path];
    
    //先判断是否有缓存
    YYCache *yyCache = [[YYCache alloc]initWithName:NET_CACHE];
    yyCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    yyCache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id cacheData = [yyCache objectForKey:url];
    if (cacheData) {
        
        id myResult = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        cache(myResult);
    }
    
    //判断网络状态
    if (![self requestBeforeJudgeConnect]) {
    
        return;
    }
    
    NSDictionary *requestParams;
    
    if (params==nil) {
        requestParams = nil;
    }else{
        requestParams = params;
    }

    [[AFHttpClient sharedClient]GET:path parameters:requestParams progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        });
        
        
        NSString * dataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        dataString = [self deleteSpecialCodeWithStr:dataString];
        NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        [yyCache setObject:requestData forKey:url];
        
        id result = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
            
        });
        failure(error);
        
        
    }];
}
+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             loading:(BOOL)loading
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure {
    //判断网络状态
    if (![self requestBeforeJudgeConnect]) {

        
        return;
    }
    
    if (loading) {
      
        
    }
    
    //获取完整的url路径
    NSString * url = [BaseURL stringByAppendingPathComponent:path];
    
    
    NSDictionary *requestParams;
    
    if (params==nil) {
        requestParams = nil;
    }else{
        requestParams = params;
    }
    [[AFHttpClient sharedClient] POST:url parameters:requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
        });
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *errorString = error.localizedDescription;
        NSLog(@"error string = %@",errorString);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
            
         
        });
        
        
        
        
        
        
        
        
    }];
    
}
+ (void)postWithPath:(NSString *)path judgeKey:(NSString *)judgeKey params:(NSDictionary *)params page:(int)page responseCache:(HttpResponseCacheBlock)cache success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
  
    
    
    NSString * url = [BaseURL stringByAppendingPathComponent:path];
    
    
    NSString *key = [path stringByAppendingString:judgeKey];
    //先判断是否有缓存
    YYCache *yyCache = [[YYCache alloc]initWithName:NET_CACHE];
    yyCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    yyCache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id cacheData = [yyCache objectForKey:key];
    if (cacheData) {
        
        id myResult = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        cache(myResult);
    }
    
    //判断网络状态
    if (![self requestBeforeJudgeConnect]) {

        return;
    }
    
    
    
    NSDictionary *requestParams;
    
    if (params==nil) {
        requestParams = nil;
    }else{
        requestParams = params;
    }
    [[AFHttpClient sharedClient]POST:url parameters:requestParams progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
            
        });
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
            
        });
        NSLog(@"response with cache error = %@",error.localizedDescription);
        failure(error);
    }];
}
+ (void)downloadWitPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [BaseURL stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}

+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                     images:(UIImage *)images
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    NSString * urlString = [BaseURL stringByAppendingPathComponent:path];
    
//    单张图片上传
        NSData * data = UIImagePNGRepresentation(images);
//    [[AFHttpClient sharedClient].requestSerializer setValue:[WDUserInfoDefaults
//                                                             userInfo].toKen forHTTPHeaderField:@"toKen"];
        [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:date];
            [formData appendPartWithFileData:data name:imagekey fileName:[NSString stringWithFormat:@"%@.png",dateString] mimeType:@"image/png"];
    
        } progress:^(NSProgress * _Nonnull uploadProgress) {
    
            progress(uploadProgress.fractionCompleted);
    
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            NSLog(@"upload file = %@",responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
    
            });
    
            success(responseObject);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
            NSString *errorString = error.localizedDescription;
            NSLog(@"error string = %@",errorString);
    
            dispatch_async(dispatch_get_main_queue(), ^{
            });
            failure(error);
    
        }];
}
+(void) uploadWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)imagekey images:(NSArray *)images success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress{
    //获取完整的url路径（多张图片上传）
    NSString * urlString = [BaseURL stringByAppendingPathComponent:path];
    NSData *cutdownData = nil;
        for (int i=0; i<images.count; i++) {
            UIImage * image=images[i];
            NSData * data =UIImageJPEGRepresentation(image, 1);
            if (data.length < 9999) {
                cutdownData = UIImageJPEGRepresentation(image, 1.0);
            } else if (data.length < 99999) {
                cutdownData = UIImageJPEGRepresentation(image, 0.6);
            } else {
                cutdownData = UIImageJPEGRepresentation(image, 0.3);
            }
            [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *dateString = [formatter stringFromDate:date];
                [formData appendPartWithFileData:cutdownData name:imagekey fileName:[NSString stringWithFormat:@"%@%d.png",dateString,i+1] mimeType:@"image/png"];
    
            } progress:^(NSProgress * _Nonnull uploadProgress) {
    
                progress(uploadProgress.fractionCompleted);
    
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
                NSLog(@"upload file = %@",responseObject);
                dispatch_async(dispatch_get_main_queue(), ^{
                });
    
                success(responseObject);
    
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
                NSString *errorString = error.localizedDescription;
                NSLog(@"error string = %@",errorString);
    
                dispatch_async(dispatch_get_main_queue(), ^{
                });
                failure(error);
    
            }];
        }
    
   
    
}
#pragma mark - 处理json格式的字符串中的换行符、回车符
+ (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

+ (NSString *)getNetconnType{
    
    NSString *netconnType = @"";
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            
            netconnType = @"no network";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"wifi";
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = @"gprs";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = @"3g";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = @"2g";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = @"3g";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = @"3g";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = @"3g";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = @"4g";
            }
        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
}

+ (NSString *)jsonStringFromDictionary:(id)dic {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
    }
    return dic;
}

@end

