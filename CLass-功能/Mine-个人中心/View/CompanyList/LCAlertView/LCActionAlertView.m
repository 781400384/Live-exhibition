//
//  LCActionAlertView.m
//  CustomActionAlertView
//
//  Created by 冀柳冲 on 2017/5/13.
//  Copyright © 2017年 JLC. All rights reserved.
//

#import "LCActionAlertView.h"
#import "LCActionCell.h"


@interface LCActionAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIControl * coverView;

@property(nonatomic,strong) UITableView * mainView;

@property(nonatomic,strong) NSArray * handleNames;

@property (nonatomic, assign,getter= isShow) BOOL show;

@property(nonatomic,copy)  void(^completedBlock)(NSInteger index,NSString *handleName);

@property(nonatomic,copy)  void(^canceledBlock)();


@end


@implementation LCActionAlertView


+(instancetype)shareInstance{
    static LCActionAlertView *Alert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Alert = [[LCActionAlertView alloc]init];
    });
    return Alert;
}

+ (void)showActionViewNames:(NSArray *)names completed:(void(^)(NSInteger index,NSString *handleName))completed canceled:(void(^)())canceled{
    if (!names || !names.count) return;
    LCActionAlertView *alert = [LCActionAlertView shareInstance];
    alert.handleNames = names;
    alert.completedBlock = completed;
    alert.canceledBlock = canceled;
    if (alert.isShow) return;
    alert.show = YES;
    UIControl   *coverView        = alert.coverView;
    UITableView *mainView              = alert.mainView;
    UIWindow *keyWindow       = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:coverView];
    [UIView animateWithDuration:0.25 animations:^{
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        mainView.frame = CGRectMake(0, UIScreenHeight - 50*(names.count+1)-5, UIScreenWidth, 50*(names.count+1)+5);
    }];
    
}




#pragma mark- table


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.handleNames.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lCActionCell"];
    cell.handelName = self.handleNames[indexPath.row];
    if (indexPath.section == 1) {
        cell.handelName = @"取消";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row <= self.handleNames.count - 1) {
        if (self.completedBlock) {
            self.completedBlock(indexPath.row,self.handleNames[indexPath.row]);
        }
    }else{
        if (self.canceledBlock) {
            self.canceledBlock();
        }
    }
    [self removeMain];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return 5.f;
    }
    return 0.00001;
}



- (void)removeMain
{
    UIControl *control                             = [LCActionAlertView shareInstance].coverView;
    [UIView animateWithDuration:0.15 animations:^{
        self.mainView.frame                        = CGRectMake(0, UIScreenHeight, UIScreenWidth, 155);
        self.coverView.backgroundColor             = [UIColor colorWithWhite:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [control removeFromSuperview];
        [LCActionAlertView shareInstance].coverView = nil;
        [LCActionAlertView shareInstance].mainView  = nil;
        [LCActionAlertView shareInstance].show      = NO;
    }];
}







#pragma mark - lazy load

- (UIControl *)coverView
{
    if (!_coverView) {
        _coverView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [_coverView addTarget:self action:@selector(removeMain) forControlEvents:UIControlEventTouchUpInside];
        [_coverView addSubview:self.mainView];
    }
    return _coverView;
}

- (UITableView *)mainView
{
    if (!_mainView) {
        _mainView = [[UITableView alloc]initWithFrame:CGRectMake(0, UIScreenHeight,UIScreenWidth,UIScreenHeight) style:UITableViewStylePlain];
        _mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainView.separatorInset = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.rowHeight = 50;
        _mainView.scrollEnabled = NO;
        [_mainView registerClass:[LCActionCell class] forCellReuseIdentifier:@"lCActionCell"];
    }
    return _mainView;
}



@end
