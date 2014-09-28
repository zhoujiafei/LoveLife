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
        //初始化scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 130)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 2, 130);
        _scrollView.delegate = self;
        
        //创建第一块view
        UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, 150)];
        int n = 1;
        for (int i = 1; i <= 2; i++)
        {
            for (int j = 1; j <= 4; j++)
            {
                UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                sortBtn.frame = CGRectMake((j - 1) * 80 + 20, (i - 1) * 60 + 20, 46, 46);
                [sortBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",n]] forState:UIControlStateNormal];
                [firstView addSubview:sortBtn];
                n++;
            }
        }
        
        UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width,0, self.bounds.size.width, 150)];
        for (int i = 1; i <= 2; i++)
        {
            for (int j = 1; j <= 4; j++)
            {
                UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                sortBtn.frame = CGRectMake((j - 1) * 80 + 20, (i - 1) * 60 + 20, 46, 46);
                [sortBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",n]] forState:UIControlStateNormal];
                [secondView addSubview:sortBtn];
                n++;
            }
        }
        
        [_scrollView addSubview:firstView];
        [_scrollView addSubview:secondView];
        
        //初始化pageControl
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
        _pageControl.backgroundColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.userInteractionEnabled = YES;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        //添加一条线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 150.0-0.5, self.bounds.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        [self addSubview:line];
        
    }
    return self;
}

//点击进行切换
-(void)changePage:(UIPageControl *)sender
{
    NSInteger page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width * page, 0) animated:YES];
}

#pragma mark-
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.bounds.size.width;
    // 在滚动超过页面宽度的50%的时候，切换到新的页面
    int page = floor(_scrollView.contentOffset.x / pageWidth);
    _pageControl.currentPage = page;
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
