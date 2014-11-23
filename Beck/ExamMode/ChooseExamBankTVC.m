//
//  ChooseExamBankTVC.m
//  Beck
//
//  Created by Aimy on 14/11/18.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseExamBankTVC.h"

#import "ExamModePVC.h"

@interface ChooseExamBankTVC ()

@property (nonatomic, strong) NSArray *questionBanks;

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseExamBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examPaperAct.htm" params:@{@"token":@"list",@"subjectId":[[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"],@"type":(self.fromExam ? @"2" : @"1")} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.questionBanks = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"登录失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionBanks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *questionBank = self.questionBanks[indexPath.row];
    
    cell.textLabel.text = questionBank[@"paperName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showLoading];
//    NSString *sql = nil;
//    WEAK_SELF;
//    NSMutableArray *ids = [NSMutableArray array];
//    [[AFSQLManager sharedManager] performQuery:sql withBlock:^(NSArray *row, NSError *error, BOOL finished) {
//        NSLog(@"%@,%@,%d",row,error,finished);
//        if (finished) {
//            STRONG_SELF;
//            [self hideLoading];
//            [self performSegueWithIdentifier:@"toNext" sender:ids];
//        }
//        else {
//            ItemVO *vo = [ItemVO createWithItemId:row[0] andType:[row[1] intValue]];
//            [ids addObject:vo];
//        }
//    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ExamModePVC *vc = segue.destinationViewController;
    vc.items = sender;
}

@end
