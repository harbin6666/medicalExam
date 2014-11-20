//
//  ExamStatisticTVC.m
//  Beck
//
//  Created by Aimy on 14/11/2.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamStatisticTVC.h"

#import "ExamStatisticCell.h"

@interface ExamStatisticTVC ()

@property (nonatomic, strong) NSArray *exams;

@end

@implementation ExamStatisticTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"token"] = @"list";
    params[@"type"] = @"2";
    params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    
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
            [[OTSAlertView alertWithMessage:@"登录查询考试统计失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExamStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *exam = self.exams[indexPath.row];
    
    cell.titleLbl.text = @"职业中药师考试模拟测试联系题库";
    cell.dateLbl.text = [NSDate date].description;
    cell.itemCountLbl.text = @"100道";
    cell.infoLbl.text = @"对：80 错：20 正确率：80%";
    
    return cell;
}

@end
