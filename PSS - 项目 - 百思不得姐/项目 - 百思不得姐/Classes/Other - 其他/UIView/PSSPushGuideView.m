//
//  PSSPushGuideView.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/30.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSPushGuideView.h"

@implementation PSSPushGuideView
- (IBAction)close {
    
    [self removeFromSuperview];
    
    
}

+ (void)show {
    
    //当我们第一次打开这个版本
    
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件版本号
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //获得沙盒中存储的版本号
    
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        PSSPushGuideView *guideView = [PSSPushGuideView guideView];
        
        guideView.frame = window.frame;
        [window addSubview:guideView];
        
        //获取版本号
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        //马上存储版本号
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

+ (instancetype)guideView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    
}



@end
