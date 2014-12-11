//
//  AlertVC.h
//  LYKJob
//
//  Created by Aimy on 14/11/25.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) BOOL noHP;

@property (nonatomic, strong) UIImage *roleImage;

@end
