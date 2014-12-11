//
//  PractiseVO.h
//  Beck
//
//  Created by Aimy on 14/12/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemVO.h"

@interface PractiseVO : NSObject

@property (nonatomic, strong) NSArray *itemVOs;

+ (instancetype)createWithItemVOs:(NSArray *)itemVOs;

- (NSNumber *)getRightAmount;
- (NSNumber *)getWrongAmount;
- (NSNumber *)getAmount;
- (NSNumber *)getAccurateRate;

- (NSArray *)getAnswerList;

@end
