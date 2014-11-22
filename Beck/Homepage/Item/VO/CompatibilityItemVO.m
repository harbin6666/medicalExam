//
//  CompatibilityItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemVO.h"

@implementation CompatibilityItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    if ([self.userAnswers containsObject:answer]) {
        [self.userAnswers removeObject:answer];
    }
    else {
        [self.userAnswers addObject:answer];
    }
}

@end
