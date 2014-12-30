//
//  BeckMCTVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckMCTVC.h"

#import "BeckMCTVCell.h"

@interface BeckMCTVC ()

@property (nonatomic, strong) NSArray *names;

@end

@implementation BeckMCTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"发现新版本"];
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/bulletinAct.htm" params:@{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"], @"token":@"message"} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BeckMCTVCell heightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeckMCTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

@end
