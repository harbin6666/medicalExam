//
//  MoreHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MoreHomeTVC.h"

@interface MoreHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation MoreHomeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"高频考点", @"考试科目", @"意见反馈", @"使用帮助", @"软件分享", @"版本更新", @"个人档案"];
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
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"more%li",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toTestingCentre" sender:nil];
    }
    else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"toChooseExam" sender:nil];
    }
    else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"toFeedBack" sender:nil];
    }
    else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"toHelp" sender:nil];
    }
    else if (indexPath.row == 4){

    }
    else if (indexPath.row == 5){

    }
    else {
        [self performSegueWithIdentifier:@"toPersonalFile" sender:nil];
    }
}

@end
