//
//  CompatibilityItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemVO.h"

@implementation CompatibilityItemVO

- (void)setAnswer:(NSString *)answer andIndex:(NSInteger)index
{
    if ([self.userAnswers containsObject:self.itemAnswers[index]]) {
        [self.userAnswers removeObject:self.itemAnswers[index]];
    }
    else {
        [self.userAnswers addObject:self.itemAnswers[index]];
    }
}

@end
