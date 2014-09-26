//
//  TuanViewController.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "TuanViewController.h"
#import "CityViewController.h"
#import "PowerPointTableViewCell.h"

@interface TuanViewController ()

@end

@implementation TuanViewController

@synthesize tableView               = _tableView;
@synthesize scrollView              = _scrollView;
@synthesize pageControl             = _pageControl;
@synthesize reloading               = _reloading;
@synthesize refreshTableHeaderView  = _refreshTableHeaderView;
@synthesize shopData                = _shopData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor purpleColor];
        _shopData = [NSMutableArray array];
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
    
//    //初始化scrollView
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 150)];
//    _scrollView.pagingEnabled = YES;
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.bounces = YES;
//    _scrollView.backgroundColor = [UIColor whiteColor];
//    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 150);
//    _scrollView.delegate = self;
//    
//    //在UIScrollView 上加入 UIImageView
//    for (int i = 0 ; i < 2; i++)
//    {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i , 0, self.view.bounds.size.width, 150)];
//        //将要加载的图片放入imageView 中
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
//        imageView.image = image;
//        [_scrollView addSubview:imageView];
//    }
//    
//    //初始化pageControl
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,64 + _scrollView.bounds.size.height,self.view.frame.size.width,20)];
//    _pageControl.backgroundColor = [UIColor grayColor];
//    _pageControl.currentPage = 0;
//    _pageControl.numberOfPages = 2;
//    _pageControl.userInteractionEnabled = YES;
//    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:_scrollView];
//    [self.view addSubview:_pageControl];
    
    [self getCacheData];
    [self showTuanList];
    [self requestTuanGouData];
}

//显示团购列表
-(void)showTuanList
{
    if(SYSTEM_VERSION >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //创建tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsZero;//设置cell的分割线不偏移
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    //刷新控件
    if (_refreshTableHeaderView == nil)
    {
        _refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 64.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        _refreshTableHeaderView.delegate = self;
        [_tableView addSubview:_refreshTableHeaderView];
    }
    //最后一次更新的时间
    [_refreshTableHeaderView refreshLastUpdatedDate];
    
}

//获取列表缓存数据
-(void)getCacheData
{
    NSString *getShopsUrl = [NSString stringWithFormat:@"%@%@?app_key=%@&city=%@&q=%@&alt=json",kApiHost,kSearchShops,kAppKey,kCurrentCity,kSearchQ];
    NSArray *data = [[DataManage shareDataManage] getData:CACHE_NAME withNetworkApi:[getShopsUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (data)
    {
        [_shopData addObjectsFromArray:data];
    }
}

//请求团购列表数据
-(void)requestTuanGouData
{
    [ProgressHUD show:@"正在加载..."];
    NSString *getShopsUrl = [NSString stringWithFormat:@"%@%@?app_key=%@&city=%@&q=%@&alt=json",kApiHost,kSearchShops,kAppKey,kCurrentCity,kSearchQ];
    getShopsUrl = [getShopsUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request_ = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getShopsUrl]];
    __weak ASIHTTPRequest *request = request_;
    [request setCompletionBlock:^{
        [ProgressHUD dismiss];
        if ([request responseStatusCode] != 200)
        {
            return;
        }
        
        if (isNilNull([request responseData]))
        {
            return;
        }
        
        NSData *data = [request responseData];
        NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *shopArr = [[allData objectForKey:@"bizs"] objectForKey:@"biz"];
        if ([shopArr count] <= 0)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProgressHUD showError:@"没有数据"];
            });
        }
        
        //保存数据
        [[DataManage shareDataManage] insertData:CACHE_NAME withNetworkApi:getShopsUrl withObject:shopArr];
        [_shopData removeAllObjects];
        [_shopData addObjectsFromArray:shopArr];
        [_tableView reloadData];
        
    }];
    [request setFailedBlock:^{
        [ProgressHUD showError:@"网络连接错误"];
    }];
    [request startAsynchronous];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shopData count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowNo = indexPath.row;
    if (rowNo == 0)
    {
        static NSString *cellId = @"PowerPoint";
        PowerPointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil)
        {
            cell = [[PowerPointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }
    else
    {
        static NSString *cellId = @"cellId";
        TuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil)
        {
            cell = [[TuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [cell.indexPicView sd_setImageWithURL:[NSURL URLWithString:[[_shopData objectAtIndex:rowNo - 1] objectForKey:@"img_url"]]
                             placeholderImage:[UIImage imageNamed:@"1.png"]];
        cell.shopName.text = [[_shopData objectAtIndex:rowNo - 1] objectForKey:@"name"];//店名
        cell.address.text  = [[_shopData objectAtIndex:rowNo - 1] objectForKey:@"addr"];//地址
        cell.tel.text      = [[_shopData objectAtIndex:rowNo - 1] objectForKey:@"tel"];//电话
        cell.price.text    = [NSString stringWithFormat:@"￥%@",[[_shopData objectAtIndex:rowNo - 1] objectForKey:@"cost"]];//价格
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.hidesBottomBarWhenPushed = YES;
//    MenuViewController *menuVC = [[MenuViewController alloc] init];
//    menuVC.shopId = [[_shopData objectAtIndex:[indexPath row]] objectForKey:@"id"];
//    [self.navigationController pushViewController:menuVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 200.0f;
    }
    else
    {
        return 100.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date];
}


#pragma mark -
#pragma mark Refresh Methods

//刷新的两个方法
- (void)reloadTableViewDataSource
{
    [NSThread detachNewThreadSelector:@selector(requestTuanGouData) toTarget:self withObject:nil]; //异步加载数据，不影tableView动作
    _reloading = YES;
}

//数据加载完成
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading;
}

#pragma mark-
#pragma mark Some Methods

//显示城市列表
-(void)showCitys
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:YES completion:nil];
}

//点击进行切换
-(void)changePage:(UIPageControl *)sender
{
    int page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * page, 0) animated:YES];
}


#pragma mark-
#pragma mark UIScrollViewDelegate

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = _scrollView.bounds.size.width;
//    // 在滚动超过页面宽度的50%的时候，切换到新的页面
//    int page = floor(_scrollView.contentOffset.x / pageWidth);
//    _pageControl.currentPage = page;
//}
//
//
//-(void) scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
