//
//  ErrorItemsTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ErrorItemsTVC.h"

#import "ItemVO.h"
#import "ViewItemPVC.h"

@interface ErrorItemsTVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *items;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ErrorItemsTVC

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
    [self changeSegmentControl:self.segmentedControl];
}

- (IBAction)changeSegmentControl:(UISegmentedControl *)sender {
    [self showLoading];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    
    if (sender.selectedSegmentIndex == 0) {
        params[@"token"] = @"type";
        params[@"subjectId"] = self.subjectId;
    }
    else if (sender.selectedSegmentIndex == 1)  {
        params[@"token"] = @"errorRate";
        params[@"subjectId"] = self.subjectId;
    }
    else {
        params[@"token"] = @"curve";
        params[@"subjectId"] = self.subjectId;
    }
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userWrongItemAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                if (self.segmentedControl.selectedSegmentIndex == 1) {
                    NSDictionary *dict = [aResponseObject[@"list"] firstObject];
                    NSMutableArray *items = @[].mutableCopy;
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"错一次";
                        infos[@"count"] = dict[@"oneTime"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"错2次";
                        infos[@"count"] = dict[@"twoTime"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"错三次";
                        infos[@"count"] = dict[@"threeTime"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"三次以上";
                        infos[@"count"] = dict[@"threeTimes"];
                        [items addObject:infos];
                    }
                    
                    self.items = items;
                }
                else if (self.segmentedControl.selectedSegmentIndex == 2) {
                    NSDictionary *dict = [aResponseObject[@"list"] firstObject];
                    NSMutableArray *items = @[].mutableCopy;
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"今天";
                        infos[@"count"] = dict[@"today"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"三天";
                        infos[@"count"] = dict[@"threeDays"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"七天";
                        infos[@"count"] = dict[@"sevenDays"];
                        [items addObject:infos];
                    }
                    
                    {
                        NSMutableDictionary *infos = @{}.mutableCopy;
                        infos[@"name"] = @"更久";
                        infos[@"count"] = dict[@"longer"];
                        [items addObject:infos];
                    }
                    
                    self.items = items;
                }
                else {
                    self.items = aResponseObject[@"list"];
                }
            }
        }
        else {
            self.items = nil;
            [[OTSAlertView alertWithMessage:@"获取错题失败" andCompleteBlock:nil] show];
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
        cell.textLabel.text = item[@"customName"];
    }
    else {
        cell.textLabel.text = item[@"name"];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",item[@"count"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = self.items[indexPath.row];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"subjectId"] = self.subjectId;
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        params[@"token"] = @"typeList";
        params[@"type"] = item[@"customId"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        params[@"token"] = @"errorRateList";
        if (indexPath.row == 0) {
            params[@"count"] = @1;
        }
        else if (indexPath.row == 1) {
            params[@"count"] = @2;
        }
        else if (indexPath.row == 2) {
            params[@"count"] = @3;
        }
        else {
            params[@"count"] = @4;
        }
    }
    else {
        params[@"token"] = @"curveList";
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
    [self getValueWithBeckUrl:@"/front/userWrongItemAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
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
                        itemVO.canChange = NO;
                        
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
            [[OTSAlertView alertWithMessage:@"获取错题列表失败" andCompleteBlock:nil] show];
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
