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
    self.names = @[@"高频考点", @"考试科目", @"意见反馈", @"使用帮助", @"软件分享", @"版本更新", @"个人档案"];
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
    else {
        [self performSegueWithIdentifier:@"toPersonalFile" sender:nil];
    }
}

@end
