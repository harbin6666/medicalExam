//
//  ItemEntity.h
//  Beck
//
//  Created by Aimy on 14/10/30.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FavorateEntity, ItemInSqlEntity, NoteEntity, WrongItemEntity;

@interface ItemEntity : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) ItemInSqlEntity *itemInSql;
@property (nonatomic, retain) NoteEntity *note;
@property (nonatomic, retain) NSSet *wrong;
@property (nonatomic, retain) FavorateEntity *favorate;
@end

@interface ItemEntity (CoreDataGeneratedAccessors)

- (void)addWrongObject:(WrongItemEntity *)value;
- (void)removeWrongObject:(WrongItemEntity *)value;
- (void)addWrong:(NSSet *)values;
- (void)removeWrong:(NSSet *)values;

@end
