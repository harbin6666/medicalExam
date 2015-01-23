//
//  DecisionItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "DecisionItemTVC.h"

@interface DecisionItemTVC ()

@end

@implementation DecisionItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        NSString *info = self.itemVO.itemInfo[8];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [[info clearString] boundingRectWithSize:CGSizeMake(270, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 60.f) {
            return 60.f;
        }
        
        return ceil(size.height);
    }
    
    if (indexPath.section == 2){
        return 44.f;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        label.text = [self.itemVO.itemInfo[8] clearString];
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"对";
        }
        else {
            cell.textLabel.text = @"错";
        }
        
        cell.imageView.highlighted = [self.itemVO isUserAnswerAtIndex:indexPath.row];
        
        return cell;
    }
    
    return cell;
}

- (NSString *)itemDespretion
{
    return @"我是判断题题型描述";
}

@end
