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
        [item2 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
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
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"favorate_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        
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

//- (void)onPressedBtn2:(UIButton *)sender {
//    self.currentTVC.favorated = !self.currentTVC.favorated;
//    sender.selected = self.currentTVC.favorated;
//}

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
    params[@"paperId"] = self.examInfos[@"id"];
    params[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    params[@"beginTime"] = self.beginTime.description;
    params[@"endTime"] = [NSDate date].description;
    
    ExamVO *vo = [ExamVO createWithExamInfos:self.examInfos withItemVOs:self.items];
    params[@"Score"] = vo.getScore.stringValue;
    params[@"userAnswer"] = vo.getAnswer;
    params[@"rightAmount"] = vo.getRightAmount.stringValue;
    params[@"wrongAmount"] = vo.getWrongAmount.stringValue;
    
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

@end
