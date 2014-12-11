//
//  ChooseContentCell.h
//  LYKJob
//
//  Created by Aimy on 14/11/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseContentCell;

@protocol ChooseContentCellDelegate <NSObject>

- (void)needUpdateContentCell:(ChooseContentCell *)cell;

@end

@interface ChooseContentCell : UITableViewCell

@property (nonatomic, weak) id <ChooseContentCellDelegate> delegate;
@property (nonatomic, strong) NSString *titleKey;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *infos;

- (void)updateWithInfos:(NSArray *)infos;

+ (CGFloat)heightWithCellData:(id)data;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
