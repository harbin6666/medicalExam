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
    self.userAnswers[@(index)] = answer;
}

- (NSString *)getAnswer
{
    NSArray *answer = self.userAnswers.allValues.lastObject;
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,answer[1],self.type];
}

@end
