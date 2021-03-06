//
//  MultiChoiceItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MultiChoiceItemVO.h"

@implementation MultiChoiceItemVO
@synthesize answerString = _answerString;

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
    answers = [answers.copy sortedArrayUsingComparator:^(id a, id b) {
        NSInteger len = MIN([a length], [b length]);
        NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_hans"];
        NSComparisonResult ret = [a compare:b options:NSLiteralSearch range:NSMakeRange(0, len) locale:local];
        return ret;
    }].mutableCopy;
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

- (BOOL)isNeedGoToNext
{
    int count = 0;
    
    for (NSArray *itemAnswer in self.itemAnswers) {
        NSNumber *isAnswer = itemAnswer[5];
        if (isAnswer.boolValue) {
            count++;
        }
    }
    
    if (self.userAnswers.count == count) {
        return YES;
    }
    
    return NO;
}

- (void)setAnswerString:(NSString *)answerString
{
    _answerString = answerString;
    
    if (self.answerString) {
        NSArray *answers = [self.answerString componentsSeparatedByString:@"|"];
        [self.itemAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *itemAnswer = obj;
            NSString *itemNumber = itemAnswer[2];
            if ([answers containsObject:itemNumber]) {
                [self setAnswer:nil andIndex:idx];
            }
        }];
    }
}

- (NSString *)answerParse
{
    return self.itemInfo[11] ?: @"无";
}

@end
