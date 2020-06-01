//
//  BaseHandle.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/**
 *  处理完成事件
 */
typedef void(^CompleteBlock)(id obj);

/**
 *  处理事件成功
 *
 *  @param obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);

/**
 *  处理事件失败
 *
 *  @param obj 错误信息
 */

typedef void(^FailedBlock)(id obj);


@interface BaseHandle : NSObject

@end

NS_ASSUME_NONNULL_END
