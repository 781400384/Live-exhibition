//
//  LCActionCell.m
//  CustomActionAlertView
//
//  Created by 冀柳冲 on 2017/5/13.
//  Copyright © 2017年 JLC. All rights reserved.
//

#import "LCActionCell.h"

@implementation LCActionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:15.f weight:0.5];
    }
    return self;
}

- (void)setHandelName:(NSString *)handelName{
    _handelName = handelName;
    self.textLabel.text = handelName;
    
}



@end
