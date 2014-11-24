//
//  DecisionItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "DecisionItemVO.h"

@implementation DecisionItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    [self.userAnswers removeAllObjects];
    self.userAnswers[@(index)] = @1;
}

- (NSString *)getAnswer
{
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,self.userAnswers.allKeys.lastObject,self.type];
}

@end
