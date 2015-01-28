//
//  HelpVC.m
//  Beck
//
//  Created by Aimy on 14/10/28.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "HelpCVC.h"

#import "HelpCVCell.h"

@interface HelpCVC ()

@end

@implementation HelpCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = self.view.bounds.size;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HelpCVCell" forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"help%d",(int)indexPath.row]];
    
    return cell;
}

@end
