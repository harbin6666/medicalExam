//
//  ProfileVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ProfileVC.h"

#import "ContentCell.h"
#import "ChooseContentCell.h"
#import "CancelContentCell.h"
#import "ChooseContentAndChangeCell.h"
#import "MonthCell.h"
#import "HomeVC.h"
#import "EnterPasswordVC.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface ProfileVC () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ContentCellDelegate,ChooseContentCellDelegate,ChooseContentAndChangeCellDelegate,UITextFieldDelegate,EnterPasswordVCDelegate>

@property (nonatomic, strong) EnterPasswordVC *pwVC;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *infos;
@property (nonatomic, strong) NSMutableDictionary *titles;

@property (nonatomic, strong) NSMutableArray *specTitles;

@property (nonatomic) BOOL showContent;

@property (nonatomic) BOOL showIntentionContent;

@property (nonatomic, strong) NSMutableArray *resumeInternships;
@property (nonatomic, strong) NSMutableArray *resumeStudentses;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    
    self.infos = @{}.mutableCopy;
    self.titles = @{}.mutableCopy;
    
    NSDictionary *resume = self.roleDict[@"resume"];
    self.infos[@1] = resume[@"realName"];
    self.infos[@2] = resume[@"sex"];
    
    NSString *date = resume[@"birthday"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:date];
    self.infos[@3] = destDate;
    
    self.infos[@4] = resume[@"phone"];
    self.infos[@5] = resume[@"email"];
    self.titles[@9] = resume[@"employmentDirection"];
    
    self.titles[@6] = resume[@"school"];
    self.titles[@7] = resume[@"specialty"];
    self.titles[@8] = resume[@"education"];
    
    self.titles[@10] = resume[@"resumeAdditional"][@"traScore"];
    self.titles[@11] = resume[@"resumeAdditional"][@"traCertificates"];
    self.infos[@12] = resume[@"resumeAdditional"][@"traSkills"];
    
    self.infos[@14] = resume[@"resumeAdditional"][@"traTitle"];
    NSString *traFeatures = resume[@"resumeAdditional"][@"traFeatures"];
    self.specTitles = [traFeatures componentsSeparatedByString:@","].mutableCopy;
    if (!self.specTitles) {
        self.specTitles = @[].mutableCopy;
    }
    
    self.resumeInternships = @[].mutableCopy;
    NSArray *resumeInternships = resume[@"resumeInternships"];
    if (resumeInternships.count == 0) {
        [self.resumeInternships addObject:@{@"triLength":@1}.mutableCopy];
    }
    else {
        for (NSDictionary *dict in resumeInternships) {
            [self.resumeInternships addObject:dict.mutableCopy];
        }
    }
    
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)onPressedTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onPressedBack:(id)sender
{
    [self performSegueWithIdentifier:@"backToHomeNone" sender:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 + 16 + 1 + self.resumeInternships.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 9) {
        if (self.showIntentionContent) {
            return 2;
        }
        else {
            return 1;
        }
    }
    
    if (section >= 6 && section <= 11) {
        return 2;
    }
    
    if (section == 13) {
        if (self.showContent) {
            return 2;
        }
        else {
            return 1;
        }
    }
    
    if (section == 15) {
        return self.resumeStudentses.count;
    }
    
    if (section > 16 && section + 2 < [tableView numberOfSections]) {
        return 2;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120.f;
    }
    
    if (indexPath.section == 9) {
        if (indexPath.row == 1) {
            return 130;
        }
        return 44.f;
    }
    
    if (indexPath.section >= 6 && indexPath.section <= 11) {
        if (indexPath.row == 0) {
            return [ContentCell heightWithCellData:self.infos[@(indexPath.section)]];
        }
        else {
            return [ChooseContentCell heightWithCellData:self.infos[@(indexPath.section)]];
        }
    }
    
    if (indexPath.section == 13) {
        if (indexPath.row == 1) {
            return 130;
        }
        return 66.f;
    }
    
    if (indexPath.section == 15) {
        return 120.f;
    }
    
    if (indexPath.section > 16 && indexPath.section + 2 < [tableView numberOfSections]) {
        if (indexPath.row == 0) {
            return 44;
        }
        else {
            return 130;
        }
    }
    
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTop" forIndexPath:indexPath];
        if (self.roleDict[@"resume"][@"resumeLogo"]) {
            UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
            [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FILES_SERVER,self.roleDict[@"resume"][@"resumeLogo"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chooseImage"]];
        }
        return cell;
    }
    
    if (indexPath.section + 1 == [tableView numberOfSections]) {
        return [tableView dequeueReusableCellWithIdentifier:@"CellButtom" forIndexPath:indexPath];
    }
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSex" forIndexPath:indexPath];
        UISegmentedControl *seg = (UISegmentedControl *)[cell.contentView viewWithTag:999];
        if ([self.infos[@(indexPath.section)] intValue] == 2) {
            seg.selectedSegmentIndex = 1;
        }
        else {
            seg.selectedSegmentIndex = 0;
        }
        return cell;
    }
    
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellBir" forIndexPath:indexPath];
        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
        if (self.infos[@(indexPath.section)]) {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            formatter.dateFormat = @"yyyy-M-dd";
            [btn setTitle:[formatter stringFromDate:self.infos[@(indexPath.section)]] forState:UIControlStateNormal];
        }
        return cell;
    }
    
    if (indexPath.section >= 6 && indexPath.section <= 11) {
        if (indexPath.row == 0) {
            ContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellContent" forIndexPath:indexPath];
            
            if (indexPath.section == 6) {
                contentCell.titlePlaceholder = @"学校";
                contentCell.titleKey = @"schoolName";
            }
            else if (indexPath.section == 7) {
                contentCell.titlePlaceholder = @"专业";
                contentCell.titleKey = @"specialtyName";
            }
            else if (indexPath.section == 8) {
                contentCell.titlePlaceholder = @"学历";
                contentCell.titleKey = @"name";
            }
            else if (indexPath.section == 9) {
                contentCell.titlePlaceholder = @"求职意向";
                contentCell.titleKey = @"intention";
            }
            else if (indexPath.section == 10) {
                contentCell.titlePlaceholder = @"成绩";
                contentCell.titleKey = @"score";
            }
            else if (indexPath.section == 11) {
                contentCell.titlePlaceholder = @"证书";
                contentCell.titleKey = @"certificateName";
            }
            
            contentCell.delegate = self;
            [contentCell updateWithTitle:self.titles[@(indexPath.section)]];
            
            return contentCell;
        }
        else {
            if (indexPath.section == 9) {
                ChooseContentAndChangeCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChoose" forIndexPath:indexPath];
                contentCell.delegate = self;
                contentCell.fromIntent = YES;
                [contentCell updateWithInfos:nil];
                return contentCell;
            }
            
            ChooseContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChooseContent" forIndexPath:indexPath];
            
            if (indexPath.section == 6) {
                contentCell.titleKey = @"schoolName";
            }
            else if (indexPath.section == 7) {
                contentCell.titleKey = @"specialtyName";
            }
            else if (indexPath.section == 8){
                contentCell.titleKey = @"name";
            }
            else if (indexPath.section == 10) {
                contentCell.titleKey = @"score";
            }
            else if (indexPath.section == 11) {
                contentCell.titleKey = @"certificateName";
            }
            
            contentCell.delegate = self;
            [contentCell updateWithInfos:self.infos[@(indexPath.section)]];
            
            return contentCell;
        }
    }
    
    if (indexPath.section == 13) {
        if (indexPath.row == 0) {
            CancelContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellCancel" forIndexPath:indexPath];
            [contentCell updateWithTitles:self.specTitles];
            return contentCell;
        }
        
        ChooseContentAndChangeCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChoose" forIndexPath:indexPath];
        contentCell.delegate = self;
        contentCell.fromIntent = NO;
        [contentCell updateWithInfos:nil];
        return contentCell;
    }
    
    if (indexPath.section == 15) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEx" forIndexPath:indexPath];
        UITextField *schoolExTF = (UITextField *)[cell.contentView viewWithTag:999];
        schoolExTF.placeholder = @"社团经历...";
        schoolExTF.text = self.resumeStudentses[indexPath.row][@"trsActivities"];
        return cell;
    }
    
    if (indexPath.section == 16) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAdd" forIndexPath:indexPath];
        UIStepper *stepper = (UIStepper *)[cell.contentView viewWithTag:999];
        stepper.value = self.resumeStudentses.count;
        return cell;
    }
    
    if (indexPath.section > 16 && indexPath.section + 2 < [tableView numberOfSections]) {
        if (indexPath.row == 0) {
            MonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAddLength" forIndexPath:indexPath];
            [cell updateWithInfos:self.resumeInternships[indexPath.section - 17]];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEx" forIndexPath:indexPath];
            UITextField *schoolExTF = (UITextField *)[cell.contentView viewWithTag:999];
            schoolExTF.placeholder = @"实习经历...";
            schoolExTF.text = self.resumeInternships[indexPath.section - 17][@"triDesc"];
            return cell;
        }
    }
    
    if (indexPath.section + 2 == [tableView numberOfSections]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAdd2" forIndexPath:indexPath];
        UIStepper *stepper = (UIStepper *)[cell.contentView viewWithTag:999];
        stepper.value = self.resumeInternships.count;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellText" forIndexPath:indexPath];
    UITextField *tf = (UITextField *)[cell.contentView viewWithTag:999];
    if (indexPath.section == 1) {
        tf.placeholder = @"姓名";
    }
    else if (indexPath.section == 4) {
        tf.placeholder = @"电话";
    }
    else if (indexPath.section == 5) {
        tf.placeholder = @"邮箱（用户名）";
    }
    else if (indexPath.section == 12) {
        tf.placeholder = @"特殊技能";
    }
    else if (indexPath.section == 14) {
        tf.placeholder = @"学校职务";
    }
    tf.text = self.infos[@(indexPath.section)];
    
    if (indexPath.section == 5 && self.roleDict[@"user"][@"userId"]) {
        tf.enabled = NO;
    }
    else {
        tf.enabled = YES;
    }
    
    return cell;
}

- (IBAction)onPressedPickDate:(UIButton *)sender {
    [sender becomeFirstResponder];
}

- (IBAction)onPressedChooseImage:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.mediaTypes = @[@"public.image"];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self upload:image completeBlock:^(id aResponseObject, NSError *anError) {
            if (!anError) {
                self.roleDict = aResponseObject;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:self.roleDict];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            else {
                [[OTSAlertView alertWithMessage:@"上传失败" andCompleteBlock:nil] show];
            }
            [self hideLoading];
        } progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            CGFloat p = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;
            p = p * 100;
            hud.labelText = [NSString stringWithFormat:@"%d％",(int)p];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)needUpdateChooseContentCell:(ContentCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    if (path.section == 9) {
        self.infos[@(path.section)] = cell.infos;
        self.titles[@(path.section)] = cell.title;
        self.showIntentionContent = YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        self.infos[@(path.section)] = cell.infos;
        self.titles[@(path.section)] = cell.title;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:path.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)endContentCell:(ContentCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    if (path.section == 9) {
//        self.infos[@(path.section)] = cell.infos;
//        self.titles[@(path.section)] = cell.title;
//        self.showIntentionContent = YES;
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        self.infos[@(path.section)] = nil;
        self.titles[@(path.section)] = cell.title;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)needUpdateContentCell:(ChooseContentCell *)cell
{
    if ([cell isKindOfClass:[ChooseContentAndChangeCell class]]) {
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        if (path.section == 9) {
            ContentCell *contentCell = (ContentCell *)[self.tableView cellForRowAtIndexPath:path];
            self.titles[@(path.section)] = contentCell.title;
            self.showIntentionContent = NO;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else {
            CancelContentCell *cancelCell = (CancelContentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:13]];
            NSMutableArray *titles = cancelCell.titles;
            if (![titles containsObject:cell.title]) {
                [titles addObject:cell.title];
                self.specTitles = titles;
                self.showContent = NO;
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
        return;
    }
    
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    self.titles[@(path.section)] = cell.title;
    self.infos[@(path.section)] = cell.infos;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)onPressedToShowContent:(UITapGestureRecognizer *)sender
{
    if (!self.showContent) {
        self.showContent = YES;
        NSIndexPath *path = [self.tableView indexPathForCell:[sender.view getTableViewCell]];
        if (path) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:path.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else {
            [self.tableView reloadData];
        }
    }
}

- (IBAction)onresumeStudentsesCountChange:(UIStepper *)sender
{
    NSInteger count = sender.value;
    if (count > self.resumeStudentses.count) {
        [self.resumeStudentses addObject:@{}.mutableCopy];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.resumeStudentses.count - 1 inSection:15]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        [self.resumeStudentses removeLastObject];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.resumeStudentses.count inSection:15]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)onresumeInternshipsCountChange:(UIStepper *)sender
{
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

- (IBAction)onSexChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.infos[@(2)] = @1;
    }
    else {
        self.infos[@(2)] = @2;
    }
}

- (IBAction)onLengthValueChange:(UIStepper *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:[sender getTableViewCell]];
    if (indexPath.section < 17) {
        return;
    }
    self.resumeInternships[indexPath.section - 17][@"triLength"] = @((int)sender.value);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:[textField getTableViewCell]];
    if (indexPath.section <= 14) {
        self.infos[@(indexPath.section)] = textField.text;
    }
    else if (indexPath.section == 15){
        self.resumeStudentses[indexPath.row][@"trsActivities"] = textField.text;
    }
    else {
        self.resumeInternships[indexPath.section - 17][@"triDesc"] = textField.text;
    }
}

-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)onPressedSubmitBtn:(UITextField *)sender
{
    if (![self isValidateEmail:self.infos[@5]]) {
        [[OTSAlertView alertWithMessage:@"邮箱格式不正确" andCompleteBlock:nil] show];
        return ;
    }
    
    [self showLoading];
    if (!self.roleDict[@"user"][@"userId"]) {
        [self getBoolValueWithLYKUrl:@"/userJ!isUserEmailExist" params:@{@"user.userEmail":self.infos[@5]} CompleteBlock:^(id aResponseObject, NSError *anError) {
            if (!anError) {
                if ([aResponseObject boolValue]) {
                    [[OTSAlertView alertWithMessage:@"邮箱已经被注册" andCompleteBlock:nil] show];
                }
                else {
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    EnterPasswordVC *vc = [sb instantiateViewControllerWithIdentifier:@"PWVC"];
                    self.pwVC = vc;
                    vc.delegate = self;
                    vc.username = self.infos[@5];
                    
                    vc.view.alpha = 0.f;
                    [self.view addSubview:vc.view];
                    [UIView animateWithDuration:.5f animations:^{
                        vc.view.alpha = 1.f;
                    }];
                }
            }
            else {
                [[OTSAlertView alertWithMessage:@"请重新提交" andCompleteBlock:nil] show];
            }
            
            [self hideLoading];
        }];
    }
    else {
        [self registeSuccessd:self.roleDict];
    }
}

- (void)registeSuccessd:(NSDictionary *)dict
{
    self.roleDict = dict;
    NSMutableDictionary *params = @{}.mutableCopy;
//    params[@"resume.resumeLogo"] = nil;
    if ([self.infos[@1] length]) {
        params[@"resume.realName"] = self.infos[@1];
    }
    params[@"resume.sex"] = self.infos[@2];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyy-M-dd";
    params[@"resume.birthday"] = [formatter stringFromDate:self.infos[@3]];
    
    params[@"resume.phone"] = self.infos[@4];
    params[@"resume.email"] = self.infos[@5];
    params[@"resume.employmentDirection"] = self.titles[@9];
    
    params[@"resume.school"] = self.titles[@6];
    params[@"resume.specialty"] = self.titles[@7];
    params[@"resume.education"] = self.titles[@8];
    
    params[@"resume.resumeAdditional.traScore"] = self.titles[@10];
    params[@"resume.resumeAdditional.traCertificates"] = self.titles[@11];
    params[@"resume.resumeAdditional.traSkills"] = self.infos[@12];
    
    for (int i = 0; i < self.resumeStudentses.count; i++) {
        NSString *key = [NSString stringWithFormat:@"resume.resumeStudentses[%d].trsActivities",i];
        NSString *schoolEx = self.resumeStudentses[i][@"trsActivities"];
        params[key] = schoolEx;
    }
    
    NSArray *titles = self.specTitles;
    NSString *schoolJob = self.infos[@14];
    if ([[titles componentsJoinedByString:@","] length]) {
        params[@"resume.resumeAdditional.traFeatures"] = [titles componentsJoinedByString:@","];
    }
    params[@"resume.resumeAdditional.traTitle"] = schoolJob;

    for (int i = 0; i < self.resumeInternships.count; i++) {
        NSString *key = [NSString stringWithFormat:@"resume.resumeInternships[%d].triDesc",i];
        NSString *schoolEx = self.resumeInternships[i][@"triDesc"];
        params[key] = schoolEx;
        
        if (schoolEx) {
            NSString *lengthKey = [NSString stringWithFormat:@"resume.resumeInternships[%d].triLength",i];
            NSString *lengthTitle = self.resumeInternships[i][@"triLength"];
            params[lengthKey] = lengthTitle;
        }
    }
    
    
    
    [self showLoading];
    [self getValueWithLYKUrl:@"/resumeJ!saveResume" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        if (aResponseObject[@"user"][@"userId"]) {
            self.roleDict = aResponseObject;
            [self performSegueWithIdentifier:@"backToHome" sender:self.roleDict];
        }
        else {
            [[OTSAlertView alertWithMessage:@"保存简历失败" andCompleteBlock:nil] show];
        }
        
        [self hideLoading];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backToHomeNone"]) {
        return;
    }
    
    HomeVC *vc = segue.destinationViewController;
    vc.roleDict = sender;
}

@end
