//
//  ChooseExamBankTVC.m
//  Beck
//
//  Created by Aimy on 14/11/18.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseExamBankTVC.h"

#import "ExamModePVC.h"

@interface ChooseExamBankTVC ()

@property (nonatomic, strong) NSArray *questionBanks;

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseExamBankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examPaperAct.htm" params:@{@"token":@"list",@"subjectId":[[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"],@"type":(self.fromExam ? @"2" : @"1")} CompleteBlock:^(id aResponseObject, NSError *anError) {
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
            [[OTSAlertView alertWithMessage:@"获取试卷列表失败" andCompleteBlock:nil] show];
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
    
    cell.textLabel.text = questionBank[@"paperName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *questionBank = self.questionBanks[indexPath.row];
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/examPaperAct.htm" params:@{@"token":@"content",@"examPaperId":questionBank[@"id"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [self getItemsAndToNext:aResponseObject[@"list"]];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取试题失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)getItemsAndToNext:(NSArray *)infos
{
    [self showLoading];
    NSArray *listComposition = infos.lastObject[@"listComposition"];
    NSMutableArray *ids = [NSMutableArray array];
    [listComposition enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *part = obj;
        NSString *customId = part[@"customId"];
        NSArray *listContent = part[@"listContent"];
        [listContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *item = obj;
            ItemVO *itemVO = [ItemVO createWithItemId:item[@"itemId"] andType:customId.intValue];
            [ids addObject:itemVO];
        }];
    }];
    
    [self performSegueWithIdentifier:@"toNext" sender:ids];
    [self hideLoading];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ExamModePVC *vc = segue.destinationViewController;
    vc.items = sender;
    vc.fromExam = self.fromExam;
}

@end
