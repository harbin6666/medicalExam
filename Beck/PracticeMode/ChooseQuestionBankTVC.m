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

@end

@implementation ChooseQuestionBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.questionBanks = @[@[@"药事管理与法规", @"药理学", @"药物分析", @"药剂学", @"药物化学", @"药学综合知识与技能"], @[@"药事管理与法规", @"药理学", @"药物分析", @"药剂学", @"药物化学", @"药学综合知识与技能"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    if (section == 0) {
        lbl.text = @"   章节复习题";
    }
    else {
        lbl.text = @"   综合练习";
    }
    return lbl;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *names = self.questionBanks[indexPath.section];
    
    cell.textLabel.text = names[indexPath.row];
    
    return cell;
}

@end
