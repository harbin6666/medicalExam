//
//  MyAccountHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MyAccountHomeTVC.h"

@interface MyAccountHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation MyAccountHomeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"统计", @"查看笔记", @"题目收藏", @"错题重做"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toStatistic" sender:nil];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"toNotes" sender:nil];
    }
    else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"toFavorate" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"toError" sender:nil];
    }
}

@end
