//
//  ItemInSqlEntity.h
//  Beck
//
//  Created by Aimy on 14/10/30.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemEntity;

@interface ItemInSqlEntity : NSManagedObject

@property (nonatomic, retain) ItemEntity *item;

@end
