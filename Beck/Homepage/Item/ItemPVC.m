//
//  ItemPVC.m
//  Beck
//
//  Created by Aimy on 14/11/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ItemPVC.h"

@interface ItemPVC () <AnswerCVCDelegate>

@end

@implementation ItemPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cusTabbar];
    self.cusTabbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cusTabbar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cusTabbar)]];
    
    [self configTabBar];
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items.firstObject];
    vc.canShowNote = self.canShowNote;
    
    if (!vc) {
        return;
    }
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configTabBar];
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
    static BOOL done = YES;
    
    if (!done) {
        return;
    }
    
    done = NO;
    
    ItemTVC *tempVC = self.currentTVC;
    if (self.items.firstObject == tempVC.itemVO) {
        [self configTabBar];
        done = YES;
        return;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObjectIdenticalTo:tempVC.itemVO] - 1]];
    vc.canShowNote = self.canShowNote;
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configTabBar];
                      done = YES;
                  }];
}

- (void)onPressedBtn2:(UIButton *)sender {
//    self.currentTVC.showAnswer = !self.currentTVC.showAnswer;
//    sender.selected = self.currentTVC.showAnswer;
//    [self.currentTVC.tableView reloadData];
}

- (void)onPressedBtn3:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
    vc.items = self.items;
    vc.vcDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn4:(UIButton *)sender {
//    self.currentTVC.favorated = !self.currentTVC.favorated;
//    sender.selected = self.currentTVC.favorated;
}

- (void)onPressedBtn5:(UIButton *)sender {
    static BOOL done = YES;
    
    if (!done) {
        return;
    }
    
    done = NO;
    
    ItemTVC *tempVC = self.currentTVC;
    if (self.items.lastObject == tempVC.itemVO) {
        [self configTabBar];
        done = YES;
        return;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObjectIdenticalTo:tempVC.itemVO] + 1]];
    vc.canShowNote = self.canShowNote;
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configTabBar];
                      done = YES;
                  }];
}

- (void)configTabBar
{
    ItemTVC *tempVC = self.currentTVC;
    
    UITabBarItem *item1 = self.cusTabbar.items[0];
    UITabBarItem *item5 = self.cusTabbar.items[4];
    if (self.items.firstObject == tempVC.itemVO) {
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            [item1 setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item1 setSelectedImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back"] withFinishedUnselectedImage:[UIImage imageNamed:@"back"]];
        }
        
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    }
    else {
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            [item1 setImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item1 setSelectedImage:[[UIImage imageNamed:@"back_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item1 setFinishedSelectedImage:[UIImage imageNamed:@"back_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"back_sel"]];
        }
        
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    }
    
    if (self.items.lastObject == tempVC.itemVO) {
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            [item5 setImage:[[UIImage imageNamed:@"next"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item5 setSelectedImage:[[UIImage imageNamed:@"next"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next"] withFinishedUnselectedImage:[UIImage imageNamed:@"next"]];
        }
        
        [item5 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [item5 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateSelected];
    }
    else {
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            [item5 setImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [item5 setSelectedImage:[[UIImage imageNamed:@"next_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else {
            [item5 setFinishedSelectedImage:[UIImage imageNamed:@"next_sel"] withFinishedUnselectedImage:[UIImage imageNamed:@"next_sel"]];
        }
        
        [item5 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
        [item5 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    }
    
    if (self.items.count) {
        self.title = [NSString stringWithFormat:@"%d/%d",(int)[self.items indexOfObjectIdenticalTo:self.currentTVC.itemVO] + 1,(int)self.items.count];
    }
    else {
        self.title = @"0/0";
    }
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ItemTVC *tempVC = (ItemTVC *)viewController;
    self.currentTVC = tempVC;
    [self configTabBar];
    if (self.items.firstObject == tempVC.itemVO) {
        return nil;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObjectIdenticalTo:tempVC.itemVO] - 1]];
    vc.canShowNote = self.canShowNote;
    
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ItemTVC *tempVC = (ItemTVC *)viewController;
    self.currentTVC = tempVC;
    [self configTabBar];
    if (self.items.lastObject == tempVC.itemVO) {
        return nil;
    }
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[[self.items indexOfObjectIdenticalTo:tempVC.itemVO] + 1]];
    vc.canShowNote = self.canShowNote;
    
    return vc;
}

#pragma mark <AnswerCVCDelegate>
- (void)didSelectedItemIndexInAnswerCVC:(NSInteger)index
{
    [self.navigationController popViewControllerAnimated:YES];
    
    ItemTVC *vc = [ItemTVC createWitleItemVO:self.items[index]];
    vc.canShowNote = self.canShowNote;
    
    if (!vc) {
        return;
    }
    
    WEAK_SELF;
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      STRONG_SELF;
                      self.currentTVC = vc;
                      [self configTabBar];
                  }];
}

- (void)doFavorate
{
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"token"] = @"add";
    
    NSMutableDictionary *json = @{}.mutableCopy;
    json[@"titleId"] = self.currentTVC.itemVO.itemId;
    json[@"typeId"] = @(self.currentTVC.itemVO.type);
    json[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
    json[@"subjectId"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"];
    json[@"outlineId"] = self.currentTVC.itemVO.outlineId;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"json"] = jsonString;
    
    WEAK_SELF;
    [self showLoading];
    [self getValueWithBeckUrl:@"/front/userCollectionAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        [self hideLoading];
        if (!anError) {
            NSNumber *errorcode = aResponseObject[@"errorcode"];
            if (errorcode.integerValue == 2) {
                self.currentTVC.showAnswer = YES;
                [[OTSAlertView alertWithMessage:@"收藏成功" andCompleteBlock:nil] show];
                [self configTabBar];
            }
            else {
                self.currentTVC.showAnswer = NO;
                [[OTSAlertView alertWithMessage:@"收藏失败" andCompleteBlock:nil] show];
            }
        }
        else {
            [[OTSAlertView alertWithMessage:@"收藏失败" andCompleteBlock:nil] show];
        }
    }];
}

- (void)setTabBarItemImage:(NSString *)image index:(NSInteger)index
{
    
}

- (BOOL)canShowNote
{
    return YES;
}

@end
