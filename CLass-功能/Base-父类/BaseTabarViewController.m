//
//  BaseTabarViewController.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseTabarViewController.h"
#import "MainBaseViewController.h"
#import "RecordBaseViewController.h"
#import "VideoPlayViewController.h"
#import "ChatListViewController.h"
#import "MineBaseViewController.h"
#import "LoginViewController.h"
#import "LoginViewController.h"
@interface BaseTabarViewController ()
@property (nonatomic,assign) NSInteger  indexFlag;　
@end

@implementation BaseTabarViewController

+(void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10*KScaleW];
    attrs[NSForegroundColorAttributeName] = COLOR_333;
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10*KScaleW];
    selectedAttrs[NSForegroundColorAttributeName] = APP_NAVI_COLOR;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat tabbar_height = IS_X ? TABBAR_HEIGHT_X : TABBAR_HEIGHT;
    UIView *TabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabbar_height)];
    TabBarView.backgroundColor = [UIColor whiteColor];

    [self.tabBar addSubview:TabBarView];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
  
  
  
    [self setUpAllChildVc];
}
- (void)setUpAllChildVc
{
    [self setupChildVc:[[MainBaseViewController alloc] init] title:@"首页" image:@"main_nor" selectedImage:@"main_sel"];
    [self setupChildVc:[[RecordBaseViewController alloc] init] title:@"回放" image:@"record_nor" selectedImage:@"record_sel"];
    [self setupChildVc:[[VideoPlayViewController alloc] init] title:@"视频" image:@"video_nor" selectedImage:@"video_sel"];
    [self setupChildVc:[[ChatListViewController alloc] init] title:@"消息" image:@"message_nor" selectedImage:@"messaged_sel"];
    [self setupChildVc:[[MineBaseViewController alloc] init] title:@"我的" image:@"mine_nor" selectedImage:@"mine_sel"];
}
/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.title = title;
    if (image || selectedImage) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        UIImage *selectImage = [UIImage imageNamed:selectedImage];
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    
   BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
   
    [self addChildViewController:nav];
}
#pragma mark  点击item
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
    
        //添加动画
        //放大效果，并回到原位
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.9];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.1];     //结束伸缩倍数
#pragma mark- 报错8
        [arry[index] addAnimation:animation forKey:nil];
        self.indexFlag = index;
    }
}

@end
