//
//  CompatibilityItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemTVC.h"

#import "CompatibilityItemBtn.h"

@interface CompatibilityItemTVC ()

@end

@implementation CompatibilityItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *itemInfo = @[].mutableCopy;
    NSString *sql1 = [@"select * from compatibility_items where compatibility_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            self.itemVO.itemInfo = itemInfo;
            [self.tableView reloadData];
        }
        else {
            [itemInfo addObject:row];
        }
    }];
    
    NSMutableArray *itemAnswers = @[].mutableCopy;
    NSString *sql2 = [@"select * from compatibility_questions where compatibility_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
    [[AFSQLManager sharedManager] performQuery:sql2 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            self.itemVO.itemAnswers = itemAnswers;
            [self.tableView reloadData];
        }
        else {
            [itemAnswers addObject:row];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        NSArray *itemInfo = self.itemVO.itemInfo[indexPath.row];
        NSString *info = [NSString stringWithFormat:@"%@%@",itemInfo[1],itemInfo[2]];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [[info clearString] boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 30.f) {
            return 30.f;
        }
        
        return size.height;
    }
    
    if (indexPath.section == 2){
        NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
        NSString *answer = itemAnswer[1];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.f]};
        CGSize size = [[answer clearString] boundingRectWithSize:CGSizeMake(200, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 44.f) {
            return 44.f;
        }
        
        return size.height;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.itemVO.itemInfo.count;
    }
    
    if (section == 2) {
        return self.itemVO.itemAnswers.count;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self itemDespretion];
    }
    
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        NSArray *itemInfo = self.itemVO.itemInfo[indexPath.row];
        NSString *info = [NSString stringWithFormat:@"%@%@",itemInfo[1],itemInfo[2]];
        label.text = [info clearString];
        return cell;
    }
    
    if (indexPath.section == 2) {
        cell.textLabel.hidden = YES;
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
        label.text = [itemAnswer[1] clearString];
        
        CompatibilityItemBtn *btn = (CompatibilityItemBtn *)[cell.contentView viewWithTag:888];
        NSMutableArray *answers = @[].mutableCopy;
        for (NSArray *itemInfo in self.itemVO.itemInfo) {
            [answers addObject:itemInfo[1]];
        }
        btn.answers = answers;
        return cell;
    }
    
    return cell;
}

- (IBAction)onPressedBtn:(id)sender {
    [sender becomeFirstResponder];
}

- (NSString *)itemDespretion
{
    return @"配伍选择题：一组试题（2至4个）共用一组A，B，C，D，E五个备选答案。选项在前，题干在后，每题只有一个正确答案。每个选项可供选择一次，也可重复选用，也可不被选用。考生只需为每道试题选出一个最佳答案。";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CompatibilityItemBtn *btn = (CompatibilityItemBtn *)[cell.contentView viewWithTag:888];
        [self.itemVO setAnswer:self.itemVO.itemInfo[btn.answerIndex] andIndex:indexPath.row];
    }
}

@end
