//
//  CancelContentCell.m
//  LYKJob
//
//  Created by Aimy on 14/11/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "CancelContentCell.h"

@interface CancelContentCell () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CancelContentCell

- (void)updateWithTitles:(NSArray *)titles
{
    self.titles = titles.mutableCopy;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count ?: 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.titles.count == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"CellNone" forIndexPath:indexPath];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
    label.text = self.titles[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.titles.count == 0) {
        return CGSizeMake(40, 30);
    }
    
    NSString *schoolName = self.titles[indexPath.row];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
    CGSize size = [schoolName boundingRectWithSize:CGSizeMake(300, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return CGSizeMake(size.width + 30, 30);
}

- (IBAction)onPressedCancelBtn:(UIButton *)sender {
    NSIndexPath *path = [self.collectionView indexPathForCell:[sender getCollectionViewCell]];
    [self.titles removeObjectAtIndex:path.row];
    [self.collectionView reloadData];
}

@end
