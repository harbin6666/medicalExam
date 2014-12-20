//
//  ExamStatisticDetail.m
//  Beck
//
//  Created by Aimy on 14/12/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamStatisticDetailVC.h"

#import "ViewItemPVC.h"
#import "ItemVO.h"

@interface ExamStatisticDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ExamStatisticDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbl1.text = [NSString stringWithFormat:@"第%d次考试",(int)self.index];
    self.lbl2.text = [NSString stringWithFormat:@"日期：%@",self.detail[@"time"]];
    self.lbl3.text = [NSString stringWithFormat:@"答对：%@题",self.detail[@"rightAmount"]];
    self.lbl4.text = [NSString stringWithFormat:@"答错：%@题",self.detail[@"wrongAmount"]];
    self.lbl5.text = [NSString stringWithFormat:@"正确率：%@",self.detail[@"correct"]];
    [self.btn setTitle:[NSString stringWithFormat:@"成绩：%@分",self.detail[@"score"]] forState:UIControlStateNormal];
}
- (IBAction)onPressedBtn:(id)sender
{
    NSDictionary *exam = self.detail;
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"paper";
    params[@"paperId"] = exam[@"id"];
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userExamAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSString *answer = aResponseObject[@"list"];
                NSArray *answers = [answer componentsSeparatedByString:@","];
                if (answers.count) {
                    [self createItems:answers];
                }
                else {
                    [[OTSAlertView alertWithMessage:@"查询考试题目失败" andCompleteBlock:nil] show];
                }
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询考试题目失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)createItems:(NSArray *)ids
{
    NSMutableArray *items = @[].mutableCopy;
    [ids enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *answer = obj;
        ItemVO *itemVO = [ItemVO createWithExamAnswer:answer];
        
        if (itemVO) {
            [items addObject:itemVO];
        }
    }];
    
    [self performSegueWithIdentifier:@"toNext" sender:items];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewItemPVC *vc = segue.destinationViewController;
    vc.subjectId = self.subjectId;
    vc.items = sender;
}

@end
