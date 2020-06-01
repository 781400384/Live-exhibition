//
//  UserInfoModel.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/14.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super init];
    if (self) {
        
        self.head_path = [aDecoder decodeObjectForKey:@"head_path"];
        self.level = [aDecoder decodeObjectForKey:@"level"];
        self.level_path=[aDecoder decodeObjectForKey:@"level_path"];
        self.mobile=[aDecoder decodeObjectForKey:@"mobile"];
        self.nickname=[aDecoder decodeObjectForKey:@"nickname"];
        self.sex=[aDecoder decodeObjectForKey:@"sex"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.user_login=[aDecoder decodeObjectForKey:@"user_login"];
        self.user_sign=[aDecoder decodeObjectForKey:@"user_sign"];
        self.user_type=[aDecoder decodeObjectForKey:@"user_type"];
        self.rongToken=[aDecoder decodeObjectForKey:@"rongToken"];
        self.birthday=[aDecoder decodeObjectForKey:@"birthday"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
   
    [aCoder encodeObject:self.head_path forKey:@"head_path"];
    [aCoder encodeObject:self.level forKey:@"level"];
    [aCoder encodeObject:self.level_path forKey:@"level_path"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.user_login forKey:@"user_login"];
    [aCoder encodeObject:self.user_sign forKey:@"user_sign"];
    [aCoder encodeObject:self.user_type forKey:@"user_type"];
    [aCoder encodeObject:self.rongToken forKey:@"rongToken"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
   

}

@end
