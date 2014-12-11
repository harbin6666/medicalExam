//
//  IdeaTopVC.m
//  LYKJob
//
//  Created by Aimy on 14/12/8.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "IdeaTopVC.h"

@interface IdeaTopVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IdeaTopVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *roleImage = self.roleDict[@"userExtra"][@"conImgPrefix"];
    roleImage = [[roleImage componentsSeparatedByString:@"/"] lastObject];
    self.imageView.image = [UIImage imageNamed:roleImage];
    
    // Do any additional setup after loading the view.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"lyk" ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    __block NSUInteger index = 0;
    
    if (self.roleDict[@"userExtra"][@"constellation"][@"conType"]) {
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *infos = obj;
            if ([infos[@"conType"] isEqualToString:self.roleDict[@"userExtra"][@"constellation"][@"conType"]]) {
                index = idx;
                self.titleLabel.text = infos[@"name"];
                *stop = YES;
                return ;
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
