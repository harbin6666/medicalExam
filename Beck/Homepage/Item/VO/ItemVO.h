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

@property (nonatomic, strong) NSArray *itemInfo;
@property (nonatomic, strong) NSArray *itemAnswers;

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic) ItemType type;

@property (nonatomic) BOOL showNote;
@property (nonatomic) BOOL favorated;

@property (nonatomic, strong) NSMutableDictionary *userAnswers;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type score:(NSNumber *)score;

- (void)setAnswer:(id)answer andIndex:(NSInteger)index;

- (BOOL)isRight;

- (BOOL)isSelectedAtIndex:(NSInteger)index;

- (NSNumber *)getScore;

- (NSString *)getAnswer;

@end
