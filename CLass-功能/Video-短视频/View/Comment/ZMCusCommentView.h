//
//  ZMCusCommentView.h
//  ZM
//
//  Created by Kennith.Zeng on 2018/8/29.
//  Copyright © 2018年 Kennith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCusCommentView : UIView
@property (nonatomic, copy) NSString   *  videoId;
- (void)showViewWithVideoId:(int)vidoId;
@end

//@interface ZMCusCommentManager : NSObject
//+ (instancetype)shareManager;
//- (void)showCommentWithSourceId:(NSString *)sourceId;
//@end
