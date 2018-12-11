//
//  TDUIWebViewController.m
//  HybridDemo
//
//  Created by liweiqiang on 2018/12/11.
//

#import "TDUIWebViewController.h"
#import "TalkingDataHTML.h"
#import "TalkingData.h"

@interface TDUIWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TDUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://talkingdata.github.io/HybridAssets/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebview Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([TalkingDataHTML execute:request.URL webView:webView]) {
        return NO;
    } else {
        [TalkingData trackPageBegin:request.URL.absoluteString];
        return YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"setWebViewFlag()"];
}

@end
