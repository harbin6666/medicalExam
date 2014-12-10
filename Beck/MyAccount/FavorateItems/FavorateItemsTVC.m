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

@property (nonatomic, strong) NSArray *items;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
    
    [self changeValue:self.segmentedControl];
}

- (IBAction)changeValue:(UISegmentedControl *)sender {
    [self showLoading];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    
    if (sender.selectedSegmentIndex == 0) {
        params[@"token"] = @"subject";
    }
    else if (sender.selectedSegmentIndex == 1) {
        params[@"token"] = @"outline";
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    else if (sender.selectedSegmentIndex == 2)  {
        params[@"token"] = @"type";
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    else {
        params[@"token"] = @"time";
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userCollectionAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.items = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"登录失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavorateItemsCell" forIndexPath:indexPath];
    NSDictionary *item = self.items[indexPath.row];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = item[@"subjectName"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = item[@"outlineName"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2)  {
        cell.textLabel.text = item[@"customName"];
    }
    else {
        cell.textLabel.text = nil;
    }
    
    cell.detailTextLabel.text = item[@"count"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = self.items[indexPath.row];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
//        params[@"outlineId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }

    
    [self getValueWithBeckUrl:@"/front/userCollectionAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        
    }];
}

@end
