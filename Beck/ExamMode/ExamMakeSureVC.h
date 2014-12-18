//
//  ExamMakeSureVC.h
//  Beck
//
//  Created by Aimy on 14/12/6.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckVC.h"

@interface ExamMakeSureVC : BeckVC

@property (nonatomic) BOOL fromExam;
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSDictionary *questionBank;

@end
