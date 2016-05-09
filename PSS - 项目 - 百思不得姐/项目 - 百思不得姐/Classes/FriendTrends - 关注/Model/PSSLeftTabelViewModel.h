//
//  PSSLeftTabelViewModel.h
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/26.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSSLeftTabelViewModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个模型对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

/** 总数 */
@property (nonatomic, assign) NSInteger total;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end
