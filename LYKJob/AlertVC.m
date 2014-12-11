//
//  AlertVCm
//  LYKJob
//
//  Created by Aimy on 14/11/25.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "AlertVC.h"

@interface AlertVC ()

@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageVIew.image = self.roleImage;
    
    if (self.noHP) {
        self.label.text = @"体力不足20，无法挑战，请增加体力值（点击红瓶完善个人信息课增加体力）或等体力值恢复（每分钟恢复一点体力值）。";
    }
    else {
        self.label.text = @"没有宝箱了，完成挑战可掉落宝箱.";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPressedNoBox:(id)sender {
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
