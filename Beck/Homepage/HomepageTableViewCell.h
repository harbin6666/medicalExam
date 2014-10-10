//
//  HomepageTableViewCell.h
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageView.h"

@class HomepageTableViewCell;

@protocol HomepageTableViewCellDelegate <NSObject>

- (void)homepageTableViewCell:(HomepageTableViewCell *)aCell didSelectedAtIndex:(NSInteger)aIndex;

@end

@interface HomepageTableViewCell : UITableViewCell

@property (nonatomic, weak) id <HomepageTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSArray *views;//list <HomepageView>

@property (strong, nonatomic) HomepageView *leftView;
@property (strong, nonatomic) HomepageView *middleView;
@property (strong, nonatomic) HomepageView *rightView;

- (void)updateCellWithNames:(NSArray *)names imageView:(NSArray *)imageViews;

@end
