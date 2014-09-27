//
//  PowerPointTableViewCell.m
//  LoveLife
//
//  Created by 刘 金兰 on 14-9-26.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "PowerPointTableViewCell.h"

@implementation PowerPointTableViewCell

@synthesize scrollView  = _scrollView;
@synthesize pageControl = _pageControl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
        
        
        //初始化scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 2, 150);
        _scrollView.delegate = self;
        
        //在UIScrollView 上加入 UIImageView
        for (int i = 0 ; i < 2; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i , 0, self.bounds.size.width, 150)];
            //将要加载的图片放入imageView 中
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            imageView.image = image;
            [_scrollView addSubview:imageView];
        }
        
        //初始化pageControl
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
        _pageControl.backgroundColor = [UIColor grayColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.userInteractionEnabled = YES;
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
    }
    return self;
}

//点击进行切换
-(void)changePage:(UIPageControl *)sender
{
    NSInteger page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width * page, 0) animated:YES];
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
