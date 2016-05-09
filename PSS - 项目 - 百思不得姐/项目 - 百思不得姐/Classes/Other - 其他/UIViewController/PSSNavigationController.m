//
//  PSSNavigationController.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/26.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSNavigationController.h"

@interface PSSNavigationController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation PSSNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */

+ (void)initialize {
//  第一种设置方式
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
//   第二种设置方式
    
//   当导航栏用在PSSNavigationController中, appearance设置才会生效
    
    NSArray *arr = [NSArray arrayWithObjects:[self class], nil];
    
    [UINavigationBar appearanceWhenContainedInInstancesOfClasses:arr];
    
//   第三种设置方式
    
//    所有NavigationController有会生效
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (UIButton *)button {
#warning button 左对齐 和 自适应
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.size  = CGSizeMake(100, 30);
        [_button setTitle:@"返回" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        [_button sizeToFit];
    }
    return _button;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

//    先自定义左button，然后设置为item，如果有设置左item 则替换掉
    
#warning 设置返回按钮
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
    
//  不能修改点击颜色 半GG
    
//        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"放回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
//   不显示自定义View作为UIBarButtonItem 完全GG
    
//        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    
//  可以使用，但是需要判断，以防止将第一个界面设置为自定义button
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    
    viewController.navigationItem.leftBarButtonItem = backItem;

    viewController.hidesBottomBarWhenPushed = YES;
        
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
    
}

@end
