//
//  PSSLeftTabelViewModel.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/26.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSLeftTabelViewModel.h"

@implementation PSSLeftTabelViewModel

- (NSMutableArray *)users {
    
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
