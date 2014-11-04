//
//  AccountHeaderTableViewCell.m
//  LoveLife
//
//  Created by 周 加飞 on 14-10-21.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "AccountHeaderTableViewCell.h"

@implementation AccountHeaderTableViewCell

@synthesize couponBtn  = _couponBtn;
@synthesize collectBtn = _collectBtn;
@synthesize historyBtn = _historyBtn;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //背景
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140)];
        bgImageView.image = [UIImage imageNamed:@"bg_account_head_new"];
        
        //优惠券按钮
        _couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _couponBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _couponBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _couponBtn.backgroundColor = [UIColor greenColor];
        _couponBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_couponBtn setTitle:@"优惠券(0)" forState:UIControlStateNormal];
        [_couponBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _couponBtn.frame = CGRectMake(0, 140, self.frame.size.width/3, 80);
        [_couponBtn setImage:[UIImage imageNamed:@"user_icon_lashouquan"] forState:UIControlStateNormal];
        [_couponBtn setImageEdgeInsets:UIEdgeInsetsMake(10,35,30,35)];
        [_couponBtn setTitleEdgeInsets:UIEdgeInsetsMake(55, -10, 5, 10)];
        
        
        //收藏按钮
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _collectBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _collectBtn.backgroundColor = [UIColor purpleColor];
        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_collectBtn setTitle:@"收藏(0)" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _collectBtn.frame = CGRectMake(self.frame.size.width/3, 140, self.frame.size.width/3, 80);
        [_collectBtn setImage:[UIImage imageNamed:@"user_icon_favortite"] forState:UIControlStateNormal];
        [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(10,35,30,35)];
        [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(55, -5, 5, 10)];
        
        //最近浏览
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _historyBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _historyBtn.backgroundColor = [UIColor redColor];
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_historyBtn setTitle:@"最近浏览(0)" forState:UIControlStateNormal];
        [_historyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _historyBtn.frame = CGRectMake(self.frame.size.width/3 * 2, 140, self.frame.size.width/3, 80);
        [_historyBtn setImage:[UIImage imageNamed:@"user_icon_history"] forState:UIControlStateNormal];
        [_historyBtn setImageEdgeInsets:UIEdgeInsetsMake(10,35,30,35)];
        [_historyBtn setTitleEdgeInsets:UIEdgeInsetsMake(55, -18, 5, 10)];
        
        
        [self addSubview:bgImageView];
        [self addSubview:_couponBtn];
        [self addSubview:_collectBtn];
        [self addSubview:_historyBtn];
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
