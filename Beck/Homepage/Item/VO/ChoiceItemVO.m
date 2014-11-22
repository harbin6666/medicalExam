//
//  ChoiceItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChoiceItemVO.h"

@implementation ChoiceItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    [self.userAnswers removeAllObjects];
    [self.userAnswers addObject:self.itemAnswers[index]];
}

@end
