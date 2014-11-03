//
//  ModifyPasswordVC.m
//  Beck
//
//  Created by Aimy on 14/10/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ModifyPasswordVC.h"

@interface ModifyPasswordVC ()

@end

@implementation ModifyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTag:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
