//
//  ChoiceItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChoiceItemVO.h"

@implementation ChoiceItemVO
@synthesize answerString = _answerString;

- (void)getInfoFramDB
{
    NSString *sql1 = [@"select * from choice_questions where choice_id == " stringByAppendingFormat:@"%@",self.itemId];
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {

        }
        else {
            self.itemInfo = row;
        }
    }];
    
    NSMutableArray *itemAnswers = @[].mutableCopy;
    NSString *sql2 = [@"select * from choice_items where choice_id == " stringByAppendingFormat:@"%@",self.itemId];
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

- (BOOL)isNeedGoToNext
{
    if (self.userAnswers.count == 1) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isAnswerAtIndex:(NSInteger)index
{
    NSArray *answer = self.itemAnswers[index];
    NSNumber *isAnswer = answer[5];
    return [isAnswer boolValue];
}

- (void)setAnswerString:(NSString *)answerString
{
    _answerString = answerString;
    if (self.answerString) {
        NSArray *answers = [self.answerString componentsSeparatedByString:@"|"];
        NSString *answer = answers.firstObject;
        [self.itemAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *itemAnswer = obj;
            NSString *itemNumber = itemAnswer[2];
            if ([itemNumber isEqualToString:answer]) {
                [self setAnswer:nil andIndex:idx];
                *stop = YES;
            }
        }];
    }
}

- (NSString *)answerParse
{
    return self.itemInfo[11] ?: @"无";
}

@end
