//
//  CancelContentCell.h
//  LYKJob
//
//  Created by Aimy on 14/11/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelContentCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *titles;

- (void)updateWithTitles:(NSArray *)titles;

@end
