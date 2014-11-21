//
//  NSString+clear.m
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "NSString+clear.h"

@implementation NSString (clear)

- (NSString *)clearString
{
    NSString *temp = self.copy;
    temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return temp;
}

@end
