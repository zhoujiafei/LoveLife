//
//  AccountHeaderTableViewCell.m
//  LoveLife
//
//  Created by 周 加飞 on 14-10-21.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "AccountHeaderTableViewCell.h"

@implementation AccountHeaderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140)];
        bgImageView.image = [UIImage imageNamed:@"bg_account_head_new"];
        [self addSubview:bgImageView];
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
