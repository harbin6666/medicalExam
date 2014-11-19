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
    self.province = self.provinces[[self.pv selectedRowInComponent:0]];
    [self setTitle:self.province[@"province"] forState:UIControlStateNormal];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.provinces.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *province = self.provinces[row];
    return province[@"province"];
}

@end
