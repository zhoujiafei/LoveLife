//
//  SeeAllTuanTableViewCell.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-28.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "SeeAllTuanTableViewCell.h"

@implementation SeeAllTuanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
