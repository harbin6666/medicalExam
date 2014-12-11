//
//  UIViewController+net.h
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FILES_SERVER @"http://files.leyikao.net/"

typedef void(^LYKCompletionBlock)(id aResponseObject, NSError* anError);

@interface BeckVC : UIViewController

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

@end

@interface NSObject (net)

- (void)upload:(UIImage *)image completeBlock:(LYKCompletionBlock)block progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))pblock;

- (void)getValueTicketWithParams:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block;

- (void)getBoolValueWithLYKUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block;

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block;

- (void)getValueWithLYKUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(LYKCompletionBlock)block;

- (UITableViewCell *)getTableViewCell;

- (UICollectionViewCell *)getCollectionViewCell;

@end