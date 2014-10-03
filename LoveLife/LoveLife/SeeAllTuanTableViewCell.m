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
        //创建按钮
        UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        seeBtn.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
        seeBtn.backgroundColor = [UIColor whiteColor];
        [seeBtn setTitle:@"查看全部团购" forState:UIControlStateNormal];
        [seeBtn setTintColor:[UIColor grayColor]];
        [seeBtn addTarget:self action:@selector(seeAllTuanGou:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:seeBtn];
        
        //添加一条线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50.0-0.5, self.bounds.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        [self addSubview:line];
    }
    return self;
}

-(void)seeAllTuanGou:(id)sender
{
    NSLog(@"查看全部团购");
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
