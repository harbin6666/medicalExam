//
//  ExamEntity.h
//  Beck
//
//  Created by Aimy on 14/10/30.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ExamEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * accuracy;
@property (nonatomic, retain) NSNumber * right;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * wrong;

@end
