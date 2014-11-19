//
//  BeckLoginVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckLoginVC.h"

#import "AppDelegate.h"

#import <TencentOpenAPI/TencentOAuth.h>
//#import <RennSDK/RennSDK.h>

@interface BeckLoginVC () <TencentSessionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation BeckLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.loginVC = self;
    
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kOpenQQAppKey andDelegate:self];
    
    [WeiboSDK registerApp:kSinaAppKey];
    
//    [RennClient initWithAppId:kRenRenAppId
//                       apiKey:kRenRenAppKey
//                    secretKey:kRenRenAppSecretKey];

    //不设置则获取默认权限
//    [RennClient setScope:@"read_user_blog read_user_photo read_user_status read_user_album read_user_comment read_user_share publish_blog publish_share send_notification photo_upload status_update create_album publish_comment publish_feed operate_like"];
}
- (IBAction)onPressedCheckBox:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)onPressedLogin:(id)sender {
    if (!self.usernameTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入密码" andCompleteBlock:nil] show];
        return;
    }
    
    if (!self.passwordTF.text.length) {
        [[OTSAlertView alertWithMessage:@"请输入账号" andCompleteBlock:nil] show];
        return;
    }
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/userAct.htm" params:@{@"token":@"login",@"loginName":self.usernameTF.text,@"passWord":self.passwordTF.text} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                [[OTSAlertView alertWithMessage:aResponseObject[@"token"] andCompleteBlock:nil] show];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setObject:self.usernameTF.text forKey:@"loginName"];
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"subjectId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.usernameTF.text = @"";
                self.passwordTF.text = @"";
//                [self performSegueWithIdentifier:@"toCus" sender:self];
                [self performSegueWithIdentifier:@"toHome" sender:self];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"登录失败" andCompleteBlock:nil] show];
        }
    }];
}


- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)unwindToThisVC:(UIStoryboardSegue *)segue {
    
}


- (IBAction)onPressedQQ:(id)sender {
    NSArray *permissions = @[kOPEN_PERMISSION_GET_USER_INFO,
                             kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                             kOPEN_PERMISSION_GET_INFO];
    [self.tencentOAuth authorize:permissions inSafari:NO];
}

- (IBAction)onPressedSina:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kSinaRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"BeckLoginVC",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (IBAction)onPressedRenRen:(id)sender {
//    if ([RennClient isLogin]) {
//        [RennClient logoutWithDelegate:self];
//    }
//    else {
//        [RennClient loginWithDelegate:self];
//    }
}

#pragma mark - <TencentLoginDelegate>

- (void)tencentDidLogin
{
    NSLog(@"QQ 登录成功");
    NSLog(@"openid = %@, accessToken = %@", self.tencentOAuth.openId, self.tencentOAuth.accessToken);
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"QQ 取消登录");
}

- (void)tencentDidNotNetWork {
    
}

#pragma mark - <WeiboSDKDelegate>

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        //(int)response.statusCode = 0 is ok
        NSLog(@"Sina 登录成功");
        NSLog(@"userID = %@, accessToken = %@", [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken]);
        
//        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
}

#pragma mark - <RennLoginDelegate>
- (void)rennLoginSuccess
{
    NSLog(@"Renren 登录成功");
//    NSLog(@"renren uid = %@, accessToken = %@", [RennClient uid], [RennClient accessToken]);
}

- (void)rennLogoutSuccess
{
    NSLog(@"Renren 注销成功");
}

@end
