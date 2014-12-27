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

@property (weak, nonatomic) IBOutlet UIImageView *hIV;
@property (weak, nonatomic) IBOutlet UIImageView *tIV;
@property (weak, nonatomic) IBOutlet UIImageView *cIV;

@end

@implementation BeckHomepageVC

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
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"tab2_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab2"]];
        
        UITabBarItem *item3 = self.tabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"tab3_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab3"]];
        
        UITabBarItem *item4 = self.tabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"tab4_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab4"]];
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
                int h = days.intValue / 100;
                int t = (days.intValue - h * 100) / 10;
                int c = days.intValue - h * 100 - t * 10;
                self.hIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"num%d",h]];
                self.tIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"num%d",t]];
                self.cIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"num%d",c]];
            }
        }
        else {
            
        }
    }];
}

- (IBAction)onPressedSignIn:(id)sender
{
    
}

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
