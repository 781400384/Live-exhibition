//
//  UIImage+HWExt.m
//  HomeWorld
//
//  Created by ZJQian on 2017/6/28.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "UIImage+HWExt.h"

@implementation UIImage (HWExt)


- (UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
