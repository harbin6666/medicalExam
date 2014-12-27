//
//  AnswerCVCCell.h
//  Beck
//
//  Created by Aimy on 14/12/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemVO.h"

@interface AnswerCVCCell : UICollectionViewCell

- (void)updateWithItemVO:(ItemVO *)aVO andIndex:(NSInteger)aIndex;

@end
