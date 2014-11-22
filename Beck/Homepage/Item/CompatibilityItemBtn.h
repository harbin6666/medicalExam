//
//  CompatibilityItemBtn.h
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemVO.h"

@interface CompatibilityItemBtn : UIButton

@property (nonatomic, strong) ItemVO *itemVO;

@property (nonatomic) NSInteger answerIndex;

@end
