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
    self.lbl2.text = [NSString stringWithFormat:@"日期：%@",self.detail[@"date"]];
    self.lbl3.text = [NSString stringWithFormat:@"答对：%@题",self.detail[@"right"]];
    self.lbl4.text = [NSString stringWithFormat:@"答错：%@题",self.detail[@"wrong"]];
    self.lbl5.text = [NSString stringWithFormat:@"正确率：%@",self.detail[@"accuracy"]];
    [self.btn setTitle:[NSString stringWithFormat:@"成绩：%@分",self.detail[@"score"]] forState:UIControlStateNormal];
}
- (IBAction)onPressedBtn:(id)sender
{
//    NSDictionary *exam = self.exams[indexPath.row];
//    NSMutableDictionary *params = @{}.mutableCopy;
//    params[@"token"] = @"paper";
//    params[@"paperId"] = exam[@"id"];
//    
//    [self showLoading];
//    WEAK_SELF;
//    [self getValueWithBeckUrl:@"/front/userExamAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
//        STRONG_SELF;
//        [self hideLoading];
//        if (!anError) {
//            NSNumber *errorcode = aResponseObject[@"errorcode"];
//            if (errorcode.boolValue) {
//                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
//            }
//            else {
//                [self createItems:aResponseObject[@"list"]];
//            }
//        }
//        else {
//            [[OTSAlertView alertWithMessage:@"查询考试详情失败" andCompleteBlock:nil] show];
//        }
//    }];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"token"] = @"details";
    params[@"exerciseId"] = self.detail[@"id"];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userExerciseAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSMutableArray *ids = aResponseObject[@"list"];
                if (ids.count > 0) {
                    [self createItems:ids];
                }
                else {
                    [[OTSAlertView alertWithMessage:@"查询答题记录失败" andCompleteBlock:nil] show];
                }
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询答题记录失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)createItems:(NSArray *)ids
{
    NSMutableArray *items = @[].mutableCopy;
    [ids enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *infos = obj;
        [infos[@"titleList"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *itemInfo = obj;
            ItemVO *itemVO = [ItemVO createWithItemId:itemInfo[@"titleId"] andType:[infos[@"typeId"] intValue]];
            //            itemVO.outlineId = self.examOutlineId;
            itemVO.subjectId = self.subjectId;
            if ([itemInfo[@"type"] intValue] == 1) {
                itemVO.hasNote = YES;
            }
            
            if (itemVO) {
                [items addObject:itemVO];
            }
        }];
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
