//
//  BannerListModel.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerListModel : NSObject
@property (nonatomic, copy) NSString     *    slider_id; //ID
@property (nonatomic, copy) NSString     *    thumb;//URL
@property (nonatomic, copy) NSString     *    slider_type;//轮播图分类 0-直播 1-直播回放 2-短视频 3-直播预告\展会详情页 4-企业主页 5-网页url

@property (nonatomic, copy) NSString     *    value;//轮播图跳转页面请求ID
@end

NS_ASSUME_NONNULL_END
