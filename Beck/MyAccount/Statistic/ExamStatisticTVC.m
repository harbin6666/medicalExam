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
#import "ViewItemPVC.h"

@interface ExamStatisticTVC ()

@property (nonatomic, strong) NSArray *exams;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ExamStatisticTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.segmentedControl = (UISegmentedControl *)self.tableView.tableHeaderView;
    CGRect rc = self.segmentedControl.bounds;
    rc.size.height = 44;
    self.segmentedControl.bounds = rc;
    
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSUnderlineStyleAttributeName:@4.f} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeValue:self.segmentedControl];
}

- (IBAction)changeValue:(UISegmentedControl *)sender {
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"list";
    params[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"];
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
    cell.countLbl.text = [NSString stringWithFormat:@"考试次数：%@次",exam[@"examName"]];
    cell.highLbl.text = [NSString stringWithFormat:@"最高分：%@分",exam[@"highest"]];
    cell.lowLbl.text = [NSString stringWithFormat:@"最低分：%@分",exam[@"lowGrade"]];
    cell.avgLabel.text = [NSString stringWithFormat:@"平均分：%@分",exam[@"average"]];
    
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
                [self createItems:aResponseObject[@"list"]];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询考试详情失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)createItems:(NSString *)answers
{
    NSMutableArray *items = @[].mutableCopy;
    NSArray *answerStrings = [answers componentsSeparatedByString:@","];
    [answerStrings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *answer = obj;
        ItemVO *vo = [ItemVO createWithAnswer:answer];
        [items addObject:vo];
    }];
    
    if (!items.count) {
        return ;
    }
    
    [self performSegueWithIdentifier:@"toNext" sender:items];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewItemPVC *vc = segue.destinationViewController;
    vc.items = sender;
}

@end