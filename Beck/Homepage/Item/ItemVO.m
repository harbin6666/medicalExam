//
//  ItemVO.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ItemVO.h"

@implementation ItemVO

- (BOOL)isEqual:(id)object
{
    ItemVO *another = object;
    if ([another.itemId isEqualToString:self.itemId] && another.type == self.type) {
        return YES;
    }
    
    return NO;
}

@end
