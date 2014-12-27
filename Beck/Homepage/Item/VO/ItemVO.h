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
    ItemTypeCompatibility,
    ItemTypeMultiChoice,
    ItemTypeDecision,
    ItemTypeSpace
} ItemType;

@interface ItemVO : NSObject

@property (nonatomic) BOOL canChange;

@property (nonatomic) BOOL showAnswer;
@property (nonatomic) BOOL showNote;
@property (nonatomic) BOOL favorated;

@property (nonatomic) BOOL canShowNote;

@property (nonatomic) BOOL hasNote;

@property (nonatomic, strong) NSString *noteString;

@property (nonatomic, strong) NSArray *itemInfo;
@property (nonatomic, strong) NSArray *itemAnswers;

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *outlineId;
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic) ItemType type;

@property (nonatomic, strong) NSMutableDictionary *userAnswers;

@property (nonatomic, strong) NSString *answerString;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type score:(NSNumber *)score;

+ (instancetype)createWithExamAnswer:(NSString *)answer;

+ (instancetype)createWithItemId:(NSString *)itemId andType:(ItemType)type andAnswer:(NSString *)answer;

- (void)setAnswer:(id)answer andIndex:(NSInteger)index;

- (id)getAnswerAtIndex:(NSInteger)index;

- (BOOL)isRight;

- (BOOL)isSelectedAtIndex:(NSInteger)index;

- (NSNumber *)getScore;

- (NSString *)getAnswer;

- (NSString *)answerParse;

- (NSString *)getOnlyAnswer;

@end
