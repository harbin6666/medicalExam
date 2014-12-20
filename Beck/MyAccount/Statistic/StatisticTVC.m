//
//  StatisticTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "StatisticTVC.h"

#import "MyAccountSubjectTVC.h"

@interface StatisticTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation StatisticTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.names = @[@"练习统计", @"考试统计"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyAccountSubjectTVC *vc = segue.destinationViewController;
    NSIndexPath *path = self.tableView.indexPathForSelectedRow;
    if (path.row == 0) {
        vc.toType = toPractise;
    }
    else {
        vc.toType = toExam;
    }
}

@end
