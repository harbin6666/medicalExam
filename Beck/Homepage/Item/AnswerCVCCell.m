//
//  AnswerCVCCell.m
//  Beck
//
//  Created by Aimy on 14/12/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "AnswerCVCCell.h"

@interface AnswerCVCCell ()

@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AnswerCVCCell

- (void)updateWithIndex:(NSInteger)aIndex
{
    self.countLbl.backgroundColor = [UIColor colorWithRed:0.898f green:0.898f blue:0.898f alpha:1.00f];
    self.countLbl.text = @(aIndex + 1).stringValue;
}

- (void)updateWithItemVO:(ItemVO *)aVO andIndex:(NSInteger)aIndex
{
    if (aVO.userAnswers.count) {
        if (aVO.isRight) {
            self.countLbl.backgroundColor = [UIColor colorWithRed:0.400f green:0.906f blue:0.616f alpha:1.00f];
            self.imageView.image = [UIImage imageNamed:@"dui"];
        }
        else {
            self.countLbl.backgroundColor = [UIColor colorWithRed:0.992f green:0.616f blue:0.620f alpha:1.00f];
            self.imageView.image = [UIImage imageNamed:@"cuo"];
        }
    }
    else {
        self.countLbl.backgroundColor = [UIColor colorWithRed:0.898f green:0.898f blue:0.898f alpha:1.00f];
    }
    
    self.countLbl.text = @(aIndex + 1).stringValue;
}

@end
