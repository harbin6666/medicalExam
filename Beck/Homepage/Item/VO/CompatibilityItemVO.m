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
    self.userAnswers[answer] = itemAnswer[4];
}

- (NSString *)getAnswer
{
    NSArray *answer = self.userAnswers.allKeys.lastObject;
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,answer[1],self.type];
}

- (BOOL)isRight
{
    if (self.userAnswers.count > 0 && self.userAnswers.count != self.itemAnswers.count) {
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
