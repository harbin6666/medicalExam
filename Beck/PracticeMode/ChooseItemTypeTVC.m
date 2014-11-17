//
//  ChooseItemTypeTVC.m
//  Beck
//
//  Created by Aimy on 14/11/13.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseItemTypeTVC.h"

@interface ChooseItemTypeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation ChooseItemTypeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"单选题",@"判断题",@"多选题",@"配伍题"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AFSQLManager sharedManager] performQuery:@"select count(choice_id) from choice_questions" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
    }];
    
    [[AFSQLManager sharedManager] performQuery:@"select count(id) from compatibility_info" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
    }];
    
    [[AFSQLManager sharedManager] performQuery:@"select count(space_id) from space_question" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
    }];
    
    [[AFSQLManager sharedManager] performQuery:@"select count(decision_id) from decision_question" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
    }];
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

@end
