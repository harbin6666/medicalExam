//
//  StartVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "StartVC.h"

#import "LoginPickDateBtn.h"
#import "HomeVC.h"

@interface StartVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet LoginPickDateBtn *dateBtn;
@property (weak, nonatomic) IBOutlet UILabel *warningLbl;

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPressedBtn:(UIButton *)sender
{
    [sender becomeFirstResponder];
}

- (IBAction)onPressedTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onPressedNext:(id)sender
{
    if (!self.dateBtn.selectedDate) {
        self.warningLbl.text = @"请选择生日";
        self.warningLbl.hidden = NO;
        return;
    }
    
    //去除登录
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Cookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"user.sex"] = @(self.segment.selectedSegmentIndex + 1);
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyy-MM-dd";
    params[@"user.birthday"] = [formatter stringFromDate:self.dateBtn.selectedDate];
    
    [self showLoading];
    WEAK_SELF;
    [self getValueWithLYKUrl:@"/userJ!createRole" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
        STRONG_SELF;
        if (!anError) {
            NSString *errorMsg = aResponseObject[@"errorMsg"];
            if (errorMsg) {
                [[OTSAlertView alertWithMessage:errorMsg andCompleteBlock:nil] show];
            }
            else {
                [self performSegueWithIdentifier:@"toNext" sender:aResponseObject];
            }
        }
        [self hideLoading];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toNext"]) {
        HomeVC *vc = segue.destinationViewController;
        vc.roleDict = sender;
    }
}


@end
