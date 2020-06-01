//
//  VideoLiveTextView.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoLiveTextView : UITextView
@property (nonatomic,copy)NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic,assign)BOOL isAutoHeight;
@end

NS_ASSUME_NONNULL_END
