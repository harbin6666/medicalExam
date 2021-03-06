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
    
    UITabBarItem *item1 = self.cusTabbar.items[0];
//    UITabBarItem *item2 = self.cusTabbar.items[1];
    UITabBarItem *item3 = self.cusTabbar.items[1];
    UITabBarItem *item4 = self.cusTabbar.items[2];
    UITabBarItem *item5 = self.cusTabbar.items[3];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
//        [item2 setSelectedImage:[[UIImage imageNamed:@"favorate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        [item3 setSelectedImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        
        [item4 setSelectedImage:[[UIImage imageNamed:@"submit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        
//        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"favorate"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
//        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"submit"] withFinishedUnselectedImage:[UIImage imageNamed:@"submit"]];
        [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
        
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
    
    if (self.fromExam) {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        [btn setTitle:@"真题考试" forState:UIControlStateNormal];
    }
}

- (BOOL)canShowNote
{
    return NO;
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
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%02d:%02d", (int)dateComponents.minute + (int)dateComponents.hour * 60, (int)dateComponents.second] forState:UIControlStateNormal];
    }
    else {
        [self.countdownTimer invalidate];
    }
}

- (void)onPressedBtn3:(UIButton *)sender
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
            [notDones addObject:[NSString stringWithFormat:@"(%@)",@(idx + 1)]];
        }
    }];
    
    if (notDones.count == self.items.count) {
        canSubmit = YES;
    }
    
    if (!done) {
        [[OTSAlertView alertWithMessage:@"当前考试一题未做" andCompleteBlock:nil] show];
        return;
    }
    else if (!canSubmit) {
        WEAK_SELF;
        NSString *noteDone = [notDones componentsJoinedByString:@","];
        [[OTSAlertView alertWithTitle:@"未做的题目" message:noteDone leftBtn:@"继续做题" rightBtn:@"提交" extraData:nil andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                STRONG_SELF;
                [self submitExam];
            }
        }] show];
        return;
    }
    
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
    json[@"score"] = vo.getScore.stringValue;
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

- (void)jumpToNext
{
    if (![self.currentTVC.itemVO isNeedGoToNext]) {
        return ;
    }
    
    ItemVO *vo = self.items[[self.items indexOfObject:self.currentTVC.itemVO] + 1];
    
    if (!vo) {
        return;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:vo];
    
    if (!vc) {
        return;
    }
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configTabBar];
                  }];
}

@end
