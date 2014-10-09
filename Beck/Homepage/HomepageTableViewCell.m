//
//  HomepageTableViewCell.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "HomepageTableViewCell.h"

@implementation HomepageTableViewCell

- (void)awakeFromNib {

//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.leftView.translatesAutoresizingMaskIntoConstraints = NO;
    self.middleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView, _middleView, _rightView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView, _middleView, _rightView)]];
    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];
    

}

- (void)updateCellWithData:(NSArray *)data
{
    self.leftView.backgroundColor = data[0];
    self.middleView.backgroundColor = data[1];
    self.rightView.backgroundColor = data[2];
}

@end
