//
//  PersionalFileTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PersionalFileTVC.h"

@interface PersionalFileTVC ()

@property (nonatomic, strong) NSArray *names;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PersionalFileTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"我的积分", @"消息提醒", @"修改密码", @"支付信息"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@,欢迎您",[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4){
        return [tableView dequeueReusableCellWithIdentifier:@"BottomCell" forIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    if (indexPath.row == 1) {
        UISwitch *sw = [UISwitch new];
        sw.on = YES;
        cell.accessoryView = sw;
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"more%li",(long)indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toMyPoint" sender:nil];
    }
    else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"toModifyPassword" sender:nil];
    }
    else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"toPayInfo" sender:nil];
    }
}

- (IBAction)onPressedExit:(id)sender {
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"提示" message:@"是否退出当前账号？" leftBtn:@"否" rightBtn:@"退出" extraData:nil andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            STRONG_SELF;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"subjectId"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginName"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"autologin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    [alertView show];
}

@end
