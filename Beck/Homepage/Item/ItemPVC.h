//
//  ItemPVC.h
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckPVC.h"

#import "ItemTVC.h"
#import "AnswerCVC.h"

@interface ItemPVC : BeckPVC <UITabBarDelegate>

@property (nonatomic, strong) ItemTVC *currentTVC;

@property (strong, nonatomic) IBOutlet UITabBar *cusTabbar;

@property (nonatomic, strong) NSArray *items;//<ItemVO>

@end
