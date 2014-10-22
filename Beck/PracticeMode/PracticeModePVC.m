//
//  PracticeModePVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "PracticeModePVC.h"

#import "ItemTVC.h"

#import "AnswerCVC.h"

@interface PracticeModePVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *item1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item3;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item4;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item5;

@property (nonatomic, strong) ItemTVC *currentTVC;

@end

@implementation PracticeModePVC

- (void)awakeFromNib
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 44, 44);
    [btn1 setTitle:@"上一题" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn1.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.item1.customView = btn1;
    [btn1 addTarget:self action:@selector(onPressedBtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 44, 44);
    [btn2 setTitle:@"查看答案" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn2.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.item2.customView = btn2;
    [btn2 addTarget:self action:@selector(onPressedBtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 44, 44);
    [btn3 setTitle:@"未做" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn3.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.item3.customView = btn3;
    [btn3 addTarget:self action:@selector(onPressedBtn3:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, 0, 44, 44);
    [btn4 setTitle:@"收藏" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn4.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.item4.customView = btn4;
    [btn4 addTarget:self action:@selector(onPressedBtn4:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0, 0, 44, 44);
    [btn5 setTitle:@"下一题" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn5.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.item5.customView = btn5;
    [btn5 addTarget:self action:@selector(onPressedBtn5:) forControlEvents:UIControlEventTouchUpInside];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPressedBtn1:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    
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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn4:(UIButton *)sender {
    self.currentTVC.favorated = !self.currentTVC.favorated;
    sender.selected = self.currentTVC.favorated;
}

- (void)onPressedBtn5:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    
    
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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    return vc;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    return vc;
}

#pragma mark - <UIPageViewControllerDelegate>

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
