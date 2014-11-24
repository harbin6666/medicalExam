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

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type
{
    ItemVO *itemVO = nil;
    switch (type) {
        case ItemTypeChoice:
            itemVO = [ChoiceItemVO new];
            break;
        case ItemTypeDecision:
            itemVO = [DecisionItemVO new];
            break;
        case ItemTypeMultiChoice:
            itemVO = [MultiChoiceItemVO new];
            break;
        case ItemTypeCompatibility:
            itemVO = [CompatibilityItemVO new];
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
    
    itemVO.userAnswers = @{}.mutableCopy;
    
    return itemVO;
}

- (void)setAnswer:(id)answer andIndex:(NSInteger)index
{
    
}

- (BOOL)isRight
{
    return NO;
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

@end
