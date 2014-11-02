//
//  ExamStatisticTVC.m
//  Beck
//
//  Created by Aimy on 14/11/2.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamStatisticTVC.h"

@interface ExamStatisticTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation ExamStatisticTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"职业中药师考试模拟测试联系题库", @"职业中药师考试模拟测试联系题库", @"职业中药师考试模拟测试联系题库", @"职业中药师考试模拟测试联系题库"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

@end
