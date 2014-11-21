//
//  ItemPVC.m
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ItemPVC.h"

@interface ItemPVC ()

@end

@implementation ItemPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cusTabbar];
    self.cusTabbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items.firstObject];
    
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
    ItemTVC *tempVC = self.currentTVC;
    if (self.items.firstObject == tempVC.itemVO) {
        return;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObject:tempVC.itemVO] - 1]];
    
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
//    self.currentTVC.showAnswer = !self.currentTVC.showAnswer;
//    sender.selected = self.currentTVC.showAnswer;
//    [self.currentTVC.tableView reloadData];
}

- (void)onPressedBtn3:(UIButton *)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
//    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn4:(UIButton *)sender {
//    self.currentTVC.favorated = !self.currentTVC.favorated;
//    sender.selected = self.currentTVC.favorated;
}

- (void)onPressedBtn5:(UIButton *)sender {
    ItemTVC *tempVC = self.currentTVC;
    if (self.items.lastObject == tempVC.itemVO) {
        return;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObject:tempVC.itemVO] + 1]];
    
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

}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ItemTVC *tempVC = (ItemTVC *)viewController;
    if (self.items.firstObject == tempVC.itemVO) {
        return nil;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObject:tempVC.itemVO] - 1]];
    self.currentTVC = vc;
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ItemTVC *tempVC = (ItemTVC *)viewController;
    if (self.items.lastObject == tempVC.itemVO) {
        return nil;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObject:tempVC.itemVO] + 1]];
    self.currentTVC = vc;
    return vc;
}

@end
