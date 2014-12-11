//
//  HomeVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/25.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "HomeVC.h"

#import "AlertVC.h"
#import "IdeaVC.h"
#import "Persion1VC.h"
#import "Persion2VC.h"
#import "Persion3VC.h"
#import "ProfileVC.h"
#import "RewardVC.h"
#import "MessageDetailVC.h"

@interface HomeVC ()

@property (nonatomic,strong) AlertVC *alertVC;
@property (nonatomic,strong) RewardVC *rewardVC;

@property (weak, nonatomic) IBOutlet UIButton *physicalBtn;
@property (weak, nonatomic) IBOutlet UIButton *attackBtn;
@property (weak, nonatomic) IBOutlet UIButton *magicBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UIImageView *smallIcon;
@property (weak, nonatomic) IBOutlet UIImageView *roleImage;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.f target:self selector:@selector(updateHP) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"update" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSDictionary *dict = note.object;
        self.roleDict = dict;
        [self updateViews];
    }];
}

- (void)updateHP
{
    NSNumber *tueCurPhysical = self.roleDict[@"userExtra"][@"tueCurPhysical"];
    NSNumber *tuePhysical = self.roleDict[@"userExtra"][@"tuePhysical"];
    
    if (tueCurPhysical.integerValue < tuePhysical.integerValue) {
        tueCurPhysical = @(tueCurPhysical.integerValue + 1);
    }
    
    [self.physicalBtn setTitle:[tueCurPhysical stringValue] forState:UIControlStateNormal];
}

- (IBAction)onPressedBoxBtn:(id)sender {
    NSNumber *boxcount = self.roleDict[@"userExtra"][@"tueChest"];
                         
    if (boxcount.integerValue == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AlertVC *vc = [sb instantiateViewControllerWithIdentifier:@"AlertVC"];
        self.alertVC = vc;
        self.alertVC.roleImage = self.roleImage.image;
        
        vc.view.alpha = 0.f;
        [self.view addSubview:vc.view];
        [UIView animateWithDuration:.5f animations:^{
            vc.view.alpha = 1.f;
        }];
    }
    else {
        [self getValueWithLYKUrl:@"/resumeJ!toPositionBox" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
            if (!anError) {
                self.roleDict = aResponseObject;
                [self updateViews];
                [self performSegueWithIdentifier:@"toMessageDetail" sender:self];
            }
            else {
                [[OTSAlertView alertWithMessage:@"获取宝箱出错" andCompleteBlock:nil] show];
            }
        }];
    }
}
- (IBAction)onPressedChallengeBtn:(id)sender {
    [self showLoading];
    [self getBoolValueWithLYKUrl:@"/userJ!getGameRight" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
        if ([aResponseObject boolValue]) {
            [self getBoolValueWithLYKUrl:@"/userJ!playGame" params:nil CompleteBlock:^(id aResponseObject, NSError *anError) {
                if ([aResponseObject boolValue]) {
                    [self performSegueWithIdentifier:@"toGame" sender:self];
                }
                else {
                    [[OTSAlertView alertWithMessage:@"无法开启游戏" andCompleteBlock:nil] show];
                }
                
                [self hideLoading];
            }];
        }
        else {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AlertVC *vc = [sb instantiateViewControllerWithIdentifier:@"AlertVC"];
            vc.noHP = YES;
            self.alertVC = vc;
        
            vc.view.alpha = 0.f;
            [self.view addSubview:vc.view];
            [UIView animateWithDuration:.5f animations:^{
                vc.view.alpha = 1.f;
            }];
            [self hideLoading];
        }
    }];
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)sender
{
    if ([sender.identifier isEqualToString:@"gameBack"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RewardVC *vc = [sb instantiateViewControllerWithIdentifier:@"RewardVC"];
        self.rewardVC = vc;
        self.rewardVC.roleDict = self.roleDict;
    
        vc.view.alpha = 0.f;
        [self.view addSubview:vc.view];
        [UIView animateWithDuration:.5f animations:^{
            vc.view.alpha = 1.f;
        }];
    }
    
    [self updateViews];
}

- (void)updateViews
{
    [self.physicalBtn setTitle:[self.roleDict[@"userExtra"][@"tueCurPhysical"] stringValue] forState:UIControlStateNormal];
    [self.attackBtn setTitle:[self.roleDict[@"userExtra"][@"tueAttack"] stringValue] forState:UIControlStateNormal];
    [self.magicBtn setTitle:[self.roleDict[@"userExtra"][@"tueCurMagic"] stringValue] forState:UIControlStateNormal];
    self.messageLbl.text = [self.roleDict[@"userExtra"][@"tueChest"] stringValue];
    
    [self configImage];
}

- (void)configImage
{
    NSString *roleType = self.roleDict[@"userExtra"][@"constellation"][@"conType"];
    NSString *roleImage = self.roleDict[@"userExtra"][@"conImgPrefix"];
    roleImage = [[roleImage componentsSeparatedByString:@"/"] lastObject];
    
    self.roleImage.image = [UIImage imageNamed:roleImage];
    self.smallIcon.image = [UIImage imageNamed:roleType];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"toIdea" isEqualToString:segue.identifier]) {
        IdeaVC *vc = segue.destinationViewController;
        vc.roleDict = self.roleDict;
    }
    
    if ([segue.destinationViewController isKindOfClass:[Persion1VC class]]) {
        Persion1VC *vc = segue.destinationViewController;
        vc.roleDict = self.roleDict.mutableCopy;
    }
    
    if ([segue.destinationViewController isKindOfClass:[Persion2VC class]]) {
        Persion2VC *vc = segue.destinationViewController;
        vc.roleDict = self.roleDict.mutableCopy;
    }
    
    if ([segue.destinationViewController isKindOfClass:[Persion3VC class]]) {
        Persion3VC *vc = segue.destinationViewController;
        vc.roleDict = self.roleDict.mutableCopy;
    }
    
    if ([segue.destinationViewController isKindOfClass:[ProfileVC class]]) {
        ProfileVC *vc = segue.destinationViewController;
        vc.roleDict = self.roleDict.mutableCopy;
    }
    
    if ([@"toMessageDetail" isEqualToString:segue.identifier]) {
        MessageDetailVC *vc = segue.destinationViewController;
        vc.infos = self.roleDict[@"jobRecommend"][@"employment"];
    }
}



@end
