//
//  ExamStatisticTVC.m
//  Beck
//
//  Created by Aimy on 14/11/2.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamStatisticTVC.h"

#import "ExamStatisticCell.h"
#import "ItemVO.h"
#import "ExamStatisticDetailTVC.h"

@interface ExamStatisticTVC ()

@property (nonatomic, strong) NSArray *exams;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ExamStatisticTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.segmentedControl = (UISegmentedControl *)self.tableView.tableHeaderView;
    CGRect rc = self.segmentedControl.bounds;
    rc.size.height = 44;
    self.segmentedControl.bounds = rc;
    
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSUnderlineStyleAttributeName:@4.f} forState:UIControlStateSelected];
    
    [self changeValue:self.segmentedControl];
}

- (IBAction)changeValue:(UISegmentedControl *)sender {
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"list";
    params[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    params[@"subjectId"] = self.subjectId;
    params[@"type"] = @(self.segmentedControl.selectedSegmentIndex + 1).stringValue;
    
    self.exams = nil;
    
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
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询统计失败" andCompleteBlock:nil] show];
        }
        
        [self.tableView reloadData];
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
    
    cell.titleLbl.text = exam[@"examName"];
    cell.countLbl.text = [NSString stringWithFormat:@"考试次数：%@次",exam[@"count"]];
    cell.highLbl.text = [NSString stringWithFormat:@"最高分：%@分",exam[@"highest"]];
    cell.lowLbl.text = [NSString stringWithFormat:@"最低分：%@分",exam[@"lowGrade"]];
    cell.avgLabel.text = [NSString stringWithFormat:@"平均分：%@分",exam[@"average"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary *exam = self.exams[self.tableView.indexPathForSelectedRow.row];
    ExamStatisticDetailTVC *vc = segue.destinationViewController;
    vc.exam = exam;
    vc.subjectId = self.subjectId;
}

@end
