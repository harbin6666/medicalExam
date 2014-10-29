//
//  WrongItemEntity.h
//  Beck
//
//  Created by Aimy on 14/10/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemEntity;

@interface WrongItemEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * times;
@property (nonatomic, retain) NSSet *item;
@end

@interface WrongItemEntity (CoreDataGeneratedAccessors)

- (void)addItemObject:(ItemEntity *)value;
- (void)removeItemObject:(ItemEntity *)value;
- (void)addItem:(NSSet *)values;
- (void)removeItem:(NSSet *)values;

@end
