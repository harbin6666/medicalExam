//
//  IdeaVC.m
//  LYKJob
//
//  Created by Aimy on 14/11/22.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "IdeaVC.h"

#import "IdeaTopVC.h"

@interface IdeaVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) NSString *htmlString;

@property (strong, nonatomic) IBOutlet UIButton *showMoreBtn;

@property (nonatomic, strong) IdeaTopVC *vc;

@end

@implementation IdeaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    IdeaTopVC *vc = [sb instantiateViewControllerWithIdentifier:@"IdeaTop"];
    self.vc = vc;
    self.vc.roleDict = self.roleDict;
    
    self.vc.view.frame = CGRectMake(0, -200, self.vc.view.frame.size.width, self.vc.view.frame.size.height);
    
    [self.webView.scrollView addSubview:self.vc.view];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 142, 0);
    
    // Do any additional setup after loading the view.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"lyk" ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    __block NSUInteger index = 0;
    
    if (self.roleDict[@"userExtra"][@"constellation"][@"conType"]) {
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *infos = obj;
            if ([infos[@"conType"] isEqualToString:self.roleDict[@"userExtra"][@"constellation"][@"conType"]]) {
                index = idx;
                *stop = YES;
                return ;
            }
        }];
    }
    
    self.htmlString = data[index][@"condesc"];
    
    if (!self.roleDict[@"user"][@"userId"]) {
        self.backBtn.hidden = YES;
        self.bg.hidden = YES;
        self.showMoreBtn.hidden = NO;
    }
    else {
        self.htmlString = [self.htmlString stringByAppendingString:data[index][@"consuggestion"]];
    }
    
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
}

- (IBAction)onPressedTap:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)onPressedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.showMoreBtn.frame = CGRectMake((webView.bounds.size.width - self.showMoreBtn.bounds.size.width) / 2, webView.scrollView.contentSize.height, self.showMoreBtn.bounds.size.width, 30);
    [webView.scrollView addSubview:self.showMoreBtn];
}

@end
