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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configNavibar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation UIViewController (Beck)

- (void)configNavibar
{
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//
//    UIButton *leftBtn = [UIButton viewWithFrame:CGRectMake(0, 0, 44, 44)];
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftBtnItem;
}

- (void)leftBtnClick:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick:(UIBarButtonItem *)sender
{
    
}

@end