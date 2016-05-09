//
//  PSSessenceViewController.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/24.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSEssenceViewController.h"
#import "PSSRecommendTagsViewController.h"
#import "PSSTopicViewController.h"

#define kCount 5

@interface PSSEssenceViewController ()<UIScrollViewDelegate>

/** 顶部的所有标签 */

@property (nonatomic, strong) UIView *titlesView;

/** 标签栏底部的红色指示器 */

@property (nonatomic, strong) UIView *indicatorView;

/** 当前选中的按钮 */

@property (nonatomic, strong) UIButton *selectedButton;

/** 底部的所有内容*/

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation PSSEssenceViewController

- (UIView *)titlesView {
    
    if (!_titlesView) {
        _titlesView = [[UIView alloc] init];
        _titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _titlesView.width = self.view.width;
        _titlesView.height = PSSTitilesViewH;
        _titlesView.y = PSSTitilesViewY;
        
    }
    return _titlesView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏
    
    [self setupNav];
    
    //初始化子控制器
    
    [self setupChildVces];
    
    //设置顶部标签栏
    
    [self setupTitlesView];
    
    //底部的scrollView
    
    [self setupCustomScrollView];
    
}

- (void)setupChildVces {

    
    PSSTopicViewController *all = [[PSSTopicViewController alloc] init];
    all.title = @"全部";
    all.type = PSSTopicTypeAll;
    [self addChildViewController:all];

    PSSTopicViewController *video = [[PSSTopicViewController alloc] init];
    video.title = @"视频";
    video.type = PSSTopicTypeVideo;
    [self addChildViewController:video];
    
    PSSTopicViewController *voice = [[PSSTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = PSSTopicTypeVoice;
    [self addChildViewController:voice];
    
    PSSTopicViewController *picture = [[PSSTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = PSSTopicTypePicture;
    [self addChildViewController:picture];
    
    PSSTopicViewController *word = [[PSSTopicViewController alloc] init];
    word.title = @"段子";
    word.type = PSSTopicTypeWord;
    [self addChildViewController:word];

    
}

/**
 *  设置底部的scrollView
 */

- (void)setupCustomScrollView {
    
    //禁止系统自动调整insets
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    
    contentView.delegate = self;
    
    contentView.pagingEnabled = YES;
    
    contentView.frame = self.view.bounds;
    
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    
    //添加第一个控制器
    
    [self scrollViewDidEndScrollingAnimation:contentView];

}

- (void)setupNav {
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = PSSGlobalBg;
    
}

/**
 *  设置顶部标签栏
 */

- (void)setupTitlesView {
    
    [self.view addSubview:self.titlesView];
    
    //底部的红色指示器
    
    UIView *indicatorView = [[UIView alloc] init];
    
    indicatorView.backgroundColor = [UIColor redColor];
    
    indicatorView.height = 2;
    
    indicatorView.y = self.titlesView.height - indicatorView.height;
    
    indicatorView.tag =  -1;
    
    self.indicatorView = indicatorView;
    
    
    //内部的子标签
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    for (NSInteger i = 0; i < kCount; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        
        button.height = self.titlesView.height;
        
        button.width = self.titlesView.width / kCount;
        
        button.x = i * button.width;
        
        button.tag = i ;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        //强制布局,轻质更新子控件的frame
        
//        [button layoutIfNeeded];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            self.selectedButton = button;
            
            self.selectedButton.enabled = NO;
            
            //让按钮内部的label根据文字内容来计算尺寸
            
            [button.titleLabel sizeToFit];
            
            self.indicatorView.width = button.titleLabel.width;
            
            self.indicatorView.centerX = button.centerX;
            
        }
        
        [self.titlesView addSubview:button];
        
    }
    [self.titlesView addSubview:indicatorView];

    
}

- (void)titleClick:(UIButton *)button {

//    PSSLog(@"%@",button);
    
    
    //修改按钮状态,按钮只选中一次
    
    self.selectedButton.enabled =  YES;
    
    button.enabled = NO;
    
    self.selectedButton = button;
    
    //使用动画更改底部的红色指示器的位置
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = button.titleLabel.width;
        
        self.indicatorView.centerX = button.centerX;
        
    }];
    
    //滚动
    
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = button.tag * self.contentView.width;
    
    [self.contentView setContentOffset:offset animated:YES];
    
//    NSLog(@"%s",__func__);
    
}

- (void)tagClick
{
    PSSRecommendTagsViewController *tags = [[PSSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x;
    
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.titlesView.subviews[index]];
    
}


@end
