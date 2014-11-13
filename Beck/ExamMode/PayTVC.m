//
//  PayTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PayTVC.h"

@interface PayTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation PayTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"积分支付", @"支付宝支付"];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toPayByIntegration" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"toPayByAlipay" sender:nil];
    }
}

@end
