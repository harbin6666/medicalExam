//
//  ExamVO.m
//  Beck
//
//  Created by Aimy on 14/11/24.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamVO.h"

@implementation ExamVO

+ (instancetype)createWithExamInfos:(NSDictionary *)infos withItemVOs:(NSArray *)itemVOs
{
    ExamVO *vo = [self new];
    vo.infos = infos;
    vo.itemVOs = itemVOs;
    
    return vo;
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

- (NSString *)getAnswer
{
    NSMutableArray *answers = [NSMutableArray array];
    [self.itemVOs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemVO *vo = obj;
        [answers addObject:vo.getAnswer];
    }];
    return [answers componentsJoinedByString:@","];
}

@end
