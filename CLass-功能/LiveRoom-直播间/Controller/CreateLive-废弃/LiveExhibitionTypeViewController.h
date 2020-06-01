//
//  LiveExhibitionTypeViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/20.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^ReturnValueBlock) (NSString * passedValue,NSString   *   typeId);
NS_ASSUME_NONNULL_BEGIN

@interface LiveExhibitionTypeViewController : BaseViewController
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@end

NS_ASSUME_NONNULL_END
