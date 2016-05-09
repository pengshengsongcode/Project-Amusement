//
//  PSSTabbar.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/24.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSTabbar.h"

@interface PSSTabbar ()

@property (nonatomic, strong) UIButton *publishButton;

@property (nonatomic, assign) NSInteger index;

@end

@implementation PSSTabbar

- (UIButton *)publishButton {
    
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

    }
    return _publishButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.publishButton];
        


    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.imageView.image.size.width, self.publishButton.imageView.image.size.height);
//    NSLog(@"%@", NSStringFromCGRect(self.publishButton.bounds));
    
//    NSLog(@"%@",NSStringFromCGPoint(self.center));
    
    self.publishButton.center = self.center;
    
//    NSLog(@"%@",NSStringFromCGPoint(self.publishButton.center));
//    
//    NSLog(@"%@",NSStringFromCGRect(self.publishButton.frame) );
//    
//    NSLog(@"%@",NSStringFromCGPoint(self.publishButton.center));
    
    self.publishButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGFloat buttonY = 0;
    
    CGFloat buttonW = self.frame.size.width / 5.0;
    
    CGFloat buttonH = self.frame.size.height;
    
//    NSLog(@"%@", self.subviews);
    
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {

            continue;
        } else {

            CGFloat buttonX = buttonW * ((index > 1) ? index + 1: index) ;
            
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            index ++;
        }

    }

    
}
@end
