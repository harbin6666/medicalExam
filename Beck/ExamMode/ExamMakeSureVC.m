//
//  ExamMakeSureVC.m
//  Beck
//
//  Created by Aimy on 14/12/6.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ExamMakeSureVC.h"

#import "ItemVO.h"
#import "ExamModePVC.h"

@interface ExamMakeSureVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic, strong) NSDictionary *examInfos;

@end

@implementation ExamMakeSureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.fromExam) {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        [btn setTitle:@"真题考试" forState:UIControlStateNormal];
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"考试科目：%@",self.questionBank[@"paperName"]];
    self.subTitleLabel.text = [NSString stringWithFormat:@"考试标准：%@题，%@分钟",self.questionBank[@"totalAmount"],self.questionBank[@"answerTime"]];
}

- (IBAction)onPressedEnterExam:(id)sender {
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/examPaperAct.htm" params:@{@"token":@"content",@"examPaperId":self.questionBank[@"id"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                self.examInfos = [aResponseObject[@"list"] lastObject];
                [self getItemsAndToNext:aResponseObject[@"list"]];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"获取试题失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)getItemsAndToNext:(NSArray *)infos
{
    [self showLoading];
    NSArray *listComposition = infos.lastObject[@"listComposition"];
    NSMutableArray *ids = [NSMutableArray array];
    [listComposition enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *part = obj;
        NSString *customId = part[@"customId"];
        NSArray *listContent = part[@"listContent"];
        [listContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *item = obj;
            ItemVO *itemVO = [ItemVO createWithItemId:item[@"itemId"] andType:customId.intValue score:item[@"score"]];
            [ids addObject:itemVO];
        }];
    }];
    
    if (!ids.count) {
        [[OTSAlertView alertWithMessage:@"获取试卷失败" andCompleteBlock:nil] show];
    }
    else {
        [self performSegueWithIdentifier:@"toNext" sender:ids];
    }
    [self hideLoading];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ExamModePVC *vc = segue.destinationViewController;
    vc.examInfos = self.examInfos;
    vc.items = sender;
    vc.fromExam = self.fromExam;
}

@end
