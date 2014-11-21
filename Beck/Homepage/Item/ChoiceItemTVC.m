//
//  ChoiceItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChoiceItemTVC.h"

@interface ChoiceItemTVC ()

@property (nonatomic, strong) NSArray *itemInfo;
@property (nonatomic, strong) NSMutableArray *itemAnswers;

@end

@implementation ChoiceItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *sql1 = [@"select * from choice_questions where choice_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            [self.tableView reloadData];
        }
        else {
            self.itemInfo = row;
        }
    }];
    
    self.itemAnswers = @[].mutableCopy;
    NSString *sql2 = [@"select * from choice_items where choice_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
    [[AFSQLManager sharedManager] performQuery:sql2 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            [self.tableView reloadData];
        }
        else {
            [self.itemAnswers addObject:row];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        NSString *info = self.itemInfo[9];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [info boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 60.f) {
            return 60.f;
        }
        
        return size.height;
    }
    
    if (indexPath.section == 2){
        NSArray *itemAnswer = self.itemAnswers[indexPath.row];
        NSString *answer = itemAnswer[3];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.f]};
        CGSize size = [answer boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 30.f) {
            return 30.f;
        }
        
        return size.height;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.itemAnswers.count;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        label.text = self.itemInfo[9];
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (self.itemAnswers.count) {
            NSArray *itemAnswer = self.itemAnswers[indexPath.row];
            cell.textLabel.text = itemAnswer[3];
        }
        return cell;
    }
    
    return cell;
}

- (NSString *)answerParse
{
    return self.itemInfo[11];
}

- (NSString *)noteParse
{
    return @"我是笔记啊";
}

@end
