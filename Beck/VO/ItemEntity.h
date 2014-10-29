//
//  ItemEntity.h
//  Beck
//
//  Created by Aimy on 14/10/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemInSqlEntity, NoteEntity, WrongItemEntity;

@interface ItemEntity : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) ItemInSqlEntity *itemInSql;
@property (nonatomic, retain) NoteEntity *note;
@property (nonatomic, retain) WrongItemEntity *wrongItem;

@end
