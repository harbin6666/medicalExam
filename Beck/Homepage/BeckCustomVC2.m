//
//  BeckCustomVC2.m
//  Beck
//
//  Created by Aimy on 14/11/11.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckCustomVC2.h"

@interface BeckCustomVC2 ()

@property (nonatomic, strong) NSArray *subjectPositions;

@property (nonatomic, strong) NSMutableSet *set;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BeckCustomVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    self.set = [NSMutableSet set];
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/subjectPositionRelationAct.htm" params:@{@"token":@"subjectPositionRelation",@"titleId":self.position[@"id"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.subjectPositions = aResponseObject[@"list"];
                [self.tableView reloadData];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取考试科目失败" andCompleteBlock:nil] show];
        }
    }];
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
    return self.subjectPositions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *subjectPosition = self.subjectPositions[indexPath.row];
    cell.textLabel.text = subjectPosition[@"subjectName"];
    
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

- (IBAction)onPressedBtn:(id)sender {
    if (!self.set.count) {
        [[OTSAlertView alertWithMessage:@"请选择考试科目" andCompleteBlock:nil] show];
        return;
    }
    
    __block NSString *ids = @"";
    
    WEAK_SELF;
    [self.set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        STRONG_SELF;
        NSIndexPath *path = obj;
        NSDictionary *subjectPosition = self.subjectPositions[path.row];
        ids = [ids stringByAppendingFormat:@"%@,",subjectPosition[@"id"]];
    }];
    
    ids = [ids substringToIndex:ids.length - 1];
    
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userExamSubjectAct.htm" params:@{@"token":@"add",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"],@"titleId":[self.position[@"id"] stringValue],@"subjectIdList":ids} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setObject:self.position[@"id"] forKey:@"subjectId"];
                [[NSUserDefaults standardUserDefaults] setObject:self.position[@"titleName"] forKey:@"subjectTitleName"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self performSegueWithIdentifier:@"toHome" sender:self];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"设置考试科目失败" andCompleteBlock:nil] show];
        }
    }];
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
