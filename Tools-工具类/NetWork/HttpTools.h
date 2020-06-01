//
//  HttpTools.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^HttpResponseCacheBlock)(id json);
typedef void (^HttpSuccessBlock)(id json);
typedef void (^HttpFailureBlock)(NSError * error);
typedef void (^HttpDownloadProgressBlock)(CGFloat progress);
typedef void (^HttpUploadProgressBlock)(CGFloat progress);
@interface HttpTools : NSObject
/**
 *  get网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;






/**
 带缓存的get 网络请求
 
 @param path  url地址
 @param params 参数
 @param cache 缓存回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
      responseCache:(HttpResponseCacheBlock)cache
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;


/**
 *  post网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param loading 是否显示加载hud
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             loading:(BOOL)loading
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;







/**
 带缓存的 post 网络请求
 
 @param path  url 地址
 @param params 参数
 @param cache 缓存回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)postWithPath:(NSString *)path
            judgeKey:(NSString *)judgeKey
              params:(NSDictionary *)params
                page:(int)page
       responseCache:(HttpResponseCacheBlock)cache
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;


/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */

+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress;



/**
 上传图片

 @param path 图片URL
 @param params 参数
 @param imagekey <#imagekey description#>
 @param images 图片
 @param success 成功
 @param failure 失败
 @param progress 进度
 */
+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                     images:(UIImage *)images
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress;

/**
 多张图片上传

 @param path <#path description#>
 @param params <#params description#>
 @param imagekey <#imagekey description#>
 @param images <#images description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @param progress <#progress description#>
 */
+ (void)uploadWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                     images:(NSArray *)images
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress;

+ (NSDictionary *)requestHeader;
+ (NSString *)jsonStringFromDictionary:(id)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
