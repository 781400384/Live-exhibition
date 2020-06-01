//
//  RecordVideoPlayViewController.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/9.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordVideoPlayViewController : BaseViewController
@property (nonatomic, copy) NSString   *  recordId;
@property (nonatomic, copy) NSString   *  type;//0-直播回放,1-视频播放
//@property (nonatomic, copy) NSString   *  imageUrl;
//@property (nonatomic, copy) NSString   *  startTime;
//@property (nonatomic, copy) NSString   *  endTime;
//@property (nonatomic, copy) NSString   *  nickName;
//@property (nonatomic, copy) NSString   *  UId;
//@property (nonatomic, copy) NSString   *  avatarURL;
@end

NS_ASSUME_NONNULL_END
