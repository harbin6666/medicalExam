//
//  BeckAchievementTVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckAchievementTVC.h"

@interface BeckAchievementTVC ()

@property (nonatomic, strong) NSArray *sectionNames;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@end

@implementation BeckAchievementTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userAct.htm" params:@{@"token":@"personal",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.sectionNames = @[@"    我的宣章", @"    我的统计", @"    我的积分"];
                self.tableView.tableFooterView = self.footerView;
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取成就失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lbl = [UILabel viewWithFrame:CGRectMake(10, 0, 300, 30)];
    lbl.backgroundColor = [UIColor whiteColor];
    lbl.textColor = [UIColor redColor];
    lbl.text = self.sectionNames[section];
    return lbl;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HonorCell" forIndexPath:indexPath];
    }
    else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StatisticCell" forIndexPath:indexPath];
        cell.textLabel.text = @"您已经做了5套模拟试题，共计500题";
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PointCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"当前积分";
            cell.detailTextLabel.text = @"20";
        }
        else {
            cell.textLabel.text = @"累计积分";
            cell.detailTextLabel.text = @"500";
        }
    }
    
    return cell;
}

@end
