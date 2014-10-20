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

@end

@implementation PersionalFileTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"我的积分", @"消息提醒", @"修改密码", @"支付信息"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return self.names.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0) {
//        [self performSegueWithIdentifier:@"toTestingCentre" sender:nil];
//    }
//    else if (indexPath.row == 1){
//        [self performSegueWithIdentifier:@"toChooseExam" sender:nil];
//    }
//    else if (indexPath.row == 2){
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
//    else if (indexPath.row == 3){
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
//    else if (indexPath.row == 4){
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
//    else if (indexPath.row == 5){
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
//    else {
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
}

@end
