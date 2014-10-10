//
//  CityViewController.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController

@synthesize searchBar     = _searchBar;
@synthesize searchDisplay = _searchDisplay;
@synthesize sourceData    = _sourceData;
@synthesize resultData    = _resultData;
@synthesize isSearch      = _isSearch;
@synthesize tableView     = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"当前城市--南京";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNav];
    [self initDataSource];
    [self initTableView];
    [self initSearchBar];
}

//初始化导航
-(void)initNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"deatil_left_arrow"]
                                             style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(backToTuanGou)];
}

//初始化数据源
-(void)initDataSource
{
    _sourceData = [NSMutableArray array];
    _resultData = [NSMutableArray array];
}

//初始化table
-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = [[UIView alloc] init];
    
    if (IS_IOS_7)
    {
        //分割线的位置不带偏移
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    [self.view addSubview:_tableView];
}

//初始化搜索栏
-(void)initSearchBar
{
    //搜索栏
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    _searchBar.placeholder = @"请输入要搜索的城市...";
    _searchBar.delegate = self;
    [_searchBar sizeToFit];
    
    [_tableView.tableHeaderView addSubview:_searchBar];
    
    _searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplay.delegate = self;
    _searchDisplay.searchResultsDelegate = self;
    _searchDisplay.searchResultsDataSource = self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger rowNo = indexPath.row;
    
    //正在搜索
    if (_isSearch)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"在搜索%d",rowNo];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"你好%d",rowNo];
    }
    return cell;
}


#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [_searchBar setShowsCancelButton:YES];
    for (UIView *v in _searchBar.subviews)
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            [(UIButton *)v setTitle:@"返回" forState:UIControlStateNormal];
        }
    }
}

#pragma mark -
#pragma mark Other Methods

-(void)backToTuanGou
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
