//
//  HomepageTVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "HomepageTVC.h"

#import "HomepageTableViewCell.h"

@interface HomepageTVC () <HomepageTableViewCellDelegate>

@property (nonatomic, strong) NSArray *names;

@end

@implementation HomepageTVC

- (void)awakeFromNib
{
    CGFloat width = [UIScreen mainScreen].currentMode.size.width / 2 / 3;
    self.tableView.rowHeight = width;
    
    self.names = @[@"学习模式",@"考试模式",@"只能出题",@"高频考点",@"错题重做",@"题目收藏",@"笔记总结",@"练习历史",@"统计分析",@"考点资讯",@"考点交流",@"设置"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomepageCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateCellWithNames:[self.names subarrayWithRange:NSMakeRange(indexPath.row * 3, 3)] imageView:@[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)homepageTableViewCell:(HomepageTableViewCell *)aCell didSelectedAtIndex:(NSInteger)aIndex
{
    NSIndexPath *path = [self.tableView indexPathForCell:aCell];
    NSInteger index = path.row * 3 + aIndex;
    NSLog(@"%d",(int)index);
    
    if (index == 11) {
        [self performSegueWithIdentifier:@"toSetting" sender:nil];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
