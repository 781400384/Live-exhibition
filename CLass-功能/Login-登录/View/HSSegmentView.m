//
//  HSSegmentView.m
//  LOL
//
//  Created by Kean on 16/7/3.
//  Copyright © 2016年 Kean. All rights reserved.
//

#import "HSSegmentView.h"

@interface HSSegmentView ()

@property (nonatomic, strong) NSArray *buttonName;
@property (nonatomic, strong) UILabel *underLine;
@property (nonatomic, strong) UILabel *downLine;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIScrollView *segmentScrollV;

@end

@implementation HSSegmentView

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSArray *)buttonName contrllers:(NSArray *)contrllers parentController:(UIViewController *)parentC {
    
    if (self = [super initWithFrame:frame]) {
        
        self.buttonName = buttonName;
        self.controllers = contrllers;
        
        // 创建segementView
        
        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48*KScaleW)];
        self.segmentView.tag = 50;
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
        
        
        //  创建segmentScrollV
        
        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48*KScaleW, SCREEN_WIDTH, frame.size.height - 48*KScaleW)];
        self.segmentScrollV.contentSize = CGSizeMake(SCREEN_WIDTH * self.controllers.count, 0);
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = YES;
        self.segmentScrollV.delegate = self;
        [self addSubview:self.segmentScrollV];
        
        // 创建ViewController并添加到segmentScrollV
        
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIViewController *contro = self.controllers[i];
            contro.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.segmentScrollV.height);
            [self.segmentScrollV addSubview:contro.view];
            [parentC addChildViewController:contro];
            [contro didMoveToParentViewController:parentC];
            
        }
        
        
        // 创建segmentButton 和 line
        
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * (SCREEN_WIDTH / self.controllers.count), 0, SCREEN_WIDTH / self.controllers.count, 48*KScaleW);
            button.tag = i;
            [button setTitle:self.buttonName[i] forState:UIControlStateNormal];
            [button setTitleColor:COLOR_999 forState:UIControlStateNormal];
            [button setTitleColor:COLOR_333 forState:UIControlStateSelected];
            [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:19.0];
            if (i == self.num) {
                
                button.selected = YES;
                self.selectButton = button;
            }
            else {
            
                button.selected = NO;
                
            }
            
            [self.segmentView addSubview:button];
        }
        
        // 添加下划线
        self.underLine = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH / self.controllers.count-57.5*KScaleW)/2, 46*KScaleW, 57.5*KScaleW, 2)];
        
        self.underLine.backgroundColor = APP_NAVI_COLOR;
        self.underLine.tag = 70;
        [self.segmentView addSubview:self.underLine];
        
//        self.downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 48.5*KScaleW, SCREEN_WIDTH, 0.5*KScaleW)];
//        self.downLine.backgroundColor = COLOR_999;
//        [self.segmentView addSubview:self.downLine];
        
    }

    return self;
}

- (void)Click:(UIButton *)sender {
  
    self.selectButton.selected = NO;
    self.selectButton = sender;
    self.selectButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
       
        CGRect frame = self.underLine.frame;
        frame.origin.x = (SCREEN_WIDTH/self.controllers.count)*sender.tag + (SCREEN_WIDTH / self.controllers.count-57.5*KScaleW)/2;
        self.underLine.frame = frame;
        
    }];
    
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag) * SCREEN_WIDTH, 0) animated:YES];



}

#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [UIView animateWithDuration:0.2 animations:^{
        
        
        CGRect frame = self.underLine.frame;
        frame.origin.x = (SCREEN_WIDTH/self.controllers.count)*(self.segmentScrollV.contentOffset.x/SCREEN_WIDTH) + (SCREEN_WIDTH / self.controllers.count-57.5*KScaleW)/2;
        self.underLine.frame = frame;
    }];
    
    UIButton *button = (UIButton *)[self.segmentView viewWithTag:self.segmentScrollV.contentOffset.x / SCREEN_WIDTH];
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;

}

@end
