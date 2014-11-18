//
//  ChooseExamTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseExamTVC.h"

@interface ChooseExamTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation ChooseExamTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@[@"药理学", @"药物分析", @"药剂学", @"药物化学"],@[@"药理学", @"药物分析", @"药剂学", @"药物化学"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lbl = [UILabel viewWithFrame:CGRectMake(10, 0, 300, 30)];
    lbl.backgroundColor = [UIColor lightGrayColor];
    lbl.frame = CGRectMake(0, 0, 320, 44);
    
    if (section == 0) {
        lbl.text = @"   职业药师(中药)";
    }
    else {
        lbl.text = @"   职业药师(西药)";
    }
    
    return lbl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *secondNames = self.names[section];
    return secondNames.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *secondNames = self.names[indexPath.section];
    cell.textLabel.text = secondNames[indexPath.row];
    
    return cell;
}

@end
