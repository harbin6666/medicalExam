//
//  MultiChoiceItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MultiChoiceItemVO.h"

@implementation MultiChoiceItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    if ([self.userAnswers.allKeys containsObject:@(index)]) {
        [self.userAnswers removeObjectForKey:@(index)];
    }
    else {
        self.userAnswers[@(index)] = self.itemAnswers[index];
    }
}

@end
