//
//  ItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ItemVO.h"

#import "ChoiceItemVO.h"
#import "DecisionItemVO.h"
#import "MultiChoiceItemVO.h"
#import "CompatibilityItemVO.h"
#import "SpaceItemVO.h"

@implementation ItemVO

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type score:(NSNumber *)score
{
    if (!itemId) {
        return nil;
    }
    
    ItemVO *itemVO = nil;
    switch (type) {
        case ItemTypeChoice:
            itemVO = [ChoiceItemVO new];
            break;
        case ItemTypeMultiChoice:
            itemVO = [MultiChoiceItemVO new];
            break;
        case ItemTypeCompatibility:
            itemVO = [CompatibilityItemVO new];
            break;
        case ItemTypeDecision:
            itemVO = [DecisionItemVO new];
            break;
        case ItemTypeSpace:
            itemVO = [SpaceItemVO new];
            break;
            
        default:
            break;
    }
    
    itemVO.type = type;
    if ([itemId isKindOfClass:[NSString class]]) {
        itemVO.itemId = itemId;
    }
    else {
        itemVO.itemId = [(NSNumber *)itemId stringValue];
    }
    
    itemVO.score = score;
    itemVO.userAnswers = @{}.mutableCopy;
    itemVO.canShowNote = YES;
    
    return itemVO;
}

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type
{
    return [self createWithItemId:itemId andType:type score:@0];
}

+ (instancetype)createWithExamAnswer:(NSString *)answer
{
    NSArray *infos = [answer componentsSeparatedByString:@":"];
    ItemVO *vo = [self createWithItemId:infos[0] andType:[infos[2] intValue]];
    vo.answerString = infos[1];
    vo.showAnswer = YES;
    return vo;
}

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type andAnswer:(NSString *)answer
{
    ItemVO *vo = [self createWithItemId:itemId andType:type];
    vo.answerString = answer;
    vo.showAnswer = YES;
    return vo;
}

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    
}

- (id)getAnswerAtIndex:(NSInteger)index
{
    return nil;
}

- (BOOL)isRight
{
    return NO;
}

- (NSNumber *)getScore
{
    return self.score;
}

- (NSString *)getAnswer
{
    return @"";
}

- (NSString *)answerParse
{
    return @"";
}

- (BOOL)isSelectedAtIndex:(NSInteger)index
{
    return [self.userAnswers.allKeys containsObject:@(index)];
}

- (BOOL)isEqual:(id)object
{
    ItemVO *another = object;
    if ([another.itemId isEqualToString:self.itemId] && another.type == self.type) {
        return YES;
    }
    
    return NO;
}

- (NSString *)getOnlyAnswer
{
    return [self.getAnswer componentsSeparatedByString:@":"][1];
}

@end
