//
//  ChooseItemTypeTVC.m
//  Beck
//
//  Created by Aimy on 14/11/13.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseItemTypeTVC.h"

#import "PracticeModePVC.h"

@interface ChooseItemTypeTVC ()

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation ChooseItemTypeTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.names = @[@"单选题",@"判断题",@"多选题",@"配伍题",@"填空题"];
    self.names = @[@"单选题",@"配伍题",@"多选题"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numbers = @[].mutableCopy;
    
//    NSString *sql1 = @"select custom_id, count(choice_id) from choice_questions where custom_id == \"1\" union all\
//    select custom_id, count(decision_id) from decision_question union all\
//    select custom_id, count(choice_id) from choice_questions where custom_id == \"3\" union all\
//    select custom_id, count(id) from compatibility_info union all\
//    select custom_id, count(space_id) from space_question";
    
    NSString *sql2 =
    @"select custom_id, count(choice_id) from choice_questions where custom_id == \"1\" union all\
    select custom_id, count(id) from compatibility_info union all\
    select custom_id, count(choice_id) from choice_questions where custom_id == \"3\"";
    
    [[AFSQLManager sharedManager] performQuery:sql2 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sql = nil;
    switch (indexPath.row) {
        case 0:
        {
            sql = @"select choice_id, custom_id from choice_questions where custom_id == 1";
        }
            break;
//        case 1:
//        {
//            sql = @"select decision_id, custom_id from decision_question where custom_id == 2";
//        }
//            break;
        case 2:
        {
            sql = @"select choice_id, custom_id from choice_questions where custom_id == 3";
        }
            break;
            
        case 1:
        {
            sql = @"select id, custom_id from compatibility_info where custom_id == 2";
        }
            break;
            
//        case 4:
//        {
//            sql = @"select space_id, custom_id from space_question where custom_id == 5";
//        }
//            break;
            
        default:
            break;
    }
    
    [self showLoading];
    WEAK_SELF;
    NSMutableArray *ids = [NSMutableArray array];
    [[AFSQLManager sharedManager] performQuery:sql withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        NSLog(@"%@,%@,%d",row,error,finished);
        if (finished) {
            STRONG_SELF;
            [self hideLoading];
            [self performSegueWithIdentifier:@"toNext" sender:ids];
        }
        else {
            ItemVO *vo = [ItemVO createWithItemId:row[0] andType:[row[1] intValue]];
            if (vo) {
                [ids addObject:vo];
            }
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PracticeModePVC *vc = segue.destinationViewController;
    vc.items = sender;
}

@end
