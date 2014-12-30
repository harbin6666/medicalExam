//
//  MoreHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MoreHomeTVC.h"

@interface MoreHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation MoreHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"高频考点", @"考试科目", @"意见反馈", @"使用帮助", @"软件分享", @"版本更新", @"个人档案", @"我的消息", @"题库更新"];
    
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:@"value"];
    if (!value) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1.0" forKey:@"value"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
    return self.names.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"more%li",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toTestingCentre" sender:nil];
    }
    else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"toChooseExam" sender:nil];
    }
    else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"toFeedBack" sender:nil];
    }
    else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"toHelp" sender:nil];
    }
    else if (indexPath.row == 4){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if (indexPath.row == 5){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        [self showLoading];
        WEAK_SELF;
        [self getValueWithBeckUrl:@"/front/versionUpdateAct.htm" params:@{@"token":@"ios",@"paramValue":currentVersion} CompleteBlock:^(id aResponseObject, NSError *anError) {
            STRONG_SELF;
            [self hideLoading];
            if (!anError) {
                NSNumber *errorcode = aResponseObject[@"errorcode"];
                if (errorcode.boolValue) {
                    [[OTSAlertView alertWithMessage:@"不需要更新" andCompleteBlock:nil] show];
                }
                else {
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:aResponseObject[@"url"]]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:aResponseObject[@"url"]]];
                    }
                    else {
                        [[OTSAlertView alertWithMessage:@"无法更新" andCompleteBlock:nil] show];
                    }
                }
            }
            else {
                [[OTSAlertView alertWithMessage:@"获取更新失败" andCompleteBlock:nil] show];
            }
        }];
    }
    else if (indexPath.row == 6) {
        [self performSegueWithIdentifier:@"toPersonalFile" sender:nil];
    }
    else if (indexPath.row == 7) {
        [self performSegueWithIdentifier:@"toMessage" sender:nil];
    }
    else if (indexPath.row == 8) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self showLoadingWithMessage:nil onView:self.navigationController.view hideAfter:0.f];
        NSMutableDictionary *params = @{}.mutableCopy;
        params[@"token"] = @"db";
        params[@"paramValue"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"value"];
        
        WEAK_SELF;
        [self getValueWithBeckUrl:@"/front/versionUpdateAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
            STRONG_SELF;
            [self hideLoadingOnView:self.navigationController.view];
            if (!anError) {
                NSNumber *errorcode = aResponseObject[@"errorcode"];
                if (errorcode.boolValue) {
                    [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
                }
                else {
                    [self updateDB];
                }
            }
            else {
                [[OTSAlertView alertWithMessage:@"获取更新失败" andCompleteBlock:nil] show];
            }
        }];
    }
}

- (void)updateDB
{
    [self showLoadingWithMessage:nil onView:self.navigationController.view hideAfter:0.f];
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"database";
    
    NSString *sql1 = @"select max(choice_id) from choice_questions";
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {

        }
        else {
            params[@"choiceId"] = row.firstObject;
        }
    }];
    
    NSString *sql2 = @"select max(id) from compatibility_info";
    [[AFSQLManager sharedManager] performQuery:sql2 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            
        }
        else {
            params[@"compatId"] = row.firstObject;
        }
    }];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/customQuestionTypeAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSDictionary *dateBaseBean = aResponseObject[@"dateBaseBean"];
                
                NSMutableArray *sqls = @[].mutableCopy;
                
                NSArray *choiceItemList = dateBaseBean[@"choiceItemList"];
                
                if (choiceItemList.count) {
                    [sqls addObjectsFromArray:choiceItemList];
                }
                
                NSArray *choiceList = dateBaseBean[@"choiceList"];
                
                if (choiceList.count) {
                    [sqls addObjectsFromArray:choiceList];
                }
                
                NSArray *compatItemList = dateBaseBean[@"compatItemList"];
                
                if (compatItemList.count) {
                    [sqls addObjectsFromArray:compatItemList];
                }
                
                NSArray *compatList = dateBaseBean[@"compatList"];
                
                if (compatList.count) {
                    [sqls addObjectsFromArray:compatList];
                }
                
                NSArray *compatQuestionList = dateBaseBean[@"compatQuestionList"];
                
                if (compatQuestionList.count) {
                    [sqls addObjectsFromArray:compatQuestionList];
                }
                
                [sqls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *sql = obj;
                    [self performSql:sql];
                }];
                
                [[NSUserDefaults standardUserDefaults] setObject:aResponseObject[@"value"] forKey:@"value"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取更新失败" andCompleteBlock:nil] show];
        }
        
        [self hideLoadingOnView:self.navigationController.view];
    }];
}

- (void)performSql:(NSString *)sql
{
    [[AFSQLManager sharedManager] performQuery:sql withBlock:nil];
}

@end
