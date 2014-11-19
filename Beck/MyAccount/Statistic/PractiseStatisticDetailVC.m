//
//  PractiseStatisticDetailVC.m
//  Beck
//
//  Created by Aimy on 14/11/19.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "PractiseStatisticDetailVC.h"

@interface PractiseStatisticDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation PractiseStatisticDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbl1.text = [NSString stringWithFormat:@"第%d次考试",(int)self.index];
    self.lbl2.text = self.detail[@"date"];
    self.lbl3.text = self.detail[@"right"];
    self.lbl4.text = self.detail[@"wrong"];
    self.lbl5.text = self.detail[@"accuracy"];
    [self.btn setTitle:self.detail[@"score"] forState:UIControlStateNormal];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
