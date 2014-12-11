//
//  MessageCell.m
//  LYKJob
//
//  Created by Aimy on 14/12/7.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MessageCell.h"

@interface UIColor (lyk)

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB;

@end


@implementation UIColor (lyk)

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB
{
    return [UIColor colorWithRed:((float)((aRGB & 0xFF0000) >> 16))/255.0 green:((float)((aRGB & 0xFF00) >> 8))/255.0 blue:((float)(aRGB & 0xFF))/255.0 alpha:1.0];
}

@end

@interface MessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *processImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation MessageCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithInfos:(NSDictionary *)infos
{
    self.titleLabel.text = infos[@"user_dept_name"];
    self.positionLabel.text = infos[@"emplName"];
    
    NSString *date = infos[@"time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate = [dateFormatter dateFromString:date];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.dateFormat = @"yyyy-M-dd";
    self.timeLabel.text = [dateFormatter stringFromDate:destDate];
    
    self.processImageView.image = [UIImage imageNamed:@"jindu_a"];
    
    self.leftLabel.text = @"已投递";
    self.leftLabel.textColor = [UIColor whiteColor];
    self.middleLabel.text = @"未阅读";
    self.middleLabel.textColor = [UIColor colorWithRGB:0x144a69];
    self.rightLabel.text = @"无结果";
    self.rightLabel.textColor = [UIColor colorWithRGB:0x144a69];
    
    NSNumber *status = infos[@"status"];
    switch (status.integerValue) {
        case 1:
            
            break;
        case 2:
        {
            self.processImageView.image = [UIImage imageNamed:@"jindu_b"];
            self.leftLabel.text = @"未投递";
        }
            break ;
        case 3:
        {
            self.processImageView.image = [UIImage imageNamed:@"jindu_c"];
            self.middleLabel.text = @"已阅读";
            self.middleLabel.textColor = [UIColor whiteColor];
        }
            break ;
        case 4:
        {
            self.processImageView.image = [UIImage imageNamed:@"jindu_c"];
            self.middleLabel.text = @"已超时";
            self.middleLabel.textColor = [UIColor whiteColor];
        }
            break ;
        case 5:
        {
            self.processImageView.image = [UIImage imageNamed:@"jindu_d"];
            self.middleLabel.text = @"已阅读";
            self.rightLabel.text = @"已拒绝";
            self.middleLabel.textColor = [UIColor whiteColor];
            self.rightLabel.textColor = [UIColor whiteColor];
        }
            break ;
        case 6:
        {
            self.processImageView.image = [UIImage imageNamed:@"jindu_d"];
            self.middleLabel.text = @"已阅读";
            self.rightLabel.text = @"待面试";
            self.middleLabel.textColor = [UIColor whiteColor];
            self.rightLabel.textColor = [UIColor whiteColor];
        }
            break ;
        default:
            break;
    }
}

@end