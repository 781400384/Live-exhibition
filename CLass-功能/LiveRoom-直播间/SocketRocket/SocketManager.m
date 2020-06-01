//
//  SocketManager.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "SocketManager.h"
NSString*constkNeedPayOrderNote              =@"kNeedPayOrderNote";
NSString*constkWebSocketDidOpenNote          =@"kWebSocketDidOpenNote";
NSString*constkWebSocketDidCloseNote          =@"kWebSocketDidCloseNote";
NSString*constkWebSocketErrorNote             =@"kWebSocketErrorNote";
NSString*constkWebSocketdidReceiveMessageNote =@"kWebSocketdidReceiveMessageNote";

@interface SocketManager()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket     *     socket;

@end

@implementation SocketManager
{
    int _index;
    NSTimer* heartBeat;
    NSTimeInterval  reConnectTime;
}

+ (SocketManager*)shareSocketMangerWithUrl:(NSString*)url{
    SocketManager *socketManager = [[SocketManager alloc] init];
    socketManager.connectUrl= url;
    return socketManager;
}

-(void)openSocket{
    //如果是同一个url return
    if(self.socket) {
        return;
    }
    self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.connectUrl]]]];
    NSLog(@"请求的websocket地址：%@",self.socket.url.absoluteString);
    self.socket.delegate=self;
   [self.socket open];    //开始连接
}

-(void)reConnect{
    [self SRWebSocketClose];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        //您的网络状况不是很好，请检查网络后重试
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket=nil;
//        self.socket = [[SRWebSocket alloc] initWithURLRequest:
//                       [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?careId=%@&token=%@",self.connectUrl,self.careId,[MMDCommonUserModelinstance].accessToken]]]];
        self.socket.delegate=self;
        [self.socket open];    //开始连接
        NSLog(@"重连");
    });

    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    
}

}
-(void)SRWebSocketClose{
    if(self.socket){
        [self.socket close];
        self.socket=nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}

//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if(self->heartBeat) {
            if([self->heartBeat respondsToSelector:@selector(isValid)]){
                if([self->heartBeat isValid]){
                    [self->heartBeat invalidate];
                    self->heartBeat =nil;
                }
            }
        }
    })
}

- (void)sendData:(id)data {
    NSLog(@"socketSendData --------------- %@",data);
//    WS(weakSelf)
//    dispatch_queue_tqueue =  dispatch_queue_create("zy", NULL);
//    dispatch_async(queue, ^{
//        if(self.socket!=nil) {
//            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
//            if(weakSelf.socket.readyState==SR_OPEN) {
//                [weakSelf.socketsend:data];    // 发送数据
//            }elseif(weakSelf.socket.readyState==SR_CONNECTING) {
//                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
//
//                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
//                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
//                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
//                // 代码有点长，我就写个逻辑在这里好了
//                [self reConnect];
//            }else if(weakSelf.socket.readyState==SR_CLOSING|| weakSelf.socket.readyState==SR_CLOSED) {
//
//                // websocket 断开了，调用 reConnect 方法重连
//                NSLog(@"重连");
//                [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketErrorNote object:nil];
//                [self reConnect];
//            }
//        }else{
//            [self reConnect];
//            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
//            NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
//            [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketErrorNote object:nil];
//        }
//    });
//
}

#pragma mark - SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket*)webSocket {
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    //开启心跳
    //    [self initHeartBeat];
    if(webSocket ==self.socket) {
        NSLog(@"************************** socket 连接成功************************** ");
//        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidOpenNote object:nil];
    }
}

- (void)webSocket:(SRWebSocket*)webSocket didFailWithError:(NSError*)error {
    if(webSocket ==self.socket) {
        NSLog(@"************************** socket 连接失败************************** ");
        [self SRWebSocketClose];
        //连接失败就重连
        [self reConnect];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketErrorNote object:nil];
    }
}

- (void)webSocket:(SRWebSocket*)webSocket didCloseWithCode:(NSInteger)code reason:(NSString*)reason wasClean:(BOOL)wasClean {
    if(webSocket ==self.socket) {
        NSLog(@"************************** socket连接断开************************** ");
        NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
        [self SRWebSocketClose];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidCloseNote object:nil];
    }

}

/*该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */

-(void)webSocket:(SRWebSocket*)webSocket didReceivePong:(NSData*)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}

- (void)webSocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message  {
    if(webSocket ==self.socket) {
        NSLog(@"************************** socket收到数据了************************** ");
        NSLog(@"我这后台约定的 message 是 json 格式数据收到数据，就按格式解析吧，然后把数据发给调用层");
        NSLog(@"message:%@",message);
//        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketdidReceiveMessageNote object:[StringUtils dictionaryWithJSONString:message]];
    }
}
@end
