//
//  MessageDetailVC.m
//  LYKJob
//
//  Created by Aimy on 14/12/5.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MessageDetailVC.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface MessageDetailVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    // Do any additional setup after loading the view.
    
    if (self.emplId) {
        [self showLoading];
        [self getValueWithLYKUrl:@"/resumeJ!toMessageDetail" params:@{@"jobRecommend.emplId":self.emplId} CompleteBlock:^(id aResponseObject, NSError *anError) {
            self.infos = aResponseObject[@"employment"];
            [self.tableView reloadData];
            [self hideLoading];
        }];
    }
}

- (IBAction)onPressedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPressedOk:(id)sender {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"jobApply.employment.emplId"] = self.infos[@"emplId"];
    
    [self showLoading];
    [self getBoolValueWithLYKUrl:@"/resumeJ!saveJobApply" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        if ([aResponseObject boolValue]) {
            [[OTSAlertView alertWithMessage:@"投递成功" andCompleteBlock:nil] show];
        }
        else {
            [[OTSAlertView alertWithMessage:@"投递失败" andCompleteBlock:nil] show];
        }
        [self hideLoading];
    }];
}

- (IBAction)onPressedCancel:(id)sender {
    [self performSegueWithIdentifier:@"backToHome" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.infos ? 8 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }
    
    if (indexPath.section > 0 && indexPath.section <= 4) {
        return 44.f;
    }
    
    if (indexPath.section == 5) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.f]};
        CGSize size = [self.infos[@"emplDesc"] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 60, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return (size.height + 20);
    }
    
    if (indexPath.section == 6) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.f]};
        CGSize size = [self.infos[@"postRequestment"] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 60, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return (size.height + 20);
    }

    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 5||section == 6) {
        return 44.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 5) {
        UILabel *label = [UILabel new];
        label.text = @"    职位描述：";
        label.textColor = [UIColor colorWithRed:35.f /255 green:148.f/255 blue:240.f/255 alpha:1.f];
        return label;
    }
    
    if (section == 6) {
        UILabel *label = [UILabel new];
        label.text = @"    任职要求：";
        label.textColor = [UIColor colorWithRed:35.f /255 green:148.f/255 blue:240.f/255 alpha:1.f];
        return label;
    }
    
    return nil;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTop" forIndexPath:indexPath];
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:999];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FILES_SERVER,self.infos[@"userDeptInfo"][@"user_dept_logo"]]] placeholderImage:[UIImage imageNamed:@"psstar"]];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:888];
        title.text = self.infos[@"userDeptInfo"][@"user_dept_name"];
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = @"职位：";
        UILabel *subTitle = (UILabel *)[cell.contentView viewWithTag:888];
        subTitle.text = self.infos[@"emplName"];
        return cell;
    }
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = @"工作地点：";
        UILabel *subTitle = (UILabel *)[cell.contentView viewWithTag:888];
        subTitle.text = self.infos[@"userDeptInfo"][@"user_dept_area"];
        return cell;
    }
    
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = @"工资：";
        UILabel *subTitle = (UILabel *)[cell.contentView viewWithTag:888];
        subTitle.text = self.infos[@"treatment"];
        return cell;
    }
    
    if (indexPath.section == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = @"最低学历：";
        UILabel *subTitle = (UILabel *)[cell.contentView viewWithTag:888];
        subTitle.text = self.infos[@"educationRequestment"];
        return cell;
    }
    
    if (indexPath.section == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = self.infos[@"emplDesc"];
        return cell;
    }
    
    if (indexPath.section == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        UILabel *title = (UILabel *)[cell.contentView viewWithTag:999];
        title.text = self.infos[@"postRequestment"];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"CellButtom" forIndexPath:indexPath];
}

@end
