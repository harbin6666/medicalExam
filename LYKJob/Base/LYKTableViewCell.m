//
//  LYKTableViewCell.m
//  LYKJob
//
//  Created by Aimy on 14/12/3.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "LYKTableViewCell.h"

@implementation LYKTableViewCell

+ (NSString *)cellId
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
