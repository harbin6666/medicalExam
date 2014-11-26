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

- (NSString *)getAnswer
{
    NSMutableArray *answers = @[].mutableCopy;
    [self.userAnswers.allValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *itemAnswer = obj;
        [answers addObject:itemAnswer[2]];
    }];
    NSString *answer = [answers componentsJoinedByString:@"|"];
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,answer,self.type];
}

- (BOOL)isRight
{
    int count = 0;
    BOOL right = NO;
    
    for (NSArray *itemAnswer in self.itemAnswers) {
        NSNumber *isAnswer = itemAnswer[5];
        if (isAnswer.boolValue) {
            count++;
            if (![self.userAnswers.allValues containsObject:itemAnswer]) {
                break;
            }
        }
    }
    
    if (count != self.userAnswers.allKeys.count) {
        return NO;
    }
    
    return right;
}

@end
