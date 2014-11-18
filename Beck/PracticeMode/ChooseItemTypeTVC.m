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

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseItemTypeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.names = @[@"单选题",@"判断题",@"多选题",@"配伍题"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numbers = @[].mutableCopy;
    
    [[AFSQLManager sharedManager] performQuery:@"select custom_id, count(choice_id) from choice_questions union all select custom_id, count(id) from compatibility_info union all select custom_id, count(space_id) from space_question union all select custom_id, count(decision_id) from decision_question" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
        if (finished) {
            [self.tableView reloadData];
        }
        else {
            [self.numbers addObject:row[1]];
        }
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
    NSString *num = self.numbers[indexPath.row];
    if (num) {
        cell.detailTextLabel.text = num;
    }
    else {
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

@end
