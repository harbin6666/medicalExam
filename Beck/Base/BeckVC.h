//
//  BeckVC.h
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFSQLManager/AFSQLManager.h>

typedef void(^BeckCompletionBlock)(id aResponseObject, NSError* anError);

@interface BeckVC : UIViewController

@end

@interface UIViewController (Beck)

- (void)configNavibar;

- (IBAction)leftBtnClick:(UIButton *)sender;

- (IBAction)rightBtnClick:(UIButton *)sender;

- (void)setNavigationBarButtonName:(NSString *)aName width:(CGFloat)aWidth isLeft:(BOOL)left;

@end

@interface UIViewController (Net)

/**
 *  功能:显示loading
 */
- (void)showLoading;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second;

/**
 *  功能:隐藏loading
 */
- (void)hideLoading;

/**
 *  功能:隐藏loading
 */
- (void)hideLoadingOnView:(UIView *)aView;

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block;

- (void)getValueWithBeckUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block;

@end