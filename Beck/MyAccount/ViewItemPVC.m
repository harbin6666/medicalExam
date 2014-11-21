//
//  ViewItemPVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ViewItemPVC.h"

#import "ItemTVC.h"

#import "AnswerCVC.h"

@interface ViewItemPVC () <UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *item1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item3;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item4;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item5;

@property (nonatomic, strong) ItemTVC *currentTVC;

@property (strong, nonatomic) IBOutlet UITabBar *cusTabbar;

@end

@implementation ViewItemPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cusTabbar];
    self.cusTabbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setSelectedImage:[[UIImage imageNamed:@"answer_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setSelectedImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setSelectedImage:[[UIImage imageNamed:@"favorate_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    else {
        UITabBarItem *item1 = self.cusTabbar.items[0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        
        UITabBarItem *item2 = self.cusTabbar.items[1];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"answer_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"answer"]];
        
        UITabBarItem *item3 = self.cusTabbar.items[2];
        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"setting"] withFinishedUnselectedImage:[UIImage imageNamed:@"setting"]];
        
        UITabBarItem *item4 = self.cusTabbar.items[3];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"favorate_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"favorate"]];
        
        UITabBarItem *item5 = self.cusTabbar.items[4];
        [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    vc.showNote = YES;
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configToolBar];
                  }];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            [self onPressedBtn1:nil];
            break;
        case 1:
            [self onPressedBtn2:nil];
            break;
        case 2:
            [self onPressedBtn3:nil];
            break;
        case 3:
            [self onPressedBtn4:nil];
            break;
        case 4:
            [self onPressedBtn5:nil];
            break;
        default:
            break;
    }
}

- (void)onPressedBtn1:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    vc.showNote = YES;
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configToolBar];
                  }];
}

- (void)onPressedBtn2:(UIButton *)sender {
    self.currentTVC.showAnswer = !self.currentTVC.showAnswer;
    sender.selected = self.currentTVC.showAnswer;
    [self.currentTVC.tableView reloadData];
}

- (void)onPressedBtn3:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn4:(UIButton *)sender {
    self.currentTVC.favorated = !self.currentTVC.favorated;
    sender.selected = self.currentTVC.favorated;
}

- (void)onPressedBtn5:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    vc.showNote = YES;
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configToolBar];
                  }];
}

- (void)configToolBar
{
    ((UIButton *)self.item2.customView).selected = self.currentTVC.showAnswer;
    ((UIButton *)self.item4.customView).selected = self.currentTVC.favorated;
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    vc.showNote = YES;
    self.currentTVC = vc;
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    vc.showNote = YES;
    self.currentTVC = vc;
    return vc;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end
