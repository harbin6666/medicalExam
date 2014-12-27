//
//  PracticeModePVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "PracticeModePVC.h"

#import "ItemTVC.h"

#import "PractiseVO.h"

@interface PracticeModePVC ()

@end

@implementation PracticeModePVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setSelectedImage:[[UIImage imageNamed:@"answer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
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
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer"]];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
}

- (void)onPressedBtn2:(UIButton *)sender {
    self.currentTVC.itemVO.showAnswer = !self.currentTVC.itemVO.showAnswer;
    [self.currentTVC.tableView reloadData];
    [self configTabBar];
}

- (void)onPressedBtn4:(UIButton *)sender {
    [self doFavorate];
}

- (void)configTabBar
{
    [super configTabBar];
    UITabBarItem *item2 = self.cusTabbar.items[1];
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        if (self.currentTVC.itemVO.showAnswer) {
            [item2 setSelectedImage:[[UIImage imageNamed:@"answer_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setImage:[[UIImage imageNamed:@"answer_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item2 setSelectedImage:[[UIImage imageNamed:@"answer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setImage:[[UIImage imageNamed:@"answer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
    }
    else {
        if (self.currentTVC.itemVO.showAnswer) {
            [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer_sel"]];
        }
        else {
            [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer"]];
        }
    }
    
    if (self.currentTVC.itemVO.showAnswer) {
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    }
    else {
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    }
    
    UITabBarItem *item4 = self.cusTabbar.items[3];
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        if (self.currentTVC.itemVO.favorated) {
            [item4 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item4 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item4 setImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
    }
    else {
        if (self.currentTVC.itemVO.favorated) {
            [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate_sel"]];
        }
        else {
            [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        }
    }
    
    if (self.currentTVC.itemVO.favorated) {
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    }
    else {
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    }
}

- (IBAction)onPressedSubmit:(id)sender
{
    __block BOOL done = NO;
    __block BOOL canSubmit = NO;
    NSMutableArray *notDones = @[].mutableCopy;
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemVO *vo = obj;
        if (vo.userAnswers.count) {
            done = YES;
        }
        else {
            [notDones addObject:@(idx + 1)];
        }
    }];
    
    if (notDones.count == self.items.count) {
        canSubmit = YES;
    }
    
    if (!done) {
        [[OTSAlertView alertWithMessage:@"当前练习无效" andCompleteBlock:nil] show];
        return;
    }
    else if (!canSubmit) {
        NSString *noteDone = [notDones componentsJoinedByString:@","];
        [[OTSAlertView alertWithTitle:@"未做的题目" message:noteDone andCompleteBlock:nil] show];
        return;
    }
    
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"是否提交?" message:@"" leftBtn:@"提交" rightBtn:@"取消" extraData:nil andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            STRONG_SELF;
            [self submitPractise];
        }
    }];
    [alertView show];
}

- (void)submitPractise
{
    [self showLoading];
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"add";
    
    PractiseVO *vo = [PractiseVO createWithItemVOs:self.items];
    
    NSMutableDictionary *json = @{}.mutableCopy;
    json[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    json[@"subjectId"] = self.subjectId;
    json[@"outlineId"] = self.examOutlineId;
    json[@"amount"] = vo.getAmount;
    json[@"accurateRate"] = vo.getAccurateRate;
    json[@"list"] = vo.getAnswerList;
    json[@"score"] = vo.getScore;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"json"] = jsonString;
    
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userExerciseAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"提交失败" andCompleteBlock:nil] show];
        }
    }];
}

@end
