//
//  BeckVC.h
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeckVC : UIViewController

@end

@interface UIViewController (Beck)

- (void)configNavibar;

- (void)leftBtnClick:(UIBarButtonItem *)sender;

- (void)rightBtnClick:(UIBarButtonItem *)sender;

@end