//
//  BeautyViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/2/24.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^beautyPraBlock)(NSString  *beauty);
NS_ASSUME_NONNULL_BEGIN

@interface BeautyViewController : BaseViewController
@property(nonatomic, copy) beautyPraBlock returnValueBlock;
@end

NS_ASSUME_NONNULL_END
