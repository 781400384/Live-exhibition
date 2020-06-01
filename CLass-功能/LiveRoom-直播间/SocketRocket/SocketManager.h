//
//  SocketManager.h
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>
NS_ASSUME_NONNULL_BEGIN

extern NSString*constkNeedPayOrderNote;

extern NSString*constkWebSocketDidOpenNote;

extern NSString*constkWebSocketDidCloseNote;

extern NSString*constkWebSocketdidReceiveMessageNote;

extern NSString*constkWebSocketErrorNote;

@interface SocketManager :NSObject

@property (nonatomic,copy) NSString *connectUrl;

+ (SocketManager *)shareSocketMangerWithUrl:(NSString*)url;

-(void)SRWebSocketClose;//关闭连接

- (void)sendData:(id)data;//发送数据

-(void)openSocket;

@end

NS_ASSUME_NONNULL_END
