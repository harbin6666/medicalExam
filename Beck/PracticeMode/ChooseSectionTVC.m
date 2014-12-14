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
    [self showLoading];
    NSMutableArray *ids = [NSMutableArray array];
    NSDictionary *infos = self.sections[indexPath.row];
    NSNumber *customId = infos[@"typeId"];
    [infos[@"titleList"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *titleId = obj[@"titleId"];
        ItemVO *itemVO = [ItemVO createWithItemId:titleId.stringValue andType:customId.intValue];
        itemVO.outlineId = self.examOutlineId;
        [ids addObject:itemVO];
    }];
    
    if (ids.count > 0) {
        [self performSegueWithIdentifier:@"toNext" sender:ids];
    }
    
    [self hideLoading];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PracticeModePVC *vc = segue.destinationViewController;
    vc.examOutlineId = self.examOutlineId;
    vc.items = sender;
}

@end
