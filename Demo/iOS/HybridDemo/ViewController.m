//
//  ViewController.m
//  HybridDemo
//
//  Created by liweiqiang on 2018/3/19.
//  Copyright © 2018年 TendCloud. All rights reserved.
//

#import "ViewController.h"
#import "TalkingDataHTML.h"
#import "TalkingData.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"https://talkingdata.github.io/HybridAssets/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebview Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([TalkingDataHTML execute:request.URL webView:webView]) {
        return NO;
    }
    [TalkingData trackPageBegin:request.URL.absoluteString];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"setWebViewFlag()"];
}

@end
