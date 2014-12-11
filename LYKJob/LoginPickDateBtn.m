//
//  LoginPickDateBtn.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "LoginPickDateBtn.h"

@interface LoginPickDateBtn ()

@property (nonatomic, strong) IBOutlet UIDatePicker *picker;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

@end

@implementation LoginPickDateBtn

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputView
{
    return _picker;
}

- (UIView *)inputAccessoryView
{
    return _toolBar;
}

- (IBAction)onPressedCancel:(id)sender
{
    [self resignFirstResponder];
}

- (IBAction)onPressedDone:(id)sender
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyy-M-dd";
    [self setTitle:[formatter stringFromDate:self.picker.date] forState:UIControlStateNormal];
    NSLog(@"%@",[self getAstroWithDate:self.picker.date]);
    self.selectedDate = self.picker.date;
    [self resignFirstResponder];
}

-(NSString *)getAstroWithDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"d";
    NSString *dS = [formatter stringFromDate:date];
    formatter.dateFormat = @"M";
    NSString *mS = [formatter stringFromDate:date];
    
    int d = dS.intValue;
    int m = mS.intValue;
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}

@end
