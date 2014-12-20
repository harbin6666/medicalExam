//
//  PractiseVO.m
//  Beck
//
//  Created by Aimy on 14/12/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PractiseVO.h"

@implementation PractiseVO

+ (instancetype)createWithItemVOs:(NSArray *)itemVOs
{
    PractiseVO *vo = [self new];
    vo.itemVOs = itemVOs;
    return vo;
}

- (NSNumber *)getRightAmount
{
    __block int count = 0;
    [self.itemVOs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemVO *vo = obj;
        if (vo.isRight) {
            count++;
        }
    }];
    
    return @(count);
}

- (NSNumber *)getWrongAmount
{
    __block int count = 0;
    [self.itemVOs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemVO *vo = obj;
        if (!vo.isRight) {
            count++;
        }
    }];
    
    return @(count);
}

- (NSNumber *)getAmount
{
    return @(self.itemVOs.count);
}

- (NSNumber *)getAccurateRate
{
    return @(self.getRightAmount.floatValue / self.getAmount.floatValue);
}

- (NSNumber *)getScore
{
    __block int score = 0;
    [self.itemVOs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemVO *vo = obj;
        if (vo.isRight) {
            score += [vo getScore].intValue;
        }
    }];
    
    return @(score);
}

- (NSArray *)getAnswerList
{
    NSMutableArray *answers = @[].mutableCopy;
    [self.itemVOs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            ItemVO *vo = obj;
            NSMutableDictionary *infos = @{}.mutableCopy;
            infos[@"titleId"] = vo.itemId;
            infos[@"titleTypeId"] = @(vo.type);
            infos[@"userAnswer"] = vo.getOnlyAnswer;
            infos[@"isRight"] = (vo.isRight ? @"true" : @"false");
            infos[@"priority"] = @(idx + 1);
            [answers addObject:infos];
        }
    }];
    
    return answers;
}

@end
