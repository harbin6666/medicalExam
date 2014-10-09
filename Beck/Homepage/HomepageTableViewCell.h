//
//  HomepageTableViewCell.h
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageView.h"

@interface HomepageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HomepageView *leftView;
@property (weak, nonatomic) IBOutlet HomepageView *middleView;
@property (weak, nonatomic) IBOutlet HomepageView *rightView;

- (void)updateCellWithData:(NSArray *)data;

@end
