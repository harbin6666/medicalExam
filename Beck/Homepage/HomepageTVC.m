//
//  HomepageTVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "HomepageTVC.h"

#import "HomepageTableViewCell.h"

@interface HomepageTVC ()

@end

@implementation HomepageTVC

- (void)awakeFromNib
{
    CGFloat width = [UIScreen mainScreen].currentMode.size.width / 2 / 3;
    self.tableView.rowHeight = width;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomepageCell" forIndexPath:indexPath];
    
    [cell updateCellWithData:@[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
