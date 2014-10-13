//
//  ExamResultCell.h
//  Beck
//
//  Created by Aimy on 10/13/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *itemCount;

@property (weak, nonatomic) IBOutlet UILabel *result;

@end
