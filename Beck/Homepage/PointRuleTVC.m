//
//  PointRuleTVC.m
//  Beck
//
//  Created by Aimy on 15/1/28.
//  Copyright (c) 2015年 Aimy. All rights reserved.
//

#import "PointRuleTVC.h"

@interface PointRuleTVC ()

@property (nonatomic, strong) NSArray *infos;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation PointRuleTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles = @[@"1.签到:",@"2.练习模式:",@"3.考试模式:(只计算首次考试分数)",@"4.意见反馈:"];
    
    self.infos =
  @[@[@"签到一次赠送10分",@"连续签到3天额外赠送10分",@"连续签到7天额外赠送30分",@"连续签到15天额外赠送50分",@"连续签到20天额外赠送70分",@"连续签到25天额外赠送90分",@"连续签到30天额外赠送100分",@"累计签到30天额外赠送50分"],
  @[@"做题数量达到200道赠送积分5分",@"做题数量达到500道赠送积分20分",@"做题数量达到1000道赠送积分50分",@"做题数量达到2000道赠送积分120分",@"做题数量达到10000道赠送积分700分"],
  @[@"考试分数达到60分赠送积分50分",@"考试分数达到70分赠送积分65分",@"考试分数达到80分赠送积分75分",@"考试分数达到90分赠送积分90分",@"考试分数达到95分赠送积分100分",@"考试分数达到100分赠送积分200分"],
  @[@"每次反馈意见得到采纳赠送积分200分"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30.f;
    }
    else {
        return 24.f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 0;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *infos = self.infos[section];
    return infos.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        cell.textLabel.text = self.titles[indexPath.section];
    }
    else {
        NSArray *infos = self.infos[indexPath.section];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SubTitleCell" forIndexPath:indexPath];
        cell.textLabel.text = infos[indexPath.row - 1];
    }
    
    return cell;
}

@end
