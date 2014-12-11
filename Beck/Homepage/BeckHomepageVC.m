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

@property (weak, nonatomic) IBOutlet UILabel *countDownLbl;

@end

@implementation BeckHomepageVC

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.tabbar.selectedItem = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        UITabBarItem *item1 = self.tabbar.items[0];
        [item1 setSelectedImage:[[UIImage imageNamed:@"tab1_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item2 = self.tabbar.items[1];
        [item2 setSelectedImage:[[UIImage imageNamed:@"tab2_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item3 = self.tabbar.items[2];
        [item3 setSelectedImage:[[UIImage imageNamed:@"tab3_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item4 = self.tabbar.items[3];
        [item4 setSelectedImage:[[UIImage imageNamed:@"tab4_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        UITabBarItem *item1 = self.tabbar.items[0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"tab1_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1"]];
        
        UITabBarItem *item2 = self.tabbar.items[1];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"tab1_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1"]];
        
        UITabBarItem *item3 = self.tabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"tab1_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1"]];
        
        UITabBarItem *item4 = self.tabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"tab1_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab1"]];
    }
    
    WEAK_SELF;
    [self getValueWithBeckUrl:@"/front/examSubjectAct.htm" params:@{@"token":@"countdown",@"loginName":[[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"]} CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.boolValue) {
                
            }
            else {
                NSNumber *days = aResponseObject[@"numberDay"];
                self.countDownLbl.text = [NSString stringWithFormat:@"距离考试还有%@天",days];
            }
        }
        else {
            
        }
    }];
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
    
    UIViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
