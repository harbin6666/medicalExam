//
//  BeckVC.h
//  Beck
//
//  Created by Aimy on 14/10/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BeckCompletionBlock)(id aResponseObject, NSError* anError);

@interface BeckVC : UIViewController

@end

@interface UIViewController (Beck)

- (void)configNavibar;

- (void)leftBtnClick:(UIBarButtonItem *)sender;

- (void)rightBtnClick:(UIBarButtonItem *)sender;

@end

@interface UIViewController (Net)

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block;

@end