//
//  RegisterVC.m
//  Beck
//
//  Created by Aimy on 14/10/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "RegisterVC.h"

#import "EnterCodeVC.h"

@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (nonatomic, strong) NSNumber *smsCode;

@end

@implementation RegisterVC

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
    EnterCodeVC *vc = segue.destinationViewController;
    vc.phoneNum = self.numberTF.text;
    vc.smsCode = self.smsCode;
}

- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)onPressedBtn:(id)sender {
    
    if (!self.numberTF.text || !self.numberTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入手机号" andCompleteBlock:nil] show];
        return;
    }
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userAct.htm" params:@{@"token":@"OnlyPhone", @"loginName":self.numberTF.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
                [self hideLoading];
            }
            else {
                [self getValueWithBeckUrl:@"/front/sendsmsAct.htm" params:@{@"loginName":self.numberTF.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
                    [self hideLoading];
                    if (!anError) {
                        NSNumber *errorcode = aResponseObject[@"errorcode"];
                        if (errorcode.boolValue) {
                            [[OTSAlertView alertWithMessage:@"发送失败" andCompleteBlock:nil] show];
                        }
                        else {
                            self.smsCode = aResponseObject[@"value"];
                            [self performSegueWithIdentifier:@"toNext" sender:self];
                        }
                    }
                }];
            }
        }
        else {
            [self hideLoading];
        }
    }];
}
@end
