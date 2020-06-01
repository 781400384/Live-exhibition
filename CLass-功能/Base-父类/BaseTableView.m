//
//  BaseTableView.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/7.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "BaseTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface BaseTableView()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>


@end
@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

- (void)shouldAddHeaderRefresh:(BOOL)add {
    
    if (add) {
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.headerRefreshBlock();
        }];
        self.mj_header = header;
    }else{
        
        self.mj_header = nil;
    }
}

- (void)shouldAddFooterRefresh:(BOOL)add {
    
    if (add) {
        
        
        MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            
            self.footerRefreshBlock();
        }];
        self.mj_footer = footer;
    }else{
        
        self.mj_footer = nil;
    }
}

- (void)endRefreshing {
    
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)setEmptyString:(NSString *)emptyString {
    
    _emptyString = emptyString;
}
- (void)setEmptyImage:(UIImage *)emptyImage {
    _emptyImage = emptyImage;
}
- (void)setEmptyData {
    
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.emptyString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*KScaleW]}];
    return string;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    //    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"no_data" ofType:@"png"]];
    return self.emptyImage;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    // Do something
    
    if (self.emptyDelegate && [self.emptyDelegate respondsToSelector:@selector(tapEmptyForRefresh)]) {
        [self.emptyDelegate tapEmptyForRefresh];
    }
    
}


@end
