//
//  PracticeModeVC.m
//  Beck
//
//  Created by Aimy on 10/9/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "PracticeModeVC.h"

#import "ItemTVC.h"

#import "AnswerCVC.h"

@interface PracticeModeVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favorateBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pageBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *answerBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

@end

@implementation PracticeModeVC

- (void)awakeFromNib
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 44, 44);
    [btn1 setTitle:@"上一题" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.previousBtn.customView = btn1;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 44, 44);
    [btn2 setTitle:@"查看答案" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.favorateBtn.customView = btn2;
    [btn2 addTarget:self action:@selector(onPressedBtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 44, 44);
    [btn3 setTitle:@"未做" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.pageBtn.customView = btn3;
    [btn3 addTarget:self action:@selector(onPressedBtn3:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, 0, 44, 44);
    [btn4 setTitle:@"收藏" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.answerBtn.customView = btn4;
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0, 0, 44, 44);
    [btn5 setTitle:@"下一题" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.nextBtn.customView = btn5;
    
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = [sb instantiateViewControllerWithIdentifier:@"ItemTVC"];
    
    [self setViewControllers:@[vc]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPressedBtn1:(UIBarButtonItem *)sender {
    
}

- (void)onPressedBtn2:(UIBarButtonItem *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn3:(UIBarButtonItem *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AnswerCVC *vc = [sb instantiateViewControllerWithIdentifier:@"AnswerCVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onPressedBtn4:(UIBarButtonItem *)sender {
    
}

- (void)onPressedBtn5:(UIBarButtonItem *)sender {
    
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
