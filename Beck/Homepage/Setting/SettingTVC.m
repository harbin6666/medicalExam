//
//  SettingTVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "SettingTVC.h"

@interface SettingTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation SettingTVC

- (void)awakeFromNib
{
    self.names = @[@"消息提醒",@"选择考试",@"题库更新",@"考试提醒",@"软件设置",@"意见反馈",@"使用帮助",@"软件分享"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell1" forIndexPath:indexPath];
        UISwitch *s = [UISwitch new];
        [s addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = s;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    }
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)onValueChanged:(UISwitch *)sender
{
    
}

@end
