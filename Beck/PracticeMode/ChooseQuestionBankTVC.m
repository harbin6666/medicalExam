//
//  ChooseQuestionBankTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ChooseQuestionBankTVC.h"

#import "ChooseSectionTVC.h"

@interface ChooseQuestionBankTVC ()

@property (nonatomic, strong) NSArray *questionBanks;

@property (nonatomic, strong) NSString *subjectId;

@end

@implementation ChooseQuestionBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userExamSubjectAct.htm" params:@{@"token":@"userExamSubject",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.questionBanks = aResponseObject[@"list"];
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
    return self.questionBanks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *questionBank = self.questionBanks[indexPath.row];
    
    cell.textLabel.text = questionBank[@"subjectName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *questionBank = self.questionBanks[indexPath.row];
    self.subjectId = questionBank[@"id"];
    [self performSegueWithIdentifier:@"toNext" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ChooseSectionTVC *vc = segue.destinationViewController;
    vc.subjectId = self.subjectId;
}

@end
