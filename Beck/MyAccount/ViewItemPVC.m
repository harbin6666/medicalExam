//
//  ViewItemPVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ViewItemPVC.h"

@interface ViewItemPVC ()

@end

@implementation ViewItemPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item1 = self.cusTabbar.items[0];
    UITabBarItem *item2 = self.cusTabbar.items[1];
    UITabBarItem *item3 = self.cusTabbar.items[2];
//    UITabBarItem *item4 = self.cusTabbar.items[3];
    UITabBarItem *item5 = self.cusTabbar.items[3];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [item2 setSelectedImage:[[UIImage imageNamed:@"answer_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [item3 setSelectedImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        
//        [item4 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer"]];
        
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
//        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
}

- (void)onPressedBtn2:(UIButton *)sender {
    self.currentTVC.itemVO.showAnswer = !self.currentTVC.itemVO.showAnswer;
    sender.selected = self.currentTVC.itemVO.showAnswer;
    [self.currentTVC.tableView reloadData];
}

- (void)configTabBar
{
    [super configTabBar];
}

@end
