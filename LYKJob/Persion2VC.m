//
//  Persion2VC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "Persion2VC.h"

#import "ChooseContentCell.h"
#import "ContentCell.h"
#import "HomeVC.h"
#import "MonthCell.h"

@interface Persion2VC () <UITableViewDelegate,UITableViewDataSource,ChooseContentCellDelegate,ContentCellDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *infos;
@property (nonatomic, strong) NSMutableDictionary *titles;

@property (nonatomic, strong) NSMutableArray *resumeInternships;

@end

@implementation Persion2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    
    self.infos = @{}.mutableCopy;
    self.titles = @{}.mutableCopy;
    self.resumeInternships = @[].mutableCopy;
    
    NSDictionary *resume = self.roleDict[@"resume"];
    self.titles[@0] = resume[@"resumeAdditional"][@"traScore"];
    self.titles[@1] = resume[@"resumeAdditional"][@"traCertificates"];
    self.titles[@2] = resume[@"resumeAdditional"][@"traSkills"];
    
    NSArray *resumeInternships = resume[@"resumeInternships"];
    if (resumeInternships.count == 0) {
        [self.resumeInternships addObject:@{@"triLength":@1}.mutableCopy];
    }
    else {
        for (NSDictionary *dict in resumeInternships) {
            [self.resumeInternships addObject:dict.mutableCopy];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5 + self.resumeInternships.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView numberOfSections] == section + 2 ||
        [tableView numberOfSections] == section + 1 ||
        section == 2) {
        return 1;
    }
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView numberOfSections] == indexPath.section + 2 ||
        [tableView numberOfSections] == indexPath.section + 1 ||
        indexPath.section == 2) {
        return 44;
    }
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.row == 0) {
            return [ContentCell heightWithCellData:self.infos[@(indexPath.section)]];
        }
        else {
            return [ChooseContentCell heightWithCellData:self.infos[@(indexPath.section)]];
        }
    }
    
    if (indexPath.row == 0) {
        return 54;
    }
    else {
        return 130;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        UITableViewCell *skillCell = [tableView dequeueReusableCellWithIdentifier:@"CellSpec" forIndexPath:indexPath];
        UITextField *skillTitle = (UITextField *)[skillCell.contentView viewWithTag:999];
        skillTitle.text = self.titles[@(indexPath.section)];
        return skillCell;
    }
    
    if ([tableView numberOfSections] == indexPath.section + 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAdd" forIndexPath:indexPath];
        UIStepper *stepper = (UIStepper *)[cell.contentView viewWithTag:999];
        stepper.value = self.resumeInternships.count;
        return cell;
    }
    
    if ([tableView numberOfSections] == indexPath.section + 1) {
        return [tableView dequeueReusableCellWithIdentifier:@"CellButtom" forIndexPath:indexPath];
    }
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.row == 0) {
            ContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellContent" forIndexPath:indexPath];
            
            if (indexPath.section == 0) {
                contentCell.titlePlaceholder = @"成绩";
                contentCell.titleKey = @"score";
            }
            else if (indexPath.section == 1) {
                contentCell.titlePlaceholder = @"证书";
                contentCell.titleKey = @"certificateName";
            }
            
            contentCell.delegate = self;
            [contentCell updateWithTitle:self.titles[@(indexPath.section)]];
            
            return contentCell;
        }
        else {
            ChooseContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChooseContent" forIndexPath:indexPath];
            
            if (indexPath.section == 0) {
                contentCell.titleKey = @"score";
            }
            else if (indexPath.section == 1) {
                contentCell.titleKey = @"certificateName";
            }
            
            contentCell.delegate = self;
            [contentCell updateWithInfos:self.infos[@(indexPath.section)]];
            
            return contentCell;
        }
    }
    
    if (indexPath.row == 0) {
        MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAddLength" forIndexPath:indexPath];
        [cell updateWithInfos:self.resumeInternships[indexPath.section - 3]];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEx" forIndexPath:indexPath];
        UITextField *schoolExTF = (UITextField *)[cell.contentView viewWithTag:999];
        schoolExTF.text = self.resumeInternships[indexPath.section - 3][@"triDesc"];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (IBAction)onValueChanged:(UIStepper *)sender {
    NSInteger count = sender.value;
    if (count > self.resumeInternships.count) {
        [self.resumeInternships addObject:@{@"triLength":@1}.mutableCopy];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self.tableView numberOfSections] - 2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        [self.resumeInternships removeLastObject];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:[self.tableView numberOfSections] - 3] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)onLengthValueChanged:(UIStepper *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:[sender getTableViewCell]];
    self.resumeInternships[indexPath.section - 3][@"triLength"] = @((int)sender.value);
}

- (void)needUpdateChooseContentCell:(ContentCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    self.infos[@(path.section)] = cell.infos;
    self.titles[@(path.section)] = cell.title;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:path.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)endContentCell:(ContentCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    self.infos[@(path.section)] = nil;
    self.titles[@(path.section)] = cell.title;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)needUpdateContentCell:(ChooseContentCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    self.titles[@(path.section)] = cell.title;
    self.infos[@(path.section)] = cell.infos;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)onPressedSubmitBtn:(id)sender {
    
    NSString *scoreTitle = self.titles[@0];
    NSString *certiTitle = self.titles[@1];
    
    UITableViewCell *skillCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSString *skillTitle = [(UITextField *)[skillCell.contentView viewWithTag:999] text];
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"resume.resumeAdditional.traScore"] = scoreTitle;
    params[@"resume.resumeAdditional.traCertificates"] = certiTitle;
    
    if (skillTitle.length) {
        params[@"resume.resumeAdditional.traSkills"] = skillTitle;
    }
    
    for (int i = 0; i < self.resumeInternships.count; i++) {
        NSString *key = [NSString stringWithFormat:@"resume.resumeInternships[%d].triDesc",i];
        NSString *schoolEx = self.resumeInternships[i][@"triDesc"];
        params[key] = schoolEx;
        
        if (schoolEx) {
            NSString *lengthKey = [NSString stringWithFormat:@"resume.resumeInternships[%d].triLength",i];
            NSString *lengthTitle = [self.resumeInternships[i][@"triLength"] stringValue];
            params[lengthKey] = lengthTitle;
        }
    }
    
    if (!params[@"resume.resumeAdditional.traScore"]) {
        [[OTSAlertView alertWithMessage:@"请填写成绩" andCompleteBlock:nil] show];
        return ;
    }
    
    if (!params[@"resume.resumeAdditional.traCertificates"]) {
        [[OTSAlertView alertWithMessage:@"请填写证书" andCompleteBlock:nil] show];
        return ;
    }
    
    [self showLoading];
    [self getValueWithLYKUrl:@"/resumeJ!addAttact" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
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
    self.resumeInternships[indexPath.section - 3][@"triDesc"] = textField.text;
}

@end
