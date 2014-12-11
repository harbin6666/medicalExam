//
//  EnterPasswordVC.m
//  LYKJob
//
//  Created by Aimy on 14/12/5.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "EnterPasswordVC.h"

@interface EnterPasswordVC ()

@end

@implementation EnterPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onPressedCancel:(id)sender {
    self.view.alpha = 1.f;
    [UIView animateWithDuration:.5f animations:^{
        self.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (IBAction)onPressedDone:(id)sender {
    if (!self.pw1.text.length || !self.pw2.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入密码" andCompleteBlock:nil] show];
        return ;
    }
    
    if (self.pw1.text.length < 5) {
        [[OTSAlertView alertWithMessage:@"密码不能小于6位" andCompleteBlock:nil] show];
        return ;
    }
    
    if (self.pw1.text.length > 30) {
        [[OTSAlertView alertWithMessage:@"密码不能大于30位" andCompleteBlock:nil] show];
        return ;
    }
    
    if (![self.pw1.text isEqualToString:self.pw2.text]) {
        [[OTSAlertView alertWithMessage:@"密码不一致" andCompleteBlock:nil] show];
        return ;
    }
    
    [self getValueWithLYKUrl:@"/userJ!register" params:@{@"user.userEmail":self.username,@"user.userPwd":self.pw1.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
        if (aResponseObject[@"user"][@"userId"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:aResponseObject];
            [self onPressedCancel:nil];
            [self.delegate registeSuccessd:aResponseObject];
        }
        else {
            [[OTSAlertView alertWithMessage:@"注册失败" andCompleteBlock:nil] show];
        }
    }];
}

@end
