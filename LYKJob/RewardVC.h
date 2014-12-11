//
//  RewardVC.h
//  LYKJob
//
//  Created by Aimy on 14/12/7.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@property (nonatomic, copy) NSDictionary *roleDict;

@end
