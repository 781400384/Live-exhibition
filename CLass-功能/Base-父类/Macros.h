//
//  Macros.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SMS_TIME_INTERVAL  60
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MaxContentWidth     SCREEN_WIDTH - 55 - 35
#define IS_X   SCREEN_HEIGHT>800

// 相对iphone6S 屏幕比
#define KScaleW [UIScreen mainScreen].bounds.size.width/375.0f
#define KScaleH  (IS_X?[UIScreen mainScreen].bounds.size.height/812.0f:[UIScreen mainScreen].bounds.size.height/667.0f)
#define ADAPTATIONRATIO     SCREEN_WIDTH / 750.0f

#define NAVI_HEIGHT             64
#define NAVI_HEIGHT_X           88
#define NAVI_SUBVIEW_Y_Normal   20
#define NAVI_SUBVIEW_Y_iphoneX  44
#define NAVI_BGCOLOR  RGB(255, 255, 255)
#define TABBAR_HEIGHT    49
#define TABBAR_HEIGHT_X  83

#define COLOR_999           [UIColor colorWithHexString:@"#999999"]
#define COLOR_333           [UIColor colorWithHexString:@"#333333"]
#define COLOR_f4            [UIColor colorWithHexString:@"#f4f4f4"]
#define APP_NAVI_COLOR      [UIColor colorWithHexString:@"#1B73F1"]
#define APP_MAIN_FONT       [UIFont systemFontOfSize:16.0]
#define APP_NORMAL_FONT(a)  [UIFont systemFontOfSize:a]
#define APP_BOLD_FONT(a)    [UIFont boldSystemFontOfSize:a]
#define RGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define GKColorGray(v)          RGB(v, v, v)



//#ifdef DEBUG
//    #define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//
//#else
//    #define NSLog(...) {}
//
//#endif


//微信参数
#define WX_APPID  @""
#define WX_SECRET  @""
#define TXlicenceURL @"https://license.vod2.myqcloud.com/license/v1/e697ff1df6fdfca4b2cbd17af9cd408a/TXUgcSDK.licence"
#define TXlicenceKey @"33c2667a1e8dbc43ec36aca29904dbda"
#define JMessageAppKey @"c549a33bc0045ef4dd6d9a10"//@"bead65f9f2a916c2c48b9f98"
#endif /* Macros_h */
