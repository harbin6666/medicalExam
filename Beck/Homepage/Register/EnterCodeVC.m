//
//  EnterCodeVC.m
//  Beck
//
//  Created by Aimy on 14/10/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "EnterCodeVC.h"

#import "EnterPasswordVC.h"

@interface EnterCodeVC ()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;
@property (weak, nonatomic) IBOutlet UITextField *smsTF;

@end

@implementation EnterCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phoneNumLbl.text = self.phoneNum;
}

- (IBAction)onPressedRefreshBtn:(id)sender {
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/sendsmsAct.htm" params:@{@"loginName":self.phoneNum} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:@"发送失败" andCompleteBlock:nil] show];
            }
            else {
                self.smsCode = aResponseObject[@"value"];
            }
        }
    }];
}

- (IBAction)onPressedBtn:(id)sender {
    if (!self.smsTF.text || !self.smsTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入验证码" andCompleteBlock:nil] show];
        return;
    }
    
    if ([self.smsCode.stringValue isEqualToString:self.smsTF.text]) {
        [self performSegueWithIdentifier:@"toNext" sender:self];
    }
    else {
        [[OTSAlertView alertWithMessage:@"验证码错误" andCompleteBlock:nil] show];
        return;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EnterPasswordVC *vc = segue.destinationViewController;
    vc.phoneNum = self.phoneNum;
    vc.findpw = self.findpw;
}


- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
