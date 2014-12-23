//
//  FavorateItemsTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "FavorateItemsTVC.h"

#import "ItemVO.h"
#import "ViewItemPVC.h"

@interface FavorateItemsTVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *items;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FavorateItemsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl = (UISegmentedControl *)self.tableView.tableHeaderView;
    CGRect rc = self.segmentedControl.bounds;
    rc.size.height = 44;
    self.segmentedControl.bounds = rc;
    
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSUnderlineStyleAttributeName:@4.f} forState:UIControlStateSelected];
    
    [self changeValue:self.segmentedControl];
}

- (IBAction)changeValue:(UISegmentedControl *)sender {
    [self showLoading];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"subjectId"] = self.subjectId;
    
    if (sender.selectedSegmentIndex == 0) {
        params[@"token"] = @"outline";
    }
    else if (sender.selectedSegmentIndex == 1)  {
        params[@"token"] = @"type";
    }
    else {
        params[@"token"] = @"time";
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
                if (self.segmentedControl.selectedSegmentIndex == 2) {
                    NSDictionary *dict = [aResponseObject[@"list"] firstObject];
                    NSMutableArray *items = @[].mutableCopy;
                    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                        [items addObject:@{key:obj}];
                    }];
                    self.items = items;
                }
                else {
                    self.items = aResponseObject[@"list"];
                }
                
            }
        }
        else {
            self.items = nil;
            [[OTSAlertView alertWithMessage:@"获取收藏失败" andCompleteBlock:nil] show];
        }
        
        [self.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *item = self.items[indexPath.row];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = item[@"outlineName"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1)  {
        cell.textLabel.text = item[@"customName"];
    }
    else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"今天";
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"三天";
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"七天";
        }
        else {
            cell.textLabel.text = @"更久";
        }
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 2) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [item[@"today"] stringValue];
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [item[@"threeDays"] stringValue];
        }
        else if (indexPath.row == 2) {
            cell.detailTextLabel.text = [item[@"sevenDays"] stringValue];
        }
        else {
            cell.detailTextLabel.text = [item[@"longer"] stringValue];
        }
    }
    else {
        cell.detailTextLabel.text = item[@"count"];
    }
    
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = self.items[indexPath.row];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"subjectId"] = self.subjectId;
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        params[@"token"] = @"outlineList";
        params[@"outlineId"] = item[@"outlineId"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        params[@"token"] = @"typeList";
        params[@"type"] = item[@"customId"];
    }
    else {
        params[@"token"] = @"timeList";
        if (indexPath.row == 0) {
            params[@"time"] = @0;
        }
        else if (indexPath.row == 1) {
            params[@"time"] = @3;
        }
        else if (indexPath.row == 2) {
            params[@"time"] = @7;
        }
        else {
            params[@"time"] = @8;
        }
    }
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userCollectionAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSMutableArray *ids = [NSMutableArray array];
                NSArray *infos = aResponseObject[@"list"];
                [infos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSDictionary *info = obj;
                    NSNumber *type = info[@"typeId"];
                    NSArray *titleList = info[@"titleList"];
                    [titleList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSDictionary *itemInfo = obj;
                        ItemVO *itemVO = [ItemVO createWithItemId:[itemInfo[@"titleId"] stringValue] andType:[type intValue]];
                        itemVO.canShowNote = NO;
                        
                        if (itemVO) {
                            [ids addObject:itemVO];
                        }
                    }];
                }];
                
                if (ids.count > 0) {
                    [self performSegueWithIdentifier:@"toNext" sender:ids];
                }
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取收藏列表失败" andCompleteBlock:nil] show];
        }
        [self hideLoading];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewItemPVC *vc = segue.destinationViewController;
    vc.items = sender;
}

@end
