//   
//   VerySimpleWebViewController.m
//   TestLaunchDemo
//   
//   Created  by Brook on 2019/4/11
//   Modified by Brook
//   Copyright © 2019 br. All rights reserved.
//   
   

#import "VerySimpleWebViewController.h"
#import <WebKit/WebKit.h>

@interface VerySimpleWebViewController() <WKNavigationDelegate>

@end

@implementation VerySimpleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载中";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; // 与视图等宽高
    webView.navigationDelegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

// webview 的回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = webView.title;
    NSLog(@"didFinishNavigation == %@",webView.URL.absoluteString);
}


@end
