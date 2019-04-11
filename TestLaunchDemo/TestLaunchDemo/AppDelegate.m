//
//  AppDelegate.m
//  TestLaunchDemo
//
//  Created by Brook on 2019/4/11.
//  Copyright © 2019 br. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@end


@interface VerySimpleWebViewController : UIViewController <WKNavigationDelegate>

@property (nonatomic, copy) NSString *urlString;

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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSTimeInterval delayFoAsyncDisplay = 0.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayFoAsyncDisplay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showLaunch];
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self showLaunch];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)showLaunch {
    UIStoryboard *launch = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    UIViewController *vc = [launch instantiateInitialViewController];
    vc.view.frame = UIScreen.mainScreen.bounds;
    [self.window addSubview:vc.view];
    
    NSTimeInterval delayIntervalForShowingLaunch = 3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayIntervalForShowingLaunch * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            vc.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [vc.view removeFromSuperview];
            // main.storyboard 已配置为导航控制器，可以跳转
            UINavigationController *navi = (UINavigationController *)self.window.rootViewController;
            VerySimpleWebViewController *webVC = [[VerySimpleWebViewController alloc] init];
            webVC.urlString = @"https://www.qq.com";
            BOOL needAnimationWhenPush = NO;
            [navi pushViewController:webVC animated:needAnimationWhenPush];
        }];
    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
