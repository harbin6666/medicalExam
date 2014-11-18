//
//  ChooseQuestionBankTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ChooseQuestionBankTVC.h"

#import "UIView+create.h"

@interface ChooseQuestionBankTVC ()

@property (nonatomic, strong) NSArray *questionBanks;

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseQuestionBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.questionBanks = @[@"药事管理与法规", @"药理学", @"药物分析", @"药剂学", @"药物化学", @"药学综合知识与技能"];
    
    self.numbers = @[].mutableCopy;
    
    [[AFSQLManager sharedManager] performQuery:@"select a.exam_subject, (select count(b.exam_subject) from question_library as b where b.exam_subject == a.exam_subject) from question_library as a" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
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
    lbl.text = @"   章节复习题";
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
