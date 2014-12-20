//
//  MyAccountSubjectTVC.m
//  Beck
//
//  Created by Aimy on 14/12/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MyAccountSubjectTVC.h"

#import "ExamStatisticTVC.h"
#import "PractiseStatisticCVC.h"
#import "ErrorItemsTVC.h"
#import "FavorateItemsTVC.h"
#import "NotesTVC.h"

@interface MyAccountSubjectTVC ()

@property (nonatomic, strong) NSArray *subjects;

@end

@implementation MyAccountSubjectTVC

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.toType) {
        case toPractise:
            [self performSegueWithIdentifier:@"toPractise" sender:nil];
            break;
        case toExam:
            [self performSegueWithIdentifier:@"toExam" sender:nil];
            break;
        case toNotes:
            [self performSegueWithIdentifier:@"toNotes" sender:nil];
            break;
        case toFavorate:
            [self performSegueWithIdentifier:@"toFavorate" sender:nil];
            break;
        case toError:
            [self performSegueWithIdentifier:@"toError" sender:nil];
            break;
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary *subjects = self.subjects[self.tableView.indexPathForSelectedRow.row];
    NSString *subjectId = subjects[@"id"];
    switch (self.toType) {
        case toPractise:
        {
            PractiseStatisticCVC *vc = segue.destinationViewController;
            vc.subjectId = subjectId;
        }
            break;
        case toExam:
        {
            ExamStatisticTVC *vc = segue.destinationViewController;
            vc.subjectId = subjectId;
        }
            break;
        case toNotes:
        {
            NotesTVC *vc = segue.destinationViewController;
            vc.subjectId = subjectId;
        }
            break;
        case toFavorate:
        {
            FavorateItemsTVC *vc = segue.destinationViewController;
            vc.subjectId = subjectId;
        }
            break;
        case toError:
        {
            ErrorItemsTVC *vc = segue.destinationViewController;
            vc.subjectId = subjectId;
        }
            break;
        default:
            break;
    }
}

@end
