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

@end

@implementation ChooseSectionTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examOutlineAct.htm" params:@{@"token":@"testQuestions",@"subjectId":[[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"],@"examOutlineId":self.examOutlineId,@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
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
    
    cell.textLabel.text = section[@"suctom"];
    NSArray *items = section[@"titleList"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d题",(int)items.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sql = nil;
    NSDictionary *section = self.sections[indexPath.row];
    NSNumber *type = section[@"typeId"];
    switch (type.integerValue) {
        case ItemTypeChoice:
        {
            sql = @"select choice_id, custom_id from choice_questions where custom_id == 1";
        }
            break;
        case ItemTypeDecision:
        {
            sql = @"select decision_id, custom_id from decision_question where custom_id == 2";
        }
            break;
        case ItemTypeMultiChoice:
        {
            sql = @"select choice_id, custom_id from choice_questions where custom_id == 3";
        }
            break;
            
        case ItemTypeCompatibility:
        {
            sql = @"select id, custom_id from compatibility_info where custom_id == 4";
        }
            break;
            
        case ItemTypeSpace:
        {
            sql = @"select space_id, custom_id from space_question where custom_id == 5";
        }
            break;
            
        default:
            break;
    }
    
    [self showLoading];
    WEAK_SELF;
    NSMutableArray *ids = [NSMutableArray array];
    [[AFSQLManager sharedManager] performQuery:sql withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
        if (finished) {
            STRONG_SELF;
            [self hideLoading];
            [self performSegueWithIdentifier:@"toNext" sender:ids];
        }
        else {
            ItemVO *vo = [ItemVO createWithItemId:row[0] andType:[row[1] intValue]];
            [ids addObject:vo];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PracticeModePVC *vc = segue.destinationViewController;
    vc.items = sender;
}

@end
