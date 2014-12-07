//
//  PracticeModePVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "PracticeModePVC.h"

#import "ItemTVC.h"

#import "AnswerCVC.h"

@interface PracticeModePVC ()

@end

@implementation PracticeModePVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setSelectedImage:[[UIImage imageNamed:@"answer_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setSelectedImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer"]];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
}

//- (void)onPressedBtn2:(UIButton *)sender {
//    self.currentTVC.showAnswer = !self.currentTVC.showAnswer;
//    sender.selected = self.currentTVC.showAnswer;
//    [self.currentTVC.tableView reloadData];
//}

//- (void)onPressedBtn3:(UIButton *)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
//    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)onPressedBtn4:(UIButton *)sender {
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"add";
    params[@"titleId"] = self.currentTVC.itemVO.itemId;
    params[@"typeId"] = @(self.currentTVC.itemVO.type);
    params[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userCollectionAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.integerValue == 2) {
                self.currentTVC.showAnswer = YES;
                [[OTSAlertView alertWithMessage:@"收藏成功" andCompleteBlock:nil] show];
                [self configTabBar];
            }
            else {
                self.currentTVC.showAnswer = NO;
                [[OTSAlertView alertWithMessage:@"收藏失败" andCompleteBlock:nil] show];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"收藏失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)configTabBar
{
    [super configTabBar];
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        if (self.currentTVC.itemVO.favorated) {
            UITabBarItem *item4 = self.cusTabbar.items[4];
            [item4 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        else {
            UITabBarItem *item4 = self.cusTabbar.items[4];
            [item4 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
    }
    else {
        if (self.currentTVC.itemVO.favorated) {
            UITabBarItem *item4 = self.cusTabbar.items[4];
            [item4 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        else {
            UITabBarItem *item4 = self.cusTabbar.items[4];
            [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
            [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        
    }
}

@end
