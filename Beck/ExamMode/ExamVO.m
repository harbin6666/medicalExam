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
    return @0;
}

- (NSNumber *)getRightAmount
{
    return @0;
}

- (NSNumber *)getWrongAmount
{
    return @0;
}

- (NSString *)getAnswer
{
    return @"";
}

@end
