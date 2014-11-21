//
//  CompatibilityItemBtn.m
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemBtn.h"

@interface CompatibilityItemBtn () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pv;

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation CompatibilityItemBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.pv = [UIPickerView new];
    self.pv.delegate = self;
    self.pv.dataSource = self;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.toolbar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onPressedCancel:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onPressedDone:)];
    [self.toolbar setItems:@[cancel,flex,done]];
}

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
    self.answer = self.answers[[self.pv selectedRowInComponent:0]];
    [self setTitle:self.answer forState:UIControlStateNormal];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.answers.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *answer = self.answers[row];
    return answer;
}

@end
