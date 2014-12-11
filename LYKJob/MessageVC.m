//
//  MessageVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MessageVC.h"

#import "MessageDetailVC.h"
#import "MessageCell.h"

@interface MessageVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *messages;

@property (nonatomic) NSInteger pageNO;

@property (weak, nonatomic) IBOutlet UILabel *nilLbael;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 142, 0);
    
    [self showLoading];
    [self getValueWithLYKUrl:@"/resumeJ!getPositionMessages" params:@{@"pageNO":@(self.pageNO)} CompleteBlock:^(id aResponseObject, NSError *anError) {
        if (!anError) {
            self.messages = aResponseObject[@"messages"];
            if (self.messages.count == 0) {
                self.nilLbael.hidden = NO;
            }
            else {
                self.nilLbael.hidden = YES;
            }
            
            [self.tableView reloadData];
        }
        else {
            self.nilLbael.hidden = NO;
            [[OTSAlertView alertWithMessage:@"获取消息列表失败" andCompleteBlock:nil] show];
        }
        [self hideLoading];
    }];
}

- (IBAction)onPressedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.messages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell updateWithInfos:self.messages[indexPath.section]];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MessageDetailVC *vc = [segue destinationViewController];
    vc.emplId = self.messages[[self.tableView.indexPathForSelectedRow section]][@"emplId"];
}


@end
