//
//  ViewController.m
//  TestLaunchDemo
//
//  Created by Brook on 2019/4/11.
//  Copyright © 2019 br. All rights reserved.
//

#import "TLHomeViewController.h"

@interface TLHomeViewController ()

@end

@implementation TLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"home";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self screenShot];
}

#pragma mark - private
// 实现截图保存功能，并在分享前截图
- (void)screenShot
{
    // 背景图片 总的大小
    CGSize size = self.view.frame.size;
    self.navigationController.navigationBarHidden = YES;
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageview.image = [UIImage imageNamed:@"launch_image"];
    [self.view addSubview:imageview];
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    // 要裁剪的矩形范围
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 添加截取好的图片到图片数组
    if (snapshot){
        NSLog(@"%@", snapshot);
    }
    // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
    UIGraphicsEndImageContext();
    
    [imageview removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}

@end
