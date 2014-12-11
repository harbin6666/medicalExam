//
//  ProfilePickDateBtn.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ProfilePickDateBtn.h"

@interface ProfilePickDateBtn ()

@property (nonatomic, strong) IBOutlet UIDatePicker *picker;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

@end

@implementation ProfilePickDateBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onPressedCancel:)];
    UIBarButtonItem *middleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onPressedDone:)];
    
    [self.toolBar setItems:@[leftitem,middleitem,rightitem]];
}

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
    [self resignFirstResponder];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
