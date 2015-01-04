//
//  ChoiceItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChoiceItemTVC.h"

@interface ChoiceItemTVC ()

@end

@implementation ChoiceItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    if (indexPath.section == 1){
        NSString *info = self.itemVO.itemInfo[9];
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize size = [info.clearString boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 60.f) {
            return 60.f;
        }
        
        return size.height;
    }
    
    if (indexPath.section == 2){
        NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
        NSString *answer = itemAnswer[3];
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize size = [answer.clearString boundingRectWithSize:CGSizeMake(200, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 44.f) {
            return 44.f;
        }
        
        return size.height;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.itemVO.itemAnswers.count;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        label.text = [self.itemVO.itemInfo[9] clearString];
        label.font = font;
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (self.itemVO.itemAnswers.count) {
            NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
            cell.textLabel.text = [itemAnswer[3] clearString];
            cell.textLabel.font = font;
            
            cell.imageView.highlighted = [self.itemVO isSelectedAtIndex:indexPath.row];
            cell.userInteractionEnabled = self.itemVO.canChange;
        }
        return cell;
    }
    
    return cell;
}

- (NSString *)itemDespretion
{
    return @"最佳选择题：题干在前，选项在后。共有A，B，C，D，E五个备选答案，其中只有一个为最佳答案，其余选项为干扰答案。考生须在5个选项中选出一个最符合题意的答案。";
}

@end
