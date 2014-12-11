//
//  Persion1VC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "Persion1VC.h"

#import "ChooseContentCell.h"
#import "ContentCell.h"

#import "HomeVC.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <SDWebImage/UIButton+WebCache.h>

@interface Persion1VC () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate, ChooseContentCellDelegate, ContentCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *infos;
@property (nonatomic, strong) NSMutableDictionary *titles;

@end

@implementation Persion1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    
    self.infos = @{}.mutableCopy;
    self.titles = @{}.mutableCopy;
    
    NSDictionary *resume = self.roleDict[@"resume"];
    self.titles[@1] = resume[@"school"];
    self.titles[@2] = resume[@"specialty"];
    self.titles[@3] = resume[@"education"];
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
    if (section > 0 && section + 1< [tableView numberOfSections]) {
        return 2;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120.f;
    }
    else if (indexPath.section + 1 == tableView.numberOfSections) {
        return 44;
    }
    
    if (indexPath.row == 0) {
        return [ContentCell heightWithCellData:self.infos[@(indexPath.section)]];
    }
    else {
        return [ChooseContentCell heightWithCellData:self.infos[@(indexPath.section)]];
    }
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
    else if (indexPath.section + 1 == tableView.numberOfSections){
        return [tableView dequeueReusableCellWithIdentifier:@"CellButtom" forIndexPath:indexPath];;
    }
    
    
    if (indexPath.row == 0) {
        ContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellContent" forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            contentCell.titlePlaceholder = @"学校";
            contentCell.titleKey = @"schoolName";
        }
        else if (indexPath.section == 2) {
            contentCell.titlePlaceholder = @"专业";
            contentCell.titleKey = @"specialtyName";
        }
        else {
            contentCell.titlePlaceholder = @"学历";
            contentCell.titleKey = @"name";
        }
        
        contentCell.delegate = self;
        [contentCell updateWithTitle:self.titles[@(indexPath.section)]];
        
        return contentCell;
    }
    else {
        ChooseContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"CellChooseContent" forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            contentCell.titleKey = @"schoolName";
        }
        else if (indexPath.section == 2) {
            contentCell.titleKey = @"specialtyName";
        }
        else {
            contentCell.titleKey = @"name";
        }
        
        contentCell.delegate = self;
        [contentCell updateWithInfos:self.infos[@(indexPath.section)]];
        
        return contentCell;
    }
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

- (IBAction)onPressedSubmitBtn:(UIButton *)sender
{
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"resume.school"] = self.titles[@1];
    params[@"resume.specialty"] = self.titles[@2];
    params[@"resume.education"] = self.titles[@3];
    
    if (!params[@"resume.school"]) {
        [[OTSAlertView alertWithMessage:@"请填写学校" andCompleteBlock:nil] show];
        return ;
    }
    
    if (!params[@"resume.specialty"]) {
        [[OTSAlertView alertWithMessage:@"请填写专业" andCompleteBlock:nil] show];
        return ;
    }
    
    if (!params[@"resume.education"]) {
        [[OTSAlertView alertWithMessage:@"请填写学历" andCompleteBlock:nil] show];
        return ;
    }
    
    [self showLoading];
    [self getValueWithLYKUrl:@"/resumeJ!addPower" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
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


@end
