//
//  PSSTopicCell.h
//  项目 - 百思不得姐
//
//  Created by ma c on 16/4/3.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSSTopic;

@interface PSSTopicCell : UITableViewCell

/** 帖子数据 */
@property (nonatomic, strong) PSSTopic *topic;

@end
