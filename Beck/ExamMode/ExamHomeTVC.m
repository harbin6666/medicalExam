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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"模拟考试", @"真题考试"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    ChooseExamBankTVC *vc = segue.destinationViewController;
    vc.subjectId = self.subjectId;
    
    if (path.row == 1) {
        vc.fromExam = YES;
    }
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

@end
