//
//  ChatListViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/19.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ChatListViewController.h"
#import "MessageTableViewCell.h"
#import "LoginViewController.h"
#import "ChatViewController.h"
@interface ChatListViewController ()<RCIMUserInfoDataSource,RCIMConnectionStatusDelegate>

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UserInfoDefaults isLogin]) {
        [self configUI];
    }else{
        [self goLogin];
    }
    
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    ChatViewController    *   chat=[[ChatViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:model.targetId];
    chat.conversationType =model.conversationType;
    chat.title=model.conversationTitle;

    [self.navigationController pushViewController:chat animated:YES];
   
}
-(void)configUI{
    NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:ConversationType_PRIVATE]];
        [self setDisplayConversationTypes:array];
        [self setCollectionConversationType:nil];
        self.isEnteredToCollectionViewController=YES;
        CGFloat height=IS_X?NAVI_HEIGHT_X:NAVI_HEIGHT;
        CGFloat tabbar=IS_X?TABBAR_HEIGHT_X:TABBAR_HEIGHT;
        self.conversationListTableView.frame=CGRectMake(0, IS_X?NAVI_HEIGHT_X:NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-tabbar-height);
        self.view.backgroundColor=[UIColor whiteColor];
        self.navigationController.navigationBar.hidden=NO;
        [RCIM sharedRCIM].userInfoDataSource=self;
        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    //    [RCIM sharedRCIM].currentUserInfo=
        [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
        [RCIM sharedRCIM].globalConversationAvatarStyle=RC_USER_AVATAR_CYCLE;
        
        NSLog(@"array==%@",self.conversationListDataSource);
}
-(void)goLogin{
    LoginViewController   *  vc=[[ LoginViewController alloc]init];
       __weak __typeof(self)weakSelf = self;
    [self.navigationController pushViewController:vc animated:NO];
    vc.loginSuccessBlock = ^{
        [self.navigationController popViewControllerAnimated:YES ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

           [weakSelf configUI];
           

        });
    };
}
@end
