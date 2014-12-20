//
//  PractiseHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PractiseHomeTVC.h"

@interface PractiseHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation PractiseHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"章节练习"];
    //    self.names = @[@"章节练习",@"题库练习"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.names[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"practise%li",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toQuestionBank" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"toItemType" sender:self];
    }
}

@end
