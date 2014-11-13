//
//  TestingCentreTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "TestingCentreTVC.h"

@interface TestingCentreTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation TestingCentreTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.names = @[@"药事管理与法规", @"药理学", @"药物分析", @"药剂学", @"药物化学", @"药学综合知识与技能"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestingCentreCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTestingCentreCategory" sender:self];
}

@end
