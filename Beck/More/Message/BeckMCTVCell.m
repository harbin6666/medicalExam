//
//  BeckMCTVCell.m
//  Beck
//
//  Created by Aimy on 14/12/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckMCTVCell.h"

@interface BeckMCTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation BeckMCTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
