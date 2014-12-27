//
//  ExamStatisticDetailTVC.m
//  Beck
//
//  Created by Aimy on 14/12/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamStatisticDetailTVC.h"

#import "ViewItemPVC.h"

@interface ExamStatisticDetailTVC ()

@property (nonatomic, strong) NSArray *exams;

@end

@implementation ExamStatisticDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *exam = self.exam;
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"details";
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
                self.exams = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询考试失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *exam = self.exams[indexPath.row];
    
    UILabel *timeLbl = (UILabel *)[cell.contentView viewWithTag:999];
    timeLbl.text = [NSString stringWithFormat:@"日期：%@",exam[@"time"]];
    UILabel *rightLbl = (UILabel *)[cell.contentView viewWithTag:888];
    rightLbl.text = [NSString stringWithFormat:@"答对：%@题",exam[@"rightAmount"]];
    UILabel *wrongLbl = (UILabel *)[cell.contentView viewWithTag:777];
    wrongLbl.text = [NSString stringWithFormat:@"答错：%@题",exam[@"wrongAmount"]];
    UILabel *correctLbl = (UILabel *)[cell.contentView viewWithTag:666];
    correctLbl.text = [NSString stringWithFormat:@"正确率：%@",exam[@"correct"]];
    UIButton *scoreBtn = (UIButton *)[cell.contentView viewWithTag:555];
    [scoreBtn setTitle:[NSString stringWithFormat:@"成绩：%@分",exam[@"score"]] forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *exam = self.exams[indexPath.row];
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
        itemVO.canShowNote = NO;
        itemVO.canChange = NO;
        
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
