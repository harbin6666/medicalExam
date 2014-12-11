//
//  ChooseContentCell.m
//  LYKJob
//
//  Created by Aimy on 14/11/27.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseContentCell.h"

@interface ChooseContentCell () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ChooseContentCell

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
    if ([@"certificateName" isEqualToString:_titleKey]) {
        NSString *title = [NSString stringWithFormat:@"%@(%@)",self.infos[indexPath.row][@"certificateName"],self.infos[indexPath.row][@"certificateDept"]];
        [btn setTitle:title forState:UIControlStateNormal];
    }
    else {
        [btn setTitle:self.infos[indexPath.row][self.titleKey] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *schoolName = self.infos[indexPath.row][self.titleKey];
    
    if ([@"certificateName" isEqualToString:_titleKey]) {
        NSString *title = [NSString stringWithFormat:@"%@(%@)",self.infos[indexPath.row][@"certificateName"],self.infos[indexPath.row][@"certificateDept"]];
        schoolName = title;
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
    CGSize size = [schoolName boundingRectWithSize:CGSizeMake(300, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return CGSizeMake(size.width, 30);
}

- (void)updateWithInfos:(NSArray *)infos
{
    self.infos = infos;
    [self.collectionView reloadData];
}

+ (CGFloat)heightWithCellData:(id)data
{
    if (data) {
        return 130;
    }
    return 0;
}

- (IBAction)onPressedBtn:(UIButton *)sender {
    self.infos = nil;
    self.title = [sender titleForState:UIControlStateNormal];
    [self.delegate needUpdateContentCell:self];
}

@end
