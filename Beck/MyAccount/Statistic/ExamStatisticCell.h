//
//  ExamStatisticCell.h
//  Beck
//
//  Created by Aimy on 14/11/13.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamStatisticCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *highLbl;
@property (weak, nonatomic) IBOutlet UILabel *lowLbl;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;

@end
