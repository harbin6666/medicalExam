//
//  MyAccountHomeTVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MyAccountHomeTVC.h"

#import "MyAccountSubjectTVC.h"

@interface MyAccountHomeTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation MyAccountHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"统计", @"查看笔记", @"题目收藏", @"错题重做"];
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
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"MA%li",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toStatistic" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"toNext" sender:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender) {
        NSIndexPath *path = sender;
        MyAccountSubjectTVC *vc = segue.destinationViewController;
        if (path.row == 1) {
            vc.toType = toNotes;
        }
        else if (path.row == 2) {
            vc.toType = toFavorate;
        }
        else {
            vc.toType = toError;
        }
    }
}

@end
