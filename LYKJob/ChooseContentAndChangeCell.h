//
//  ChooseContentAndChangeCell.h
//  LYKJob
//
//  Created by Aimy on 14/12/1.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseContentCell.h"

@class ChooseContentAndChangeCell;

@protocol ChooseContentAndChangeCellDelegate <ChooseContentCellDelegate>

- (void)needUpdateContentCell:(ChooseContentAndChangeCell *)cell;

@end

@interface ChooseContentAndChangeCell : ChooseContentCell

@property (nonatomic) BOOL fromIntent;

@end
