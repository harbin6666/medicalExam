//
//  AnswerCVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "AnswerCVC.h"

#import "ItemVO.h"
#import "AnswerCVCCell.h"

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
    AnswerCVCCell *cell = nil;
    if (self.showRightInItemCVC) {
        ItemVO *vo = self.items[indexPath.row];
        if (vo.isRight) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellRight" forIndexPath:indexPath];
        }
        else {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWrong" forIndexPath:indexPath];
        }
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellNormal" forIndexPath:indexPath];
    }
    
    [cell updateWithIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.vcDelegate didSelectedItemIndexInAnswerCVC:indexPath.row];
}

@end
