//
//  ExamModeVC.m
//  Beck
//
//  Created by Aimy on 10/10/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ExamModeVC.h"

@interface ExamModeVC ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favorateBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pageBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

@end

@implementation ExamModeVC

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
    [btn2 setTitle:@"收藏" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.favorateBtn.customView = btn2;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 44, 44);
    [btn3 setTitle:@"1/100" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.pageBtn.customView = btn3;
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0, 0, 44, 44);
    [btn4 setTitle:@"交卷" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.submitBtn.customView = btn4;
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0, 0, 44, 44);
    [btn5 setTitle:@"下一题" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:10.f];
    self.nextBtn.customView = btn5;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPressedPrevious:(UIBarButtonItem *)sender {
    
}

- (void)onPressedFavorate:(UIBarButtonItem *)sender {
    
}

- (void)onPressedPage:(UIBarButtonItem *)sender {
    
}

- (void)onPressedSubmit:(UIBarButtonItem *)sender {
    
}

- (void)onPressedNext:(UIBarButtonItem *)sender {
    
}

@end
