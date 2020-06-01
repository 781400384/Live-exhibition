//
//  NSString+HWExt.h
//  HomeWorld
//
//  Created by ZJQ on 2017/5/16.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (HWExt)


+(CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 判断是否为空

 @return <#return value description#>
 */
- (BOOL)isEmpty;



/**
 判断是否是有效的手机号码

 @return <#return value description#>
 */
- (BOOL)validPhoneNumber;



/**
 判断是否是有效的身份证号码

 @return <#return value description#>
 */
- (BOOL)validIdentificationNumber;



/**
 判断是否是6-20位数字+字母的密码组合

 @return <#return value description#>
 */
-(BOOL)checkPassWord;

-(BOOL )isValidateEmail;
-(BOOL)judgePassWordLegal;

@end
