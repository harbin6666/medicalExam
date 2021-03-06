//
//  PractiseStatisticCVC.m
//  Beck
//
//  Created by Aimy on 14/11/2.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PractiseStatisticCVC.h"

#import "PractiseStatisticDetailVC.h"

@interface PractiseStatisticCVC () <UICollectionViewDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UILabel *lbl7;

@property (nonatomic, strong) NSArray *exams;

@end

@implementation PractiseStatisticCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoading];
    
    NSMutableDictionary *params = @{@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]}.mutableCopy;
    params[@"token"] = @"list";
    params[@"subjectId"] = self.subjectId;
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userExerciseAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                NSDictionary *exam = [aResponseObject[@"list"] lastObject];
                self.exams = exam[@"list"];
                [self.collectionView reloadData];
                self.lbl1.text = [NSString stringWithFormat:@"您总共进行了%@次模拟练习",exam[@"count"]];
                self.lbl5.text = [NSString stringWithFormat:@"最高成绩：%@分",exam[@"highest"]];
                self.lbl6.text = [NSString stringWithFormat:@"最低成绩：%@分",exam[@"lowGrade"]];
                self.lbl7.text = [NSString stringWithFormat:@"平均成绩：%@分",exam[@"average"]];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"查询统计失败" andCompleteBlock:nil] show];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.exams.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:999];
    lbl.text = @(indexPath.row + 1).stringValue;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"toPractiseDetail" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PractiseStatisticDetailVC *vc = segue.destinationViewController;
    vc.detail = self.exams[[sender row]];
    vc.index = [sender row] + 1;
    vc.subjectId = self.subjectId;
}

@end
