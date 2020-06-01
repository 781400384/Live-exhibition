//
//  NSString+HWExt.m
//  HomeWorld
//
//  Created by ZJQ on 2017/5/16.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "NSString+HWExt.h"

@implementation NSString (HWExt)


- (BOOL)isEmpty {

    if (self == nil ||
        [self isEqual: @""]) {
        
        return YES;
    }
    return NO;
}


- (BOOL)validPhoneNumber {

    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)validIdentificationNumber {

 
    if (self.length != 18){

        return NO;
    }
//
//
//    // 正则表达式判断基本 身份证号是否满足格式
//    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
//    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
//    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//
//    //如果通过该验证，说明身份证格式正确，但准确性还需计算
//    if(![identityStringPredicate evaluateWithObject:self]){
//
//        return NO;
//    }
//
//    //** 开始进行校验 *//
//
//    //将前17位加权因子保存在数组里
//    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
//
//    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
//    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
//
//    //用来保存前17位各自乘以加权因子后的总和
//    NSInteger idCardWiSum = 0;
//    for(int i = 0;i < 17;i++) {
//        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
//        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
//        idCardWiSum+= subStrIndex * idCardWiIndex;
//    }
//
//    //计算出校验码所在数组的位置
//    NSInteger idCardMod=idCardWiSum%11;
//    //得到最后一位身份证号码
//    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
//    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
//    if(idCardMod==2) {
//
//        if(!([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])) {
//            return NO;
//        }
//    }
//    else{
//        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
//            return NO;
//        }
//    }
//    return YES;
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i <18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @"2"];
    // 余数数组
    NSArray *remainderArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i <17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [self substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    return [str isEqualToString:string];
   
}

-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"^[0-9A-Za-z]{6,16}$";
    //NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[/w]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO ;
    }
    if ([self hasPrefix:@"_"]) {
        return NO;
    }
    
    return YES;
}
-(BOOL)judgePassWordLegal{
   
     //6-20位字母和数字组成 
    NSString *regex = @"^[0-9A-Za-z]{5,8}$";
    //NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[/w]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO ;
    }
    if ([self hasPrefix:@"_"]) {
        return NO;
    }
    
    return YES;
}
-(BOOL )isValidateEmail

{
    
    NSString  *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" ;
    
    NSPredicate  * emailTest = [ NSPredicate   predicateWithFormat : @"SELF MATCHES%@",emailRegex];
    if(![emailTest evaluateWithObject:self]){
        
        return NO;
    }
    return  YES;
    
}
//确定高度的设置
+(CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

@end
