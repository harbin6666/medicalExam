//
//  ChooseSectionTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ChooseSectionTVC.h"

#import "ItemVO.h"
#import "PracticeModePVC.h"

@interface ChooseSectionTVC ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSString *examOutlineId;

@end

@implementation ChooseSectionTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examOutlineAct.htm" params:@{@"token":@"userExamOutline",@"subjectId":self.subjectId,@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.sections = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取章节练习失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *section = self.sections[indexPath.row];
    
    cell.textLabel.text = section[@"courseName"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@题",section[@"number"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showLoading];
    WEAK_SELF;
    NSDictionary *section = self.sections[indexPath.row];
    self.examOutlineId = section[@"id"];
    
    if (!self.examOutlineId) {
        [[OTSAlertView alertWithMessage:@"获取章节练习试题失败" andCompleteBlock:nil] show];
        return ;
    }
    
    [self getValueWithBeckUrl:@"/front/examOutlineAct.htm" params:@{@"token":@"testQuestions",@"subjectId":self.subjectId,@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"],@"examOutlineId":self.examOutlineId} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSMutableArray *ids = aResponseObject[@"list"];
                if (ids.count > 0) {
                    [self createItems:ids];
                }
                else {
                    [[OTSAlertView alertWithMessage:@"获取章节练习试题失败" andCompleteBlock:nil] show];
                }
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取章节练习试题失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)createItems:(NSArray *)ids
{
    NSMutableArray *items = @[].mutableCopy;
    [ids enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *infos = obj;
        [infos[@"titleList"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *itemInfo = obj;
            ItemVO *itemVO = [ItemVO createWithItemId:itemInfo[@"titleId"] andType:[infos[@"typeId"] intValue]];
            itemVO.outlineId = self.examOutlineId;
            itemVO.subjectId = self.subjectId;
            if ([itemInfo[@"type"] intValue] == 1) {
                itemVO.hasNote = YES;
            }
            
            if (itemVO) {
                [items addObject:itemVO];
            }
        }];
    }];
    
    [self performSegueWithIdentifier:@"toNext" sender:items];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PracticeModePVC *vc = segue.destinationViewController;
    vc.examOutlineId = self.examOutlineId;
    vc.subjectId = self.subjectId;
    vc.items = sender;
}

@end
