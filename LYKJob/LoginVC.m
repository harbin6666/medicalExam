//
//  LoginVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "LoginVC.h"

#import "HomeVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPressedTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onPressedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPressedLoginBtn:(id)sender {
    if (!self.usernameTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入用户名" andCompleteBlock:nil] show];
        return ;
    }
    
    if (!self.passwordTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入密码" andCompleteBlock:nil] show];
        return ;
    }
    
    if (self.passwordTF.text.length < 5) {
        [[OTSAlertView alertWithMessage:@"密码不能小于6位" andCompleteBlock:nil] show];
        return ;
    }
    
    if (self.passwordTF.text.length > 30) {
        [[OTSAlertView alertWithMessage:@"密码不能大于30位" andCompleteBlock:nil] show];
        return ;
    }
    
    if (![self isValidateEmail:self.usernameTF.text]) {
        [[OTSAlertView alertWithMessage:@"邮箱格式不正确" andCompleteBlock:nil] show];
        return ;
    }
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"user.userEmail"] = self.usernameTF.text;
    params[@"user.userPwd"] = self.passwordTF.text;
    
    [self showLoading];
    [self getValueTicketWithParams:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        if (anError) {
            [[OTSAlertView alertWithMessage:@"用户名或密码错误" andCompleteBlock:nil] show];
        }
        else {
            [self performSegueWithIdentifier:@"toNext" sender:aResponseObject];
        }
        [self hideLoading];
    }];
}

-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toNext"]) {
        HomeVC *vc = segue.destinationViewController;
        vc.roleDict = sender;
    }
}


@end
