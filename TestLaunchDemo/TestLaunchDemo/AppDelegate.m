//
//  AppDelegate.m
//  TestLaunchDemo
//
//  Created by Brook on 2019/4/11.
//  Copyright © 2019 br. All rights reserved.
//

#import "AppDelegate.h"

#import "VerySimpleWebViewController.h"

@interface AppDelegate ()

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

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self showLaunch];
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

@end
