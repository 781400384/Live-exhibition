//
//  UILabelSet.m
//  PlayFootBall
//
//  Created by 纪明 on 2019/12/14.
//  Copyright © 2019 纪明. All rights reserved.
//

#import "UILabelSet.h"

@implementation UILabelSet

//- (id)initWithFrame:(CGRect)frame {
//
//    return self;
//
//}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {

    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];

    textRect.origin.y= bounds.origin.y;

    return textRect;

}

-(void)drawTextInRect:(CGRect)requestedRect {

    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];

    [super drawTextInRect:actualRect];

}



@end
