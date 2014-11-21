//
//  CompatibilityItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CompatibilityItemTVC.h"

@interface CompatibilityItemTVC ()

@property (nonatomic, strong) NSMutableArray *itemInfos;
@property (nonatomic, strong) NSMutableArray *itemAnswers;

@end

@implementation CompatibilityItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemInfos = @[].mutableCopy;
    NSString *sql1 = [@"select * from compatibility_items where compatibility_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
    [[AFSQLManager sharedManager] performQuery:sql1 withBlock:^(NSArray *row, NSError *error, BOOL finished) {
        if (finished) {
            [self.tableView reloadData];
        }
        else {
            [self.itemInfos addObject:row];
        }
    }];
    
    self.itemAnswers = @[].mutableCopy;
    NSString *sql2 = [@"select * from compatibility_questions where compatibility_id == " stringByAppendingFormat:@"%@",self.itemVO.itemId];
    
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
        NSArray *itemInfo = self.itemInfos[indexPath.row];
        NSString *info = itemInfo[2];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [info boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 30.f) {
            return 30.f;
        }
        
        return size.height;
    }
    
    if (indexPath.section == 2){
        NSArray *itemAnswer = self.itemAnswers[indexPath.row];
        NSString *answer = itemAnswer[1];
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
    if (section == 1) {
        return self.itemInfos.count;
    }
    
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
        NSArray *itemInfo = self.itemInfos[indexPath.row];
        label.text = itemInfo[2];
        return cell;
    }
    
    if (indexPath.section == 2) {
        NSArray *itemAnswer = self.itemAnswers[indexPath.row];
        cell.textLabel.text = itemAnswer[1];
        return cell;
    }
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
