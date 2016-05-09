//
//  PSSCustomRightCell.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/27.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSCustomRightCell.h"
#import "PSSRightTabelViewModel.h"
#import "UIImageView+WebCache.h"

@interface PSSCustomRightCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;



@end

@implementation PSSCustomRightCell


- (void)setDataList:(PSSRightTabelViewModel *)dataList {
    _dataList = dataList;
    
    PSSRightTabelViewModel *model = dataList;
    
    self.userName.text = model.screen_name;
    
    self.fansCount.text = [NSString stringWithFormat:@"%zd个人关注了他",model.fans_count];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",model.header];
    
//    self.imageView.size = CGSizeMake(0, 0);
    
//    NSLog(@"%@",NSStringFromCGSize(self.imageView.size));
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
//    NSLog(@"%@", NSStringFromCGSize(self.imageView.image.size));
    
    
}

- (void)awakeFromNib {
    // Initialization code

//    self.imageView.size = CGSizeMake(50, 50);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
