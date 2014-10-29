//
//  NoteEntity.h
//  Beck
//
//  Created by Aimy on 14/10/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemEntity;

@interface NoteEntity : NSManagedObject

@property (nonatomic, retain) NSDate * create;
@property (nonatomic, retain) NSString * notetext;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) ItemEntity *item;

@end
