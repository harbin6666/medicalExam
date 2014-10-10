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

    self.leftView = [HomepageView autolayoutView];
    self.leftView.tag = 0;
    [self.contentView addSubview:self.leftView];
    [self.leftView addTarget:self action:@selector(onPressedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.middleView = [HomepageView autolayoutView];
    self.middleView.tag = 1;
    [self.contentView addSubview:self.middleView];
    [self.middleView addTarget:self action:@selector(onPressedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightView = [HomepageView autolayoutView];
    self.rightView.tag = 2;
    [self.contentView addSubview:self.rightView];
    [self.rightView addTarget:self action:@selector(onPressedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_leftView][_middleView][_rightView]" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(_leftView, _middleView, _rightView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView, _middleView, _rightView)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.middleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.f / 3 constant:0.f]];
    
    self.leftView.layer.borderWidth = .5f;
    self.leftView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.middleView.layer.borderWidth = .5f;
    self.middleView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.rightView.layer.borderWidth = .5f;
    self.rightView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.views = @[self.leftView, self.middleView, self.rightView];
}

- (void)updateCellWithNames:(NSArray *)names imageView:(NSArray *)imageViews
{
    [self.leftView setTitle:names[0] forState:UIControlStateNormal];
//    [self.leftView setBackgroundImage:[UIImage imageWithColor:imageViews[0]] forState:UIControlStateNormal];
    [self.middleView setTitle:names[1] forState:UIControlStateNormal];
//    [self.middleView setBackgroundImage:[UIImage imageWithColor:imageViews[1]] forState:UIControlStateNormal];
    [self.rightView setTitle:names[2] forState:UIControlStateNormal];
//    [self.rightView setBackgroundImage:[UIImage imageWithColor:imageViews[2]] forState:UIControlStateNormal];
}

- (void)onPressedBtn:(HomepageView *)sender
{
    if ([self.delegate respondsToSelector:@selector(homepageTableViewCell:didSelectedAtIndex:)]) {
        [self.delegate homepageTableViewCell:self didSelectedAtIndex:sender.tag];
    }
}

@end
