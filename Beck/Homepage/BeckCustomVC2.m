//
//  BeckCustomVC2.m
//  Beck
//
//  Created by Aimy on 14/11/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckCustomVC2.h"

@interface BeckCustomVC2 ()

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, strong) NSMutableSet *set;

@end

@implementation BeckCustomVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    self.names = @[@"药事管理与法规",@"药学综合知识",@"药剂学",@"药理学"];
    
    self.set = [NSMutableSet set];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    
    if ([self.set containsObject:indexPath]) {
        cell.imageView.highlighted = YES;
    }
    else {
        cell.imageView.highlighted = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.set containsObject:indexPath]) {
        [self.set removeObject:indexPath];
    }
    else {
        [self.set addObject:indexPath];
    }
    
    [tableView reloadData];
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
