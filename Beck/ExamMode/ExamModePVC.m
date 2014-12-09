//
//  ExamModePVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ExamModePVC.h"

#import "ExamVO.h"

@interface ExamModePVC ()

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, copy) NSDate *deadTime;
@property (nonatomic, strong) NSDate *beginTime;

@end

@implementation ExamModePVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTime];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setSelectedImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setSelectedImage:[[UIImage imageNamed:@"submit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"submit"] withFinishedUnselectedImage:[UIImage imageNamed:@"submit"]];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
    
    if (self.fromExam) {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        [btn setTitle:@"真题考试" forState:UIControlStateNormal];
    }
}

- (void)leftBtnClick:(UIButton *)sender
{
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"是否退出考试?" message:@"" leftBtn:@"退出" rightBtn:@"取消" extraData:nil andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            STRONG_SELF;
            [super leftBtnClick:sender];
            [self.countdownTimer invalidate];
        }
    }];
    [alertView show];
}

- (void)setTime
{
    [self.countdownTimer invalidate];
    NSNumber *answerTime = self.examInfos[@"answerTime"];
    if (!answerTime.longLongValue) {
        return;
    }
    
    self.beginTime = [NSDate date];
    self.deadTime = [NSDate dateWithTimeIntervalSinceNow:answerTime.longLongValue * 60];
    WEAK_SELF;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:weakSelf selector:@selector(runCountdown) userInfo:nil repeats:YES];
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
    [self.countdownTimer fire];
}

- (void)runCountdown
{
    NSDate *now = [NSDate date];
    if ([self.deadTime compare:now] == NSOrderedDescending) {
        NSTimeInterval timeInterval = [self.deadTime timeIntervalSinceDate:now];
        NSDate *endingDate = now;
        NSDate *startingDate = [endingDate dateByAddingTimeInterval:-timeInterval];
        
        NSCalendarUnit components = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components fromDate:startingDate toDate:endingDate options:(NSCalendarOptions)0];
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%02d:%02d", (int)dateComponents.minute, (int)dateComponents.second] forState:UIControlStateNormal];
    }
    else {
        [self.countdownTimer invalidate];
    }
}

- (void)onPressedBtn2:(UIButton *)sender {
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

//- (void)onPressedBtn3:(UIButton *)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
//    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)onPressedBtn4:(UIButton *)sender {
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"是否交卷?" message:@"" leftBtn:@"交卷" rightBtn:@"取消" extraData:nil andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            STRONG_SELF;
            [self submitExam];
        }
    }];
    [alertView show];
}

- (void)submitExam
{
    [self showLoading];
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"add";
    NSMutableDictionary *json = @{}.mutableCopy;
    json[@"paperId"] = self.examInfos[@"id"];
    json[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    json[@"beginTime"] = self.beginTime.description;
    json[@"endTime"] = [NSDate date].description;
    
    ExamVO *vo = [ExamVO createWithExamInfos:self.examInfos withItemVOs:self.items];
    json[@"Score"] = vo.getScore.stringValue;
    json[@"userAnswer"] = vo.getAnswer;
    json[@"rightAmount"] = vo.getRightAmount.stringValue;
    json[@"wrongAmount"] = vo.getWrongAmount.stringValue;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"json"] = jsonString;
    
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userExamAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
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

- (void)configTabBar
{
    [super configTabBar];
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        if (self.currentTVC.itemVO.favorated) {
            UITabBarItem *item2 = self.cusTabbar.items[1];
            [item2 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        else {
            UITabBarItem *item2 = self.cusTabbar.items[1];
            [item2 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
    }
    else {
        if (self.currentTVC.itemVO.favorated) {
            UITabBarItem *item2 = self.cusTabbar.items[1];
            [item2 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        else {
            UITabBarItem *item2 = self.cusTabbar.items[1];
            [item2 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
            [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        }
        
    }
}

@end
