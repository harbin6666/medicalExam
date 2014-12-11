//
//  GameVC.m
//  LYKJob
//
//  Created by Aimy on 14/12/7.
//  Copyright (c) 2014年 Aimy. All rights reserved.
//

#import "GameVC.h"

#import "HomeVC.h"

@interface GameVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:baseURL];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"user!getResult?score="];
    if (range.location != NSNotFound) {
        NSString *score = [url substringWithRange:NSMakeRange(range.location + range.length, url.length - range.location - range.length)];
        [self showLoading];
        [self getValueWithLYKUrl:@"/userJ!getResult" params:@{@"score":score} CompleteBlock:^(id aResponseObject, NSError *anError) {
            [self performSegueWithIdentifier:@"gameBack" sender:aResponseObject];
            [self hideLoading];
        }];
        return NO;
    }
    
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeVC *vc = segue.destinationViewController;
    vc.roleDict = sender;
}


@end
