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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    if (indexPath.section == 1){
        NSArray *itemInfo = self.itemVO.itemInfo[indexPath.row];
        NSString *info = [NSString stringWithFormat:@"%@%@",itemInfo[1],itemInfo[2]];
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize size = [[info clearString] boundingRectWithSize:CGSizeMake(270, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 30.f) {
            return 30.f;
        }
        
        return ceil(size.height);
    }
    
    if (indexPath.section == 2){
        NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
        NSString *answer = itemAnswer[1];
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize size = [[answer clearString] boundingRectWithSize:CGSizeMake(250, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 44.f) {
            return 44.f;
        }
        
        return ceil(size.height);
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
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        NSArray *itemInfo = self.itemVO.itemInfo[indexPath.row];
        NSString *info = [NSString stringWithFormat:@"%@%@",itemInfo[1],itemInfo[2]];
        label.text = [info clearString];
        label.font = font;
        return cell;
    }
    
    if (indexPath.section == 2) {
        cell.textLabel.hidden = YES;
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        NSArray *itemAnswer = self.itemVO.itemAnswers[indexPath.row];
        label.text = [itemAnswer[1] clearString];
        label.font = font;
        
        CompatibilityItemBtn *btn = (CompatibilityItemBtn *)[cell.contentView viewWithTag:888];
        btn.answerIndex = indexPath.row;
        
        if (self.itemVO.showAnswer) {
            [btn setTitle:[self.itemVO getAnswerAtIndex:indexPath.row] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
        }
        else {
            btn.itemVO = self.itemVO;
            btn.userInteractionEnabled = self.itemVO.canChange;
        }
        
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

- (IBAction)onSelectedChoice:(UITapGestureRecognizer *)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 2) {
    //        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //        CompatibilityItemBtn *btn = (CompatibilityItemBtn *)[cell.contentView viewWithTag:888];
    //        [self.itemVO setAnswer:self.itemVO.itemInfo[btn.answerIndex] andIndex:indexPath.row];
    //    }
}

@end
