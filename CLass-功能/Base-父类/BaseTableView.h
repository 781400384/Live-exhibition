//
//  BaseTableView.h
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshBlock)();
@protocol BaseTableViewDelegate <NSObject>


/**
 点击空数据区域刷新
 */
- (void)tapEmptyForRefresh;

@end
@interface BaseTableView : UITableView
@property (nonatomic, assign) BOOL        shouldAddRefresh;


@property (nonatomic, copy) RefreshBlock        headerRefreshBlock;
@property (nonatomic, copy) RefreshBlock        footerRefreshBlock;

@property (nonatomic, copy) NSString         *           emptyString;

@property (nonatomic, strong)UIImage * emptyImage;
@property (nonatomic, assign) id<BaseTableViewDelegate>  emptyDelegate;

/**
 是否添加下拉刷新
 
 @param add <#add description#>
 */
- (void)shouldAddHeaderRefresh:(BOOL)add;


/**
 是否添加上拉加载
 
 @param add <#add description#>
 */
- (void)shouldAddFooterRefresh:(BOOL)add;


/**
 结束刷新
 */
- (void)endRefreshing;

- (void)setEmptyData;
@end

NS_ASSUME_NONNULL_END
