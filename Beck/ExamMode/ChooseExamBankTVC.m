//
//  ChooseExamBankTVC.m
//  Beck
//
//  Created by Aimy on 14/11/18.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseExamBankTVC.h"

@interface ChooseExamBankTVC ()

@property (nonatomic, strong) NSArray *questionBanks;

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseExamBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.questionBanks = @[@"药事管理与法规", @"药理学", @"药物分析", @"药剂学", @"药物化学", @"药学综合知识与技能"];
    
    self.numbers = @[].mutableCopy;
    
    [[AFSQLManager sharedManager] performQuery:@"select distinct a.exam_subject, (select count(b.exam_subject) from question_library as b where b.exam_subject == a.exam_subject and type == 2) from question_library as a where type == 2" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
        if (finished) {
            [self.tableView reloadData];
        }
        else {
            [self.numbers addObject:row[1]];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lbl = [UILabel viewWithFrame:CGRectMake(10, 0, 300, 30)];
    lbl.backgroundColor = [UIColor lightGrayColor];
    lbl.text = @"   考试科目";
    return lbl;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.questionBanks[indexPath.row];
    
    NSString *num = self.numbers[indexPath.row];
    if (num) {
        cell.detailTextLabel.text = num;
    }
    else {
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

@end
