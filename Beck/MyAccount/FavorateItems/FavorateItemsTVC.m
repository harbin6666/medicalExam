//
//  FavorateItemsTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "FavorateItemsTVC.h"

@interface FavorateItemsTVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation FavorateItemsTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.segmentedControl = (UISegmentedControl *)self.tableView.tableHeaderView;
    CGRect rc = self.segmentedControl.bounds;
    rc.size.height = 44;
    self.segmentedControl.bounds = rc;
    
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSUnderlineStyleAttributeName:@4.f} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavorateItemsCell" forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

@end
