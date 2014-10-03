//
//  HeaderTableViewCell.m
//  LoveLife
//
//  Created by 刘 金兰 on 14-10-3.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

@synthesize scrollView      = _scrollView;
@synthesize pageControl     = _pageControl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(50,50);
        UIEdgeInsets top = {20,30,20,30};
        flowLayout.sectionInset = top;
        
        UICollectionView *firstView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150) collectionViewLayout:flowLayout];
        firstView.backgroundColor = [UIColor whiteColor];
        //注册
        [firstView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"firstCellId"];
        firstView.tag = 10001;
        firstView.delegate   = self;
        firstView.dataSource = self;
        
        UICollectionView *secondView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, 150) collectionViewLayout:flowLayout];
        secondView.backgroundColor = [UIColor whiteColor];
        //注册
        [secondView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"secondCellId"];
        secondView.tag = 10002;
        secondView.delegate   = self;
        secondView.dataSource = self;
        
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

#pragma mark-
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.bounds.size.width;
    // 在滚动超过页面宽度的50%的时候，切换到新的页面
    int page = floor(_scrollView.contentOffset.x / pageWidth);
    _pageControl.currentPage = page;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = nil;
    NSInteger index = 0;
    if (collectionView.tag == 10001)
    {
        identify = @"firstCellId";
        index = 1;
    }
    else
    {
        identify = @"secondCellId";
        index = 8;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld.png",(indexPath.row + index)]]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
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
