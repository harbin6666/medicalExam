//
//  PersionalFileTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PersionalFileTVC.h"

#import "PersionalFileTableViewHeader.h"

@interface PersionalFileTVC ()

@property (nonatomic, strong) PersionalFileTableViewHeader *header;

@property (nonatomic, strong) NSArray *names;

@end

@implementation PersionalFileTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.header = [PersionalFileTableViewHeader viewWithFrame:CGRectMake(0, 0, 320, 100)];
    self.header.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = self.header;
    
    self.names = @[@"我的积分", @"消息提醒", @"修改密码", @"支付信息"];
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
    return self.names.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    if (indexPath.row == 1) {
        UISwitch *sw = [UISwitch new];
        sw.on = YES;
        cell.accessoryView = sw;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {

    }
    else if (indexPath.row == 1){
        
    }
    else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"toModifyPassword" sender:nil];
    }
    else if (indexPath.row == 3){

    }
    else if (indexPath.row == 4){

    }
}

@end
