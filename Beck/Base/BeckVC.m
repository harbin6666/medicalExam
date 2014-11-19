//
//  BeckVC.m
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckVC.h"

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

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", @"text/javascript", @"text/html",@"text/plain", nil];

    AFHTTPRequestOperation *operation = [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(operation, error);
        }
    }];

    [operation start];
}

@end

