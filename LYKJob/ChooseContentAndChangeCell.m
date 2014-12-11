//
//  ChooseContentAndChangeCell.m
//  LYKJob
//
//  Created by Aimy on 14/12/1.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "ChooseContentAndChangeCell.h"

@interface ChooseContentAndChangeCell ()

@property (nonatomic) NSInteger pageNo;

@end

@implementation ChooseContentAndChangeCell

- (void)prepareForReuse
{
    self.pageNo = 0;
}

- (void)updateWithInfos:(NSArray *)infos
{
    if (!infos) {
        [self onPressedChangeBtn:nil];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
    if (self.fromIntent) {
        [btn setTitle:self.infos[indexPath.row][@"jobFunctionName"] forState:UIControlStateNormal];
    }
    else {
        [btn setTitle:self.infos[indexPath.row] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *schoolName = nil;
    if (self.fromIntent) {
        schoolName = self.infos[indexPath.row][@"jobFunctionName"];
    }
    else {
        schoolName = self.infos[indexPath.row];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
    CGSize size = [schoolName boundingRectWithSize:CGSizeMake(300, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return CGSizeMake(size.width, 30);
}

- (IBAction)onPressedChangeBtn:(id)sender {
    NSString *url = @"/resumeJ!getFeatures";
    if (self.fromIntent) {
        url = @"/resumeJ!getJobFunctions";
    }
    
    [self getValueWithLYKUrl:url params:@{@"pageNo":@(self.pageNo)} CompleteBlock:^(id aResponseObject, NSError *anError) {
        if (self.fromIntent) {
            if ([aResponseObject[@"jobFunctions"] isKindOfClass:[NSArray class]]) {
                self.pageNo++;
                self.infos = aResponseObject[@"jobFunctions"];
            }
        }
        else {
            if ([aResponseObject[@"features"] isKindOfClass:[NSArray class]]) {
                self.pageNo++;
                self.infos = aResponseObject[@"features"];
            }
        }
        [self.collectionView reloadData];
    }];
}

- (IBAction)onPressedBtn:(UIButton *)sender {
    self.title = [sender titleForState:UIControlStateNormal];
    [self.delegate needUpdateContentCell:self];
}

@end
