//
//  TuanTableViewCell.m
//  LoveLife
//
//  Created by 刘 金兰 on 14-9-25.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "TuanTableViewCell.h"

@implementation TuanTableViewCell

@synthesize indexPicView = _indexPicView;
@synthesize shopName     = _shopName;
@synthesize address      = _address;
@synthesize tel          = _tel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //店招
        _indexPicView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130,80)];
        _indexPicView.backgroundColor = [UIColor redColor];
        
        //店名
        _shopName = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 160, 25)];
        _shopName.font = [UIFont systemFontOfSize:16];
        
        //地址
        UILabel *addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 35, 40, 20)];
        addrLabel.font = [UIFont systemFontOfSize:12];
        addrLabel.text = @"地址：";
        
        _address = [[UILabel alloc] initWithFrame:CGRectMake(190, 35, 120, 20)];
        _address.font = [UIFont systemFontOfSize:12];
        
        //电话
        UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 55, 40, 20)];
        telLabel.font = [UIFont systemFontOfSize:12];
        telLabel.text = @"电话：";
        
        _tel = [[UILabel alloc] initWithFrame:CGRectMake(190, 55, 120, 20)];
        _tel.font = [UIFont systemFontOfSize:12];
        
        //价格
        _price = [[UILabel alloc] initWithFrame:CGRectMake(150, 75, 50, 20)];
        _price.font = [UIFont boldSystemFontOfSize:14];
        _price.textColor = [UIColor orangeColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100.0-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        
        [self addSubview:line];
        [self addSubview:_indexPicView];
        [self addSubview:_shopName];
        [self addSubview:addrLabel];
        [self addSubview:_address];
        [self addSubview:telLabel];
        [self addSubview:_tel];
        [self addSubview:_price];
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
