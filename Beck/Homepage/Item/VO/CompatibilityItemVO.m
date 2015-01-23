//
//  CompatibilityItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemVO.h"

@implementation CompatibilityItemVO
@synthesize answerString = _answerString;

- (void)getInfoFramDB
{
    NSMutableArray *itemInfo = @[].mutableCopy;
    NSString *sql1 = [@"select * from compatibility_items where compatibility_id == " stringByAppendingFormat:@"%@",self.itemId];
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            self.itemInfo = itemInfo;
        }
        else {
            [itemInfo addObject:row];
        }
    }];
    
    NSMutableArray *itemAnswers = @[].mutableCopy;
    NSString *sql2 = [@"select * from compatibility_questions where compatibility_id == " stringByAppendingFormat:@"%@",self.itemId];
    [[AFSQLManager sharedManager] performQuery:sql2 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            self.itemAnswers = itemAnswers;
        }
        else {
            [itemAnswers addObject:row];
        }
    }];
}

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    NSArray *itemAnswer = self.itemAnswers[index];
    self.userAnswers[itemAnswer] = answer;
}

- (id)getUserAnswerAtIndex:(NSInteger)index
{
    NSArray *itemAnswer = self.itemAnswers[index];
    return self.userAnswers[itemAnswer];
}

- (NSString *)getAnswerAtIndex:(NSInteger)index
{
    NSArray *itemAnswer = self.itemAnswers[index];
    NSString *itemId = itemAnswer[4];
    __block NSString *answer = @"答案";
    [self.itemInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *info = obj;
        if ([info[0] isEqual:itemId]) {
            answer = info[1];
        }
    }];
    return answer;
}

- (NSString *)getAnswer
{
    NSMutableArray *answers = @[].mutableCopy;
    [self.itemAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *answer = self.userAnswers[obj];
        if (answer[1]) {
            [answers addObject:answer[1]];
        }
        else {
            [answers addObject:@""];
        }
    }];
    
    NSString *answer = [answers componentsJoinedByString:@"|"];
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,answer,self.type];
}

- (BOOL)isRight
{
    if (self.userAnswers.count == 0 || (self.userAnswers.count != self.itemAnswers.count)) {
        return NO;
    }
    
    __block BOOL right = YES;
    
    [self.userAnswers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSArray *answer = key;
        NSNumber *itemId = obj;
        if (![answer[0] isEqual:itemId]) {
            right = NO;
            *stop = YES;
        }
    }];
    
    return right;
}

- (void)setAnswerString:(NSString *)answerString
{
    _answerString = answerString;
    if (self.answerString) {
        NSArray *answers = [self.answerString componentsSeparatedByString:@"|"];
        [self.itemInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *itemInfo = obj;
            [answers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *answer = obj;
                if ([itemInfo[1] isEqualToString:answer]) {
                    [self setAnswer:itemInfo andIndex:idx];
                }
            }];
        }];
    }
}

- (NSString *)answerParse
{
    NSMutableArray *parses = @[].mutableCopy;
    [self.itemAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *itemAnswer = obj;
        [parses addObject:itemAnswer[3]];
    }];
    
    return [parses componentsJoinedByString:@"\n"];
}

@end
