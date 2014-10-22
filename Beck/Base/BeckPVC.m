//
//  BeckPVC.m
//  Beck
//
//  Created by Aimy on 14/10/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckPVC.h"

#import "BeckVC.h"

@interface BeckPVC ()

@end

@implementation BeckPVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configNavibar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return nil;
}

@end
