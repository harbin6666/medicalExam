//
//  ItemTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ItemtVC.h"

@interface ItemTVC () <UIAlertViewDelegate>

@end

@implementation ItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 4;
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
        return 30.f;
    }
    else if (indexPath.section == 3){
        return 30.f;
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
        return 44.f;
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
        cell.textLabel.text = @"我是选项";
    }
    else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
    }
    else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = @"我是答案";
        
        cell.textLabel.hidden = !self.showAnswer;
        cell.detailTextLabel.hidden = !self.showAnswer;
    }
    else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = @"我是笔记";
        
        cell.textLabel.hidden = !self.showNote;
        cell.detailTextLabel.hidden = !self.showNote;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addNote:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加笔记" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.delegate = self;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
