//
//  AnswerCVC.h
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "BeckCVC.h"

@protocol AnswerCVCDelegate <NSObject>

- (void)didSelectedItemIndexInAnswerCVC:(NSInteger)index;

@end

@interface AnswerCVC : BeckCVC

@property (nonatomic, strong) NSArray *items;//<ItemVO>
@property (nonatomic, weak) id <AnswerCVCDelegate> vcDelegate;

@end
