//
//  ItemVO.h
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ItemType
{
    ItemTypeChoice = 1,
    ItemTypeDecision,
    ItemTypeMultiChoice,
    ItemTypeCompatibility,
    ItemTypeSpace
} ItemType;

@interface ItemVO : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic) ItemType type;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type;

@end
