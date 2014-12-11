//
//  ContentCell.h
//  LYKJob
//
//  Created by Aimy on 14/12/3.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentCell;

@protocol ContentCellDelegate <NSObject>

- (void)needUpdateChooseContentCell:(ContentCell *)cell;
- (void)endContentCell:(ContentCell *)cell;

@end

@interface ContentCell : UITableViewCell

@property (nonatomic, weak) id <ContentCellDelegate> delegate;
@property (nonatomic, strong) NSString *titleKey;
@property (nonatomic, strong) NSString *titlePlaceholder;
@property (nonatomic, strong) NSArray *infos;
@property (nonatomic, strong) NSString *title;

- (void)updateWithTitle:(NSString *)title;

+ (CGFloat)heightWithCellData:(id)data;

@end
