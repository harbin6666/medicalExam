//
//  EnterPasswordVC.m
//  Beck
//
//  Created by Aimy on 14/10/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "EnterPasswordVC.h"

@interface EnterPasswordVC ()

@property (weak, nonatomic) IBOutlet UITextField *pwTF1;
@property (weak, nonatomic) IBOutlet UITextField *pwTF2;

@end

@implementation EnterPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)onPressedConfirmBtn:(id)sender {
    if (!self.pwTF1.text || !self.pwTF2.text) {
        [[OTSAlertView alertWithMessage:@"请输入密码" andCompleteBlock:nil] show];
        return;
    }
    
    if (![self.pwTF1.text isEqualToString:self.pwTF2.text]) {
        [[OTSAlertView alertWithMessage:@"密码不匹配" andCompleteBlock:nil] show];
        return;
    }
    [self showLoading];
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userAct.htm" params:@{@"token":@"Makepassword",@"loginName":self.phoneNum,@"passWord":self.pwTF2.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
            }
            else {
                [self performSegueWithIdentifier:@"toLogin" sender:self];
            }
        }
    }];
}

@end
