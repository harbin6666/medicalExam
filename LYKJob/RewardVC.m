//
//  RewardVC.m
//  LYKJob
//
//  Created by Aimy on 14/12/7.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "RewardVC.h"

@interface RewardVC ()

@end

@implementation RewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLbl.text = [NSString stringWithFormat:@"获得宝箱%@个",self.roleDict[@"userExtra"][@"tueChest"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPressedCancel:(id)sender {
    self.view.alpha = 1.f;
    [UIView animateWithDuration:.5f animations:^{
        self.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
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
