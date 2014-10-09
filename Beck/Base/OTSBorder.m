//
//  OTSBorder.m
//  OneStoreFramework
//
//  Created by Aimy on 8/25/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSBorder.h"

typedef NS_ENUM(NSInteger, OTSBorderViewType) {
    OTSBorderViewTypeTop    = 10086,
    OTSBorderViewTypeLeft,
    OTSBorderViewTypeBottom,
    OTSBorderViewTypeRight,
};

@implementation OTSBorder

+ (void)addBorderWithView:(UIView *)aView type:(OTSBorderType)aType andColor:(UIColor *)aColor
{
    [self addBorderWithView:aView type:aType andColor:aColor andEdgeInset:UIEdgeInsetsZero];
}

+ (void)addBorderWithView:(UIView *)aView type:(OTSBorderType)aType andColor:(UIColor *)aColor andEdgeInset:(UIEdgeInsets)aEdgeInset
{
    UIView *copyView = [UIView autolayoutView];
    copyView.backgroundColor = aColor;
    
    NSDictionary *insets = @{@"left": @(aEdgeInset.left), @"right": @(aEdgeInset.right), @"top": @(aEdgeInset.top), @"bottom": @(aEdgeInset.bottom)};
    
    if (aType & OTSBorderTypeTop) {
        UIView *borderView = [UIView duplicate:copyView];
        borderView.tag = OTSBorderViewTypeTop;
        [aView addSubview:borderView];
        
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[borderView]-(right)-|" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[borderView]" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:1.f + aEdgeInset.bottom]];
    }
    
    if (aType & OTSBorderTypeLeft) {
        UIView *borderView = [UIView duplicate:copyView];
        borderView.tag = OTSBorderViewTypeLeft;
        [aView addSubview:borderView];
        
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[borderView]-(bottom)-|" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[borderView]" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:1.f + aEdgeInset.right]];
    }
    
    if (aType & OTSBorderTypeBottom) {
        UIView *borderView = [UIView duplicate:copyView];
        borderView.tag = OTSBorderViewTypeBottom;
        [aView addSubview:borderView];
        
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[borderView]-(right)-|" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:aView attribute:NSLayoutAttributeBottom multiplier:1.f constant:aEdgeInset.top]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:1.f + aEdgeInset.bottom]];
    }
    
    if (aType & OTSBorderTypeRight) {
        UIView *borderView = [UIView duplicate:copyView];
        borderView.tag = OTSBorderViewTypeRight;
        [aView addSubview:borderView];
        
        [aView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[borderView]-(bottom)-|" options:0 metrics:insets views:NSDictionaryOfVariableBindings(borderView)]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:aView attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f]];
        [aView addConstraint:[NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:1.f + aEdgeInset.right]];
    }
}

+ (void)removeBorderWithView:(UIView *)aView type:(OTSBorderType)aType
{
    if (aType & OTSBorderTypeTop) {
        UIView *borderView = [aView viewWithTag:OTSBorderViewTypeTop];
        [borderView removeFromSuperview];
    }
    
    if (aType & OTSBorderTypeLeft) {
        UIView *borderView = [aView viewWithTag:OTSBorderViewTypeLeft];
        [borderView removeFromSuperview];
    }
    
    if (aType & OTSBorderTypeBottom) {
        UIView *borderView = [aView viewWithTag:OTSBorderViewTypeBottom];
        [borderView removeFromSuperview];
    }
    
    if (aType & OTSBorderTypeRight) {
        UIView *borderView = [aView viewWithTag:OTSBorderViewTypeRight];
        [borderView removeFromSuperview];
    }
}

@end
