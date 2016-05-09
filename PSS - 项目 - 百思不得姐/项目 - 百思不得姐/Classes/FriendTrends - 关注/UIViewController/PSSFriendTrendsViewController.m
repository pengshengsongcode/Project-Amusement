//
//  PSSFriendTrendsViewController.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/24.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSFriendTrendsViewController.h"
#import "PSSDoubleTableViewController.h"
#import "PSSLoginRegisterViewController.h"

@interface PSSFriendTrendsViewController ()

@end

@implementation PSSFriendTrendsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航栏标题
    
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = PSSGlobalBg;
}

- (void)friendsClick
{
//    PSSLogFunc;
    
    PSSDoubleTableViewController *vc = [[PSSDoubleTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)loginRegister {
    PSSLoginRegisterViewController *login = [[PSSLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
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
