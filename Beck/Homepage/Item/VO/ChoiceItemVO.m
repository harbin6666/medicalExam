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
    self.userAnswers[@(index)] = self.itemAnswers[index];
}

- (NSString *)getAnswer
{
    NSArray *itemAnswer = self.userAnswers.allValues.lastObject;
    NSString *string = [itemAnswer[2] description];
    string = (string ?: @"");
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,string,self.type];
}

- (BOOL)isRight
{
    NSNumber *isAnswer = self.userAnswers.allValues.lastObject[5];
    return [isAnswer boolValue];
}

@end
