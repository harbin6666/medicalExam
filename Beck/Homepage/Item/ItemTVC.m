//
//  ItemTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ItemtVC.h"

@interface ItemTVC () <UIAlertViewDelegate>

- (NSString *)answerParse;
- (NSString *)noteParse;

@end

@implementation ItemTVC

+ (instancetype)createWitleItemVO:(ItemVO *)aVO
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = nil;
    switch (aVO.type) {
        case ItemTypeChoice:
            vc = [sb instantiateViewControllerWithIdentifier:@"ChoiceItemTVC"];
            break;
        case ItemTypeDecision:
            vc = [sb instantiateViewControllerWithIdentifier:@"DecisionItemTVC"];
            break;
        case ItemTypeMultiChoice:
            vc = [sb instantiateViewControllerWithIdentifier:@"MultiChoiceItemTVC"];
            break;
        case ItemTypeCompatibility:
            vc = [sb instantiateViewControllerWithIdentifier:@"CompatibilityItemTVC"];
            break;
        case ItemTypeSpace:
            vc = [sb instantiateViewControllerWithIdentifier:@"SpaceItemTVC"];
            break;
        default:
            break;
    }
    
    vc.itemVO = aVO;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100.f;
    }
    else if (indexPath.section == 1){
        return 60.f;
    }
    else if (indexPath.section == 2){
        return 44.f;
    }
    else if (indexPath.section == 3){
        return 44.f;
    }
    else if (indexPath.section == 4){
        if (self.showAnswer) {
            return 80.f;
        }
        else {
            return 0.f;
        }
    }
    else if (indexPath.section == 5){
        if (self.showNote) {
            return 80.f;
        }
        else {
            return 0.f;
        }
    }
    else {
        return 60.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
        cell.textLabel.text = @"多项选择题：由一个题干和ABCDE五个备选答案组成，题干在前，选项在后，要求考生从五个备选答案种选出两个或者两个以上的正确答案，多选，少选，错选均不得分";
    }
    else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        label.text = @"医疗机构药剂人员调配处方时的错误行为是?";
        
        UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jilu"]];
        cell.backgroundView = cellBackgroundView;
    }
    else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"我是选项";
    }
    else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
    }
    else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self answerParse];
        
        cell.textLabel.hidden = !self.showAnswer;
        cell.detailTextLabel.hidden = !self.showAnswer;
    }
    else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self noteParse];
        
        cell.textLabel.hidden = !self.showNote;
        cell.detailTextLabel.hidden = !self.showNote;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (IBAction)addNote:(id)sender {
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"添加笔记" message:@"" andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            STRONG_SELF;
            [self showLoading];
            NSString *note = [alertView textFieldAtIndex:0].text;
            note = (note ?: @"");
            [self getValueWithBeckUrl:@"/front/userNoteAct.htm" params:@{@"token":@"addUpdate",@"json":@"note"} CompleteBlock:^(id aResponseObject, NSError *anError) {
                if (!anError) {
                    NSNumber *errorcode = aResponseObject[@"errorcode"];
                    if (errorcode.boolValue) {
                        [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
                    }
                    else {
                        
                    }
                }
                else {
                    [[OTSAlertView alertWithMessage:@"登录失败" andCompleteBlock:nil] show];
                }
                [self hideLoading];
            }];
        }
    }];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView addButtonWithTitle:@"取消"];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
}

- (NSString *)answerParse
{
    return @"我是答案";
}

- (NSString *)noteParse
{
    return @"我是笔记";
}

- (void)dealloc
{
    NSLog(@"ItemTVC dealloc");
}

@end
