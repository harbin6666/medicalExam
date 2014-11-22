//
//  BeckCustomVC1.m
//  Beck
//
//  Created by Aimy on 14/11/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckCustomVC1.h"

#import "BeckChangeExamPlaceBtn.h"

#import "BeckCustomVC2.h"

@interface BeckCustomVC1 () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *positions;

@property (nonatomic, strong) NSIndexPath *path;

@property (weak, nonatomic) IBOutlet BeckChangeExamPlaceBtn *provinceBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BeckCustomVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/provinceAct.htm" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.provinceBtn.provinces = aResponseObject[@"list"];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取省份失败" andCompleteBlock:nil] show];
        }
    }];
    
    [self getValueWithBeckUrl:@"/front/positionTitleInfoAct.htm" params:@{@"token":@"sysTypeList"} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.positions = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取职位失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (IBAction)onPressedBtn:(id)sender {
    if (!self.provinceBtn.province) {
        [[OTSAlertView alertWithMessage:@"请选择省份" andCompleteBlock:nil] show];
        return;
    }
    
    if (!self.path) {
        [[OTSAlertView alertWithMessage:@"请选择职位" andCompleteBlock:nil] show];
        return;
    }
    
    [self performSegueWithIdentifier:@"toNext" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BeckCustomVC2 *vc = segue.destinationViewController;
    vc.province = self.provinceBtn.province;
    vc.position = self.positions[self.path.row];
}

- (IBAction)onPressedChangePlaceBtn:(id)sender {
    [sender becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.positions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:999];
    NSDictionary *name = self.positions[indexPath.row];
    lbl.text = name[@"titleName"];
    
    UIImageView *check = (UIImageView *)[cell.contentView viewWithTag:888];
    
    if (self.path && [self.path compare:indexPath] == NSOrderedSame) {
        check.highlighted = YES;
    }
    else {
        check.highlighted = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.path = indexPath;
    [tableView reloadData];
}

@end
