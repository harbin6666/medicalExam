//
//  BeckLoginVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckLoginVC.h"

#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>

@interface BeckLoginVC () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation BeckLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kOpenQQAppKey andDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"open id = %@, accessToken = %@", self.tencentOAuth.openId, self.tencentOAuth.accessToken);
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

- (void)tencentDidNotNetWork {
    
}

#pragma mark - <RennLoginDelegate>
- (void)rennLoginSuccess
{
    NSLog(@"登录成功");
}

- (void)rennLogoutSuccess
{
    NSLog(@"注销成功");
}


@end
