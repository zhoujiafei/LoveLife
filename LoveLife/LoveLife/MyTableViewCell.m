//
//  MyTableViewCell.m
//  LoveLife
//
//  Created by 周 加飞 on 14-10-22.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

@synthesize imageView = _imageView;
@synthesize cellTitle = _cellTitle;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
        
        _cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 7, 100, 30)];
        _cellTitle.font = [UIFont systemFontOfSize:16];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(290, 17, 10, 13.5)];
        rightArrow.image = [UIImage imageNamed:@"userInfo_arrow"];
        
        //cell头部的线
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        topLine.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];

        //cell底部的线
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44.0, self.frame.size.width, 0.5)];
        bottomLine.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];

        [self addSubview:_imageView];
        [self addSubview:rightArrow];
        [self addSubview:_cellTitle];
        [self addSubview:bottomLine];
        [self addSubview:topLine];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
