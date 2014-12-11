//
//  EnterPasswordVC.h
//  LYKJob
//
//  Created by Aimy on 14/12/5.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EnterPasswordVCDelegate <NSObject>

- (void)registeSuccessd:(NSDictionary *)dict;

@end

@interface EnterPasswordVC : UIViewController

@property (nonatomic, weak) id<EnterPasswordVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *pw1;
@property (weak, nonatomic) IBOutlet UITextField *pw2;

@property (nonatomic, strong) NSString *username;

@end
