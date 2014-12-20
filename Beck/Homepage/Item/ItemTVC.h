//
//  ItemTVC.h
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "BeckTVC.h"

#import "ItemVO.h"

@interface ItemTVC : BeckTVC

@property (nonatomic) ItemType type;

@property (nonatomic, strong) ItemVO *itemVO;

+ (instancetype)createWitleItemVO:(ItemVO *)aVO;

- (NSString *)itemDespretion;

@end
