//
//  LandScreenTool.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LandScreenTool : NSObject
/**
 *  切换横竖屏
 *
 *  @param orientation ：UIInterfaceOrientation
 */
+ (void)forceOrientation: (UIInterfaceOrientation)orientation;

/**
 *  判断是否竖屏
 *
 *  @return 布尔值
 */
+ (BOOL)isOrientationLandscape;
@end

NS_ASSUME_NONNULL_END
