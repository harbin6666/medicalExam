//
//  BeckChangeExamPlaceBtn.m
//  Beck
//
//  Created by Aimy on 14/11/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckChangeExamPlaceBtn.h"

@interface BeckChangeExamPlaceBtn () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UIPickerView *pv;

@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;

@end

@implementation BeckChangeExamPlaceBtn

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputView
{
    return _pv;
}

- (UIView *)inputAccessoryView
{
    return _toolbar;
}

- (IBAction)onPressedCancel:(id)sender
{
    [self resignFirstResponder];
}

- (IBAction)onPressedDone:(id)sender
{
    [self resignFirstResponder];
}

@end
