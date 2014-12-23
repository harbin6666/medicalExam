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

@property (nonatomic) BOOL canShowNote;

- (void)onPressedBtn1:(UIButton *)sender;
- (void)onPressedBtn2:(UIButton *)sender;
- (void)onPressedBtn3:(UIButton *)sender;
- (void)onPressedBtn4:(UIButton *)sender;
- (void)onPressedBtn5:(UIButton *)sender;

- (void)configTabBar;

- (void)doFavorate;
- (void)doJumpToItem;
- (void)doBack;
- (void)doNext;

@end
