//
//  LQBannerCell.m
//  LQBannerScroll
//
//  Created by zhengliqiang on 2017/11/6.
//  Copyright © 2017年 zhengliqiang. All rights reserved.
//

#import "LQBannerCell.h"

@implementation LQBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bannerImage = [[UIImageView alloc]init];
        self.bannerImage.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.bannerImage];
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.bannerImage.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
}
@end
