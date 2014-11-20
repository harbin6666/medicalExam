//
//  ChooseSectionTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ChooseSectionTVC.h"

@interface ChooseSectionTVC ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation ChooseSectionTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examOutlineAct.htm" params:@{@"token":@"testQuestions",@"subjectId":[[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"],@"examOutlineId":self.examOutlineId} CompleteBlock:^(id aResponseObject, NSError *anError) {
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

@end
