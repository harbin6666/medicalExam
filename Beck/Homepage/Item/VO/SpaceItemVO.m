//
//  SpaceItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "SpaceItemVO.h"

@implementation SpaceItemVO

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    self.userAnswers[@(index)] = answer;
}

- (NSString *)getAnswer
{
    NSString *answer = self.userAnswers.allValues.lastObject;
    return [NSString stringWithFormat:@"%@:%@:%d",self.itemId,answer,self.type];
}

@end
