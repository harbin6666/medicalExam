//
//  ChooseExamTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseExamTVC.h"

@interface ChooseExamTVC ()

@property (nonatomic, strong) NSArray *subjectPositions;
@property (nonatomic, strong) NSMutableSet *set;

@end

@implementation ChooseExamTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    self.set = [NSMutableSet set];
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/subjectPositionRelationAct.htm" params:@{@"token":@"subjectPositionRelation",@"titleId":[[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.subjectPositions = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取考试科目失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subjectPositions.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *subjectPosition = self.subjectPositions[indexPath.row];
    cell.textLabel.text = subjectPosition[@"subjectName"];
    
    if ([self.set containsObject:indexPath]) {
        cell.imageView.highlighted = YES;
    }
    else {
        cell.imageView.highlighted = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.set containsObject:indexPath]) {
        [self.set removeObject:indexPath];
    }
    else {
        [self.set addObject:indexPath];
    }
    
    [tableView reloadData];
}

- (IBAction)onPressedBtn:(id)sender {
    if (!self.set.count) {
        [[OTSAlertView alertWithMessage:@"请选择考试科目" andCompleteBlock:nil] show];
        return;
    }
    
    __block NSString *ids = @"";
    
    WEAK_SELF;
    [self.set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        STRONG_SELF;
        NSIndexPath *path = obj;
        NSDictionary *subjectPosition = self.subjectPositions[path.row];
        ids = [ids stringByAppendingFormat:@"%@,",subjectPosition[@"id"]];
    }];
    
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userExamSubjectAct.htm" params:@{@"token":@"update",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"],@"subjectIdList":ids} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"设置考试科目失败" andCompleteBlock:nil] show];
        }
    }];
}

@end
