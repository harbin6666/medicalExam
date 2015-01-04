//
//  MultiChoiceItemTVC.m
//  Beck
//
//  Created by Aimy on 14/11/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "MultiChoiceItemTVC.h"

@interface MultiChoiceItemTVC ()

@end

@implementation MultiChoiceItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.allowsMultipleSelection = YES;
}

- (NSString *)itemDespretion
{
    return @"多项选择题：由一个题干和A，B，C，D，E五个备选答案组成，题干在前，选项在后，要求考生从五个备选答案种选出两个或两个以上的正确答案，多选，少选，错选均不得分";
}

@end
