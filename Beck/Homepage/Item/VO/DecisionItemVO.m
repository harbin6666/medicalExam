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
    self.userAnswers[@(index)] = @1;
}

- (NSString *)getAnswer
{
    NSString *string = [self.userAnswers.allKeys.lastObject description];
    string = (string ?: @"");
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,string,self.type];
}

- (BOOL)isRight
{
    NSNumber *isAnswer = self.userAnswers.allValues.lastObject;
    return [isAnswer boolValue];
}

@end
