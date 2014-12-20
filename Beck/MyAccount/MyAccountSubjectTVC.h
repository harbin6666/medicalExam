//
//  MyAccountSubjectTVC.h
//  Beck
//
//  Created by Aimy on 14/12/20.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckTVC.h"

typedef enum MyAccountSubjectTVCToType {
    toPractise = 1,
    toExam,
    toNotes,
    toFavorate,
    toError,
} MyAccountSubjectTVCToType;

@interface MyAccountSubjectTVC : BeckTVC

@property (nonatomic) MyAccountSubjectTVCToType toType;

@end
