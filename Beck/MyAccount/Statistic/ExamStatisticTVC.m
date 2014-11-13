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
    ExamStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.titleLbl.text = @"职业中药师考试模拟测试联系题库";
    cell.dateLbl.text = [NSDate date].description;
    cell.itemCountLbl.text = @"100道";
    cell.infoLbl.text = @"对：80 错：20 正确率：80%";
    
    return cell;
}

@end
