//
//  BeckVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckVC.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface BeckVC ()

@end

@implementation BeckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavibar];
}

@end

@implementation UIViewController (Beck)

- (void)configNavibar
{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setNavigationBarButtonName:(NSString *)aName width:(CGFloat)aWidth isLeft:(BOOL)left
{
    UIButton *btn = [UIButton viewWithFrame:CGRectMake(0, 0, aWidth, 44)];
    [btn setTitle:aName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (left) {
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = btnItem;
    }
    else {
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = btnItem;
    }
}

- (void)leftBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick:(UIButton *)sender
{
    
}

@end

#import <AFNetworking/AFNetworking.h>

@implementation UIViewController (Net)

- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self.view hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    if (message) {
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
    }
    else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (second > 0) {
        [hud hide:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self.view];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/javascript", @"text/html",@"text/plain", nil];

    AFHTTPRequestOperation *operation = [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"\n\nabsoluteString = %@",[operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nresponseObject = %@",url,params,responseObject);
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n\nurl = %@\n\nparams = %@\n\nerror = %@",url,params,error);
        if (block) {
            block(operation, error);
        }
    }];

    [operation start];
}

- (void)getValueWithBeckUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block
{
//    NSString *beckUrl = [@"http://115.28.161.246:5080/beck" stringByAppendingString:url];
    NSString *beckUrl = [@"http://112.124.110.186:8080/beck" stringByAppendingString:url];
    [self getValueWithUrl:beckUrl params:params CompleteBlock:block];
}

@end

