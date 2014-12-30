//
//  BeckMCTVCell.m
//  Beck
//
//  Created by Aimy on 14/12/29.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "BeckMCTVCell.h"

@interface BeckMCTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation BeckMCTVCell

+ (CGFloat)heightWithData:(NSDictionary *)info
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
    CGSize size = [info[@"content"] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 38 - 10, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height + 51;
}

- (void)updateWithData:(NSDictionary *)info
{
    self.typeLabel.text = info[@"title"];
    self.messageLabel.text = info[@"content"];
    self.dateLabel.text = info[@"issueTime"];
    
    NSNumber *type = info[@"type"];
    if (type.intValue == 5) {
        self.typeImageView.image = [UIImage imageNamed:@"m_s"];
    }
    else {
        self.typeImageView.image = [UIImage imageNamed:@"m_p"];
    }
}

@end
