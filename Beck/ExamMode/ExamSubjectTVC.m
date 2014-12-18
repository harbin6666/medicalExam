//
//  ExamSubjectTVC.m
//  Beck
//
//  Created by Aimy on 14/12/18.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamSubjectTVC.h"

#import "ExamHomeTVC.h"

@interface ExamSubjectTVC ()

@property (nonatomic, strong) NSArray *subjects;

@end

@implementation ExamSubjectTVC

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
                self.subjects = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取试卷列表失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *subjects = self.subjects[indexPath.row];
    
    cell.textLabel.text = subjects[@"subjectName"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSDictionary *subjects = self.subjects[path.row];
    ExamHomeTVC *vc = segue.destinationViewController;
    vc.subjectId = subjects[@"id"];
}

@end
