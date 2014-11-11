//
//  BeckCustomVC1.m
//  Beck
//
//  Created by Aimy on 14/11/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckCustomVC1.h"

@interface BeckCustomVC1 () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, strong) NSIndexPath *path;

@end

@implementation BeckCustomVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.names = @[@"主管药师",@"药师",@"药士",@"主管中药师",@"中药师",@"中药士"];
    
    self.path = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onPressedChangePlaceBtn:(id)sender {
    [sender becomeFirstResponder];
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
    
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:999];
    lbl.text = self.names[indexPath.row];
    
    UIImageView *check = (UIImageView *)[cell.contentView viewWithTag:888];
    
    if ([self.path compare:indexPath] == NSOrderedSame) {
        check.highlighted = YES;
    }
    else {
        check.highlighted = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.path = indexPath;
    [tableView reloadData];
}

@end
