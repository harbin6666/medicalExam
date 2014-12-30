//
//  BeckMCTVCell.h
//  Beck
//
//  Created by Aimy on 14/12/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeckMCTVCell : UITableViewCell

+ (CGFloat)heightWithData:(NSDictionary *)info;

- (void)updateWithData:(NSDictionary *)info;

@end
