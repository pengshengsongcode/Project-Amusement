//
//  PSStabBarController.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/24.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSStabBarController.h"
#import "PSSessenceViewController.h"
#import "PSSFriendTrendsViewController.h"
#import "PSSMeViewController.h"
#import "PSSNewViewController.h"
#import "PSSTabbar.h"
#import "PSSNavigationController.h"

@interface PSStabBarController ()

@end

@implementation PSStabBarController

+ (void)initialize {
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    
    NSDictionary *nomalDict = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:12],
                                NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                };
    
    NSDictionary *seletedDict = @{
                                  NSFontAttributeName:nomalDict[NSFontAttributeName],
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                  };
    
    UITabBarItem *item  =[UITabBarItem appearance];
    
    [item setTitleTextAttributes:nomalDict forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:seletedDict forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewController:[[PSSEssenceViewController alloc] init] title:@"精华" nomalImageName:@"tabBar_essence_icon" seletedImageName:@"tabBar_essence_click_icon"];
    
    [self setupViewController:[[PSSNewViewController alloc] init] title:@"新帖" nomalImageName:@"tabBar_new_icon" seletedImageName:@"tabBar_new_click_icon"];
    
    [self setupViewController:[[PSSFriendTrendsViewController alloc] init] title:@"关注" nomalImageName:@"tabBar_friendTrends_icon" seletedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self setupViewController:[[PSSMeViewController alloc] init] title:@"我" nomalImageName:@"tabBar_me_icon" seletedImageName:@"tabBar_me_click_icon"];
    
    [self setValue:[[PSSTabbar alloc] init] forKeyPath:@"tabBar"];
    //self.tabBar = [PSSTabbar alloc] init] KVC 磊神教学
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"磊神无敌");
}

- (void)setupViewController:(UIViewController *)VC title:(NSString *)title nomalImageName:(NSString *)nomalImage seletedImageName:(NSString *)selectedImage {
    
    // 设置文字和图片
    VC.navigationItem.title = title;
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:nomalImage];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    PSSNavigationController *nav = [[PSSNavigationController alloc] initWithRootViewController:VC];

    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
