//
//  ExamVO.h
//  Beck
//
//  Created by Aimy on 14/11/24.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemVO.h"

@interface ExamVO : NSObject

@property (nonatomic, strong) NSArray *itemVOs;
@property (nonatomic, strong) NSDictionary *infos;

+ (instancetype)createWithExamInfos:(NSDictionary *)infos withItemVOs:(NSArray *)itemVOs;

- (NSNumber *)getScore;
- (NSNumber *)getRightAmount;
- (NSNumber *)getWrongAmount;
- (NSString *)getAnswer;

@end
