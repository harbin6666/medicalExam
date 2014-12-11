//
//  ContentCell.m
//  LYKJob
//
//  Created by Aimy on 14/12/3.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ContentCell.h"

@interface ContentCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@end

@implementation ContentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.contentTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)updateWithTitle:(NSString *)title
{
    self.contentTF.placeholder = self.titlePlaceholder;
    self.contentTF.text = title;
    self.title = title;
}

+ (CGFloat)heightWithCellData:(id)data
{
    return 44;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([@"name" isEqualToString:_titleKey]) {
        [self getValueWithLYKUrl:@"/resumeJ!getResumeContants" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
            if ([aResponseObject[@"educations"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *names = @[].mutableCopy;
                for (NSString *name in aResponseObject[@"educations"]) {
                    [names addObject:@{@"name":name}];
                }
                
                self.infos = names;
                [self.delegate needUpdateChooseContentCell:self];
            }
            
        }];
        return NO;
    }
    else if ([@"score" isEqualToString:_titleKey]){
        [self getValueWithLYKUrl:@"/resumeJ!getResumeContants" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
            if ([aResponseObject[@"scores"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *names = @[].mutableCopy;
                for (NSString *name in aResponseObject[@"scores"]) {
                    [names addObject:@{@"score":name}];
                }
                
                self.infos = names;
                [self.delegate needUpdateChooseContentCell:self];
            }
        }];
        return NO;
    }
    else if ([@"intention" isEqualToString:_titleKey]) {
        [self.delegate needUpdateChooseContentCell:self];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.title = textField.text;
    [self.delegate endContentCell:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *contentString = [textField.text stringByAppendingString:string];
    if (contentString.length) {
        NSString *url = nil;
        if ([@"schoolName" isEqualToString:_titleKey]) {
            url = @"/resumeJ!getSchools";
        }
        else if ([@"specialtyName" isEqualToString:_titleKey]) {
            url = @"/resumeJ!getSpecialties";
        }
        else if ([@"certificateName" isEqualToString:_titleKey]){
            url = @"/resumeJ!getCertificates";
        }
        else {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidChanged:(UITextField *)textField
{
    NSString *contentString = textField.text;
    if (contentString.length) {
        NSString *url = nil;
        if ([@"schoolName" isEqualToString:_titleKey]) {
            url = @"/resumeJ!getSchools";
        }
        else if ([@"specialtyName" isEqualToString:_titleKey]) {
            url = @"/resumeJ!getSpecialties";
        }
        else if ([@"certificateName" isEqualToString:_titleKey]){
            url = @"/resumeJ!getCertificates";
        }
        
        if (url) {
            [self getValueWithLYKUrl:url params:@{@"searchName":contentString} CompleteBlock:^(id aResponseObject, NSError *anError) {
                
                if ([aResponseObject isKindOfClass:[NSArray class]]) {
                    self.infos = aResponseObject;
                }
                
                [self.delegate needUpdateChooseContentCell:self];
            }];
        }
    }
}

@end
