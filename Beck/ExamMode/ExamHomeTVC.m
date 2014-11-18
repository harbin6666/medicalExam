//
//  ExamHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamHomeTVC.h"

#import "ChooseExamBankTVC.h"

@interface ExamHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation ExamHomeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"模拟考试", @"真题考试"];
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
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"exam%li",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:indexPath];
//    if (indexPath.row == 0) {
//        [self performSegueWithIdentifier:@"toSimulationExam" sender:nil];
//    }
//    else {
//        [self performSegueWithIdentifier:@"toChooseQuestionBank" sender:nil];
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = sender;
    if (path.row == 1) {
        ChooseExamBankTVC *vc = segue.destinationViewController;
        vc.fromExam = YES;
    }
}

@end
