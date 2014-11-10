//
//  BeckHomepageVC.m
//  Beck
//
//  Created by Aimy on 14/10/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckHomepageVC.h"

@interface BeckHomepageVC () <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

@end

@implementation BeckHomepageVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabbar.selectedItem = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    UIStoryboard *sb = nil;
    switch (item.tag) {
        case 0:
            sb = [UIStoryboard storyboardWithName:@"MyAccount" bundle:nil];
            break;
        case 1:
            sb = [UIStoryboard storyboardWithName:@"Practise" bundle:nil];
            break;
        case 2:
            sb = [UIStoryboard storyboardWithName:@"Exam" bundle:nil];
            break;
        case 3:
            sb = [UIStoryboard storyboardWithName:@"More" bundle:nil];
            break;
        default:
            break;
    }
    
    if (!sb) {
        self.tabbar.selectedItem = nil;
        return ;
    }
    
    UIViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
