//
//  NotesTVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "NotesTVC.h"

@interface NotesTVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray *notes;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NotesTVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.segmentedControl = (UISegmentedControl *)self.tableView.tableHeaderView;
    CGRect rc = self.segmentedControl.bounds;
    rc.size.height = 44;
    self.segmentedControl.bounds = rc;
    
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0],NSUnderlineStyleAttributeName:@4.f} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeValue:self.segmentedControl];
}

- (IBAction)changeValue:(UISegmentedControl *)sender {
    [self showLoading];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    
    if (sender.selectedSegmentIndex == 0) {
        params[@"token"] = @"subject";
    }
    else if (sender.selectedSegmentIndex == 1) {
        params[@"token"] = @"type";
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    else {
        params[@"token"] = @"outline";
        params[@"subjectId"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"subjectId"];
    }
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userNoteAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"token"] andCompleteBlock:nil] show];
            }
            else {
                self.notes = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"登录失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotesCell" forIndexPath:indexPath];
    
    NSDictionary *note = self.notes[indexPath.row];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = note[@"subjectName"];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = note[@"customName"];
    }
    else {
        cell.textLabel.text = note[@"outlineName"];
    }
    
    cell.detailTextLabel.text = note[@"count"];
    
    return cell;
}

@end
