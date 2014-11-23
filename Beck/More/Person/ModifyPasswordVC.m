//
//  ModifyPasswordVC.m
//  Beck
//
//  Created by Aimy on 14/10/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ModifyPasswordVC.h"

@interface ModifyPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *pwOldTF;
@property (weak, nonatomic) IBOutlet UITextField *pw1TF;
@property (weak, nonatomic) IBOutlet UITextField *pw2TF;

@end

@implementation ModifyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)onPressedDone:(id)sender {
    if (self.pwOldTF.text.length == 0) {
        [[OTSAlertView alertWithMessage:@"请输入当前密码" andCompleteBlock:nil] show];
        return;
    }
    
    if (self.pw1TF.text.length == 0) {
        [[OTSAlertView alertWithMessage:@"请输入新密码" andCompleteBlock:nil] show];
        return;
    }
    
    if (self.pw2TF.text.length == 0) {
        [[OTSAlertView alertWithMessage:@"请重复新密码" andCompleteBlock:nil] show];
        return;
    }
    
    if (![self.pw2TF.text isEqualToString:self.pw1TF.text]) {
        [[OTSAlertView alertWithMessage:@"新密码不一致" andCompleteBlock:nil] show];
        return;
    }
    
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userAct.htm" params:@{@"token":@"RetrievePassWord",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"],@"passWord":self.pw2TF.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"修改密码失败" andCompleteBlock:nil] show];
        }
    }];
}

@end
