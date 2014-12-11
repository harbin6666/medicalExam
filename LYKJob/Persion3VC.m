//
//  Persion3VC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "Persion3VC.h"

#import "CancelContentCell.h"
#import "ChooseContentAndChangeCell.h"
#import "HomeVC.h"

@interface Persion3VC () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ChooseContentAndChangeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic) BOOL showContent;

@property (nonatomic, strong) NSMutableArray *resumeStudentses;

@property (nonatomic, strong) NSString *schoolJob;

@end

@implementation Persion3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    
    NSDictionary *resume = self.roleDict[@"resume"];
    NSString *titles = resume[@"resumeAdditional"][@"traFeatures"];
    self.titles = [titles componentsSeparatedByString:@","].mutableCopy;
    if (!self.titles) {
        self.titles = @[].mutableCopy;
    }
    
    self.schoolJob = self.roleDict[@"resume"][@"resumeAdditional"][@"traTitle"];
    
    self.resumeStudentses = @[].mutableCopy;
    NSArray *resumeStudentses = resume[@"resumeStudentses"];
    if (resumeStudentses.count == 0) {
        [self.resumeStudentses addObject:@{}.mutableCopy];
    }
    else {
        for (NSDictionary *dict in resumeStudentses) {
            [self.resumeStudentses addObject:dict.mutableCopy];
        }
    }
}

- (IBAction)onPressedTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onPressedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.showContent) {
            return 2;
        }
        else {
            return 1;
        }
    }
    
    if (section == 2) {
        return self.resumeStudentses.count;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 130;
        }
        return 66.f;
    }
    
    if (indexPath.section == 2) {
        return 120.f;
    }
    
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CancelContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellCancel" forIndexPath:indexPath];
            [contentCell updateWithTitles:self.titles];
            return contentCell;
        }
        
        ChooseContentAndChangeCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChoose" forIndexPath:indexPath];
        contentCell.delegate = self;
        [contentCell updateWithInfos:nil];
        return contentCell;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSchoolJob" forIndexPath:indexPath];
        UITextField *cellTF = (UITextField *)[cell.contentView viewWithTag:999];
        cellTF.text = self.schoolJob;
        return cell;
    }
    else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEx" forIndexPath:indexPath];
        UITextField *schoolExTF = (UITextField *)[cell.contentView viewWithTag:999];
        schoolExTF.text = self.resumeStudentses[indexPath.row][@"trsActivities"];
        return cell;
    }
    else if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAdd" forIndexPath:indexPath];
        UIStepper *stepper = (UIStepper *)[cell.contentView viewWithTag:999];
        stepper.value = self.resumeStudentses.count;
        return cell;
    }
    else {
        return [tableView dequeueReusableCellWithIdentifier:@"CellButtom" forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)onValueChanged:(UIStepper *)sender {
    NSInteger count = sender.value;
    if (count > self.resumeStudentses.count) {
        [self.resumeStudentses addObject:@{}.mutableCopy];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.resumeStudentses.count - 1 inSection:2]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        [self.resumeStudentses removeLastObject];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.resumeStudentses.count inSection:2]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)onPressedToShowContent:(id)sender
{
    if (!self.showContent) {
        self.showContent = YES;
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)needUpdateContentCell:(ChooseContentAndChangeCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    CancelContentCell *cancelCell = (CancelContentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSMutableArray *titles = cancelCell.titles;
    if (![titles containsObject:cell.title]) {
        [titles addObject:cell.title];
        self.titles = titles;
        self.showContent = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)onPressedSubmitBtn:(id)sender {
    
    NSArray *titles = self.titles;
    NSString *schoolJob = self.schoolJob;
    
    NSMutableDictionary *params = @{}.mutableCopy;
    if ([[titles componentsJoinedByString:@","] length]) {
        params[@"resume.resumeAdditional.traFeatures"] = [titles componentsJoinedByString:@","];
    }
    
    params[@"resume.resumeAdditional.traTitle"] = schoolJob;
    
    for (int i = 0; i < self.resumeStudentses.count; i++) {
        NSString *key = [NSString stringWithFormat:@"resume.resumeStudentses[%d].trsActivities",i];
        NSString *schoolEx = self.resumeStudentses[i][@"trsActivities"];
        params[key] = schoolEx;
    }
    
    if (!params[@"resume.resumeAdditional.traFeatures"]) {
        [[OTSAlertView alertWithMessage:@"请填写成绩" andCompleteBlock:nil] show];
        return ;
    }
    
    if (!params[@"resume.resumeAdditional.traTitle"]) {
        [[OTSAlertView alertWithMessage:@"请填写学校职务" andCompleteBlock:nil] show];
        return ;
    }
    
    [self showLoading];
    [self getValueWithLYKUrl:@"/resumeJ!addMagic" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        if ([aResponseObject isKindOfClass:[NSDictionary class]]) {
            self.roleDict = aResponseObject;
            [self performSegueWithIdentifier:@"backToHome" sender:self.roleDict];
        }
        else {
            [[OTSAlertView alertWithMessage:@"提交失败" andCompleteBlock:nil] show];
        }
        [self hideLoading];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeVC *vc = segue.destinationViewController;
    vc.roleDict = sender;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:[textField getTableViewCell]];
    if (indexPath.section == 1) {
        self.schoolJob = textField.text;
    }
    else {
        self.resumeStudentses[indexPath.row][@"trsActivities"] = textField.text;
    }
}

@end
