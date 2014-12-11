//
//  AnswerCVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "AnswerCVC.h"

@interface AnswerCVC ()

@end

@implementation AnswerCVC

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
    if (!label) {
        label = [UILabel viewWithFrame:cell.contentView.bounds];
        label.tag = 999;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.layer.cornerRadius = 5.f;
    }
    
    label.text = @(indexPath.row + 1).stringValue;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.vcDelegate didSelectedItemIndexInAnswerCVC:indexPath.row];
}

@end
