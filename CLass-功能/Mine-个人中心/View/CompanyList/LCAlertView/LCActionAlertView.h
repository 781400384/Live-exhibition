//
//  LCActionAlertView.h
//  CustomActionAlertView
//
//  Created by 冀柳冲 on 2017/5/13.
//  Copyright © 2017年 JLC. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LCActionAlertView : NSObject

//+ (instancetype)shareInstance;


+ (void)showActionViewNames:(NSArray *)names completed:(void(^)(NSInteger index,NSString *handleName))completed canceled:(void(^)())canceled;



@end
