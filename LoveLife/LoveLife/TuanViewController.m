//
//  TuanViewController.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "TuanViewController.h"
#import "CityViewController.h"

@interface TuanViewController ()

@end

@implementation TuanViewController

@synthesize tableView   = _tableView;
@synthesize scrollView  = _scrollView;
@synthesize pageControl = _pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置显示最左边的当前城市
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"南京"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(showCitys)];
    
    //初始化scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 150)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 150);
    _scrollView.delegate = self;
    
    //在UIScrollView 上加入 UIImageView
    for (int i = 0 ; i < 2; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i , 0, self.view.bounds.size.width, 150)];
        //将要加载的图片放入imageView 中
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    }
    
    //初始化pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,64 + _scrollView.bounds.size.height,self.view.frame.size.width,20)];
    _pageControl.backgroundColor = [UIColor grayColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 2;
    _pageControl.userInteractionEnabled = YES;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];
}

//点击进行切换
-(void)changePage:(UIPageControl *)sender
{
    int page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * page, 0)];
}


#pragma mark-
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.bounds.size.width;
    // 在滚动超过页面宽度的50%的时候，切换到新的页面
    int page = floor((_scrollView.contentOffset.x + pageWidth/2)/pageWidth) ;
    _pageControl.currentPage = page;
}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


//显示城市列表
-(void)showCitys
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
