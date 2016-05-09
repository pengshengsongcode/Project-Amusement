//
//  PSSCustomLeftCell.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/26.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSCustomLeftCell.h"
#import "PSSLeftTabelViewModel.h"

@interface PSSCustomLeftCell ()

@property (weak, nonatomic) IBOutlet UIView *redView;


@end


@implementation PSSCustomLeftCell

- (void)setDataList:(PSSLeftTabelViewModel *)dataList {
    
    _dataList = dataList;
    
    self.textLabel.text = dataList.name;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.textLabel.textColor = selected ? self.redView.backgroundColor : [UIColor darkGrayColor];
    
    
    self.redView.hidden = !selected;
    
    // Configure the view for the selected state
}

@end
