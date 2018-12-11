//
//  TDWKWebViewController.m
//  HybridDemo
//
//  Created by liweiqiang on 2018/12/11.
//

#import "TDWKWebViewController.h"
#import "TalkingDataHTML.h"
#import "TalkingData.h"
#import <WebKit/WebKit.h>

@interface TDWKWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation TDWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:@"https://talkingdata.github.io/HybridAssets/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewWillLayoutSubviews {
    self.webView.frame = self.view.bounds;
}

#pragma mark - WKWebview Delegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([TalkingDataHTML execute:navigationAction.request.URL webView:webView]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        [TalkingData trackPageBegin:navigationAction.request.URL.absoluteString];
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"setWebViewFlag()" completionHandler:nil];
}

@end
