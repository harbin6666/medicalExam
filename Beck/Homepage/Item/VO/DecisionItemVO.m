//
//  DecisionItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "DecisionItemVO.h"

@implementation DecisionItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    [self.userAnswers removeAllObjects];
    if (index == 0) {
        self.userAnswers[@0] = @(YES);
    }
    else {
        self.userAnswers[@0] = @(NO);
    }
}

@end
