//
//  VideoLiveTextView.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/10.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VideoLiveTextView.h"
@interface VideoLiveTextView()
@property (nonatomic,weak) UILabel *placehoderLabel;
@end
@implementation VideoLiveTextView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
   
        UILabel *placehoderLabel = [[UILabel alloc]init];
        placehoderLabel.numberOfLines = 0;
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        self.placehoderColor = COLOR_999;
        self.font = [UIFont systemFontOfSize:16.0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)textDidChange{
    
    self.placehoderLabel.hidden = self.text.length != 0;
    
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setIsAutoHeight:(BOOL)isAutoHeight{
    _isAutoHeight = isAutoHeight;
    [self setNeedsLayout];
}

- (void)setPlacehoder:(NSString *)placehoder{
    
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
   
    [super layoutSubviews];
    CGSize maxSize = CGSizeMake(self.placehoderLabel.frame.size.width-10, MAXFLOAT);
    CGRect LabelFrame = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.placehoderLabel.font,NSFontAttributeName, nil] context:nil];
    self.placehoderLabel.frame = CGRectMake(5, 8, self.frame.size.width - 10, LabelFrame.size.height);
    
    CGRect textFrame = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width-10,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];

    
    if (textFrame.size.height > self.frame.size.height && self.isAutoHeight) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, textFrame.size.height);
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


@end
