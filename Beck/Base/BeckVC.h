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

- (IBAction)leftBtnClick:(UIButton *)sender;

- (IBAction)rightBtnClick:(UIButton *)sender;

- (void)setNavigationBarButtonName:(NSString *)aName width:(CGFloat)aWidth isLeft:(BOOL)left;

@end

@interface UIViewController (Net)

- (void)getValueWithUrl:(NSString *)url params:(NSDictionary *)params CompleteBlock:(BeckCompletionBlock)block;

@end