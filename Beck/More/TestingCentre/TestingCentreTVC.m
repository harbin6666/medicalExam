//
//  TestingCentreTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "TestingCentreTVC.h"

#import "TestingCentreCategoryTVC.h"

@interface TestingCentreTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation TestingCentreTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examOutlineAct.htm" params:@{@"token":@"userList",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (anError) {
            [[OTSAlertView alertWithMessage:@"获取高频考点章节失败" andCompleteBlock:nil] show];
        }
        else {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.names = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *infos = self.names[indexPath.row];
    cell.textLabel.text = infos[@"courseName"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TestingCentreCategoryTVC *vc = segue.destinationViewController;
    vc.infos = self.names[self.tableView.indexPathForSelectedRow.row];
}

@end
