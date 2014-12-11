//
//  MonthCell.m
//  LYKJob
//
//  Created by Aimy on 14/11/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MonthCell.h"

@interface MonthCell ()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (nonatomic, strong) NSDictionary *infos;

@end

@implementation MonthCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)valueChanged:(UIStepper *)sender {
    self.monthLabel.text = [NSString stringWithFormat:@"%d个月",(int)sender.value];
}

- (void)updateWithInfos:(NSDictionary *)infos
{
    self.stepper.value = [infos[@"triLength"] floatValue];
    self.monthLabel.text = [NSString stringWithFormat:@"%d个月",(int)self.stepper.value];
}

@end
