//
//  FindPasswordVC.m
//  Beck
//
//  Created by Aimy on 14/10/21.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "FindPasswordVC.h"

@interface FindPasswordVC ()

@end

@implementation FindPasswordVC

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

- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
