//
//  BeckMCTVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckMCTVC.h"

@interface BeckMCTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation BeckMCTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"发现新版本"];
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