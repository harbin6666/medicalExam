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
    NSArray *itemAnswer = self.itemAnswers[index];
    self.userAnswers[itemAnswer] = answer;
}

- (NSString *)getAnswer
{
    NSMutableArray *answers = @[].mutableCopy;
    [self.itemAnswers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *answer = self.userAnswers[obj];
        if (answer[1]) {
            [answers addObject:answer[1]];
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

@end
