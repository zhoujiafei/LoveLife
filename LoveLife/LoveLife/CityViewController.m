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
@synthesize searchData    = _searchData;
@synthesize indexData     = _indexData;
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
    _isSearch = NO;
    
    //读取城市数据
    NSString *cityDataPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableDictionary *cityData = [[NSMutableDictionary alloc] initWithContentsOfFile:cityDataPath];

    _sourceData = [NSMutableArray array];//用于列表显示的城市数据
    _resultData = [NSMutableArray array];//保存搜索结果数据
    _searchData = [NSMutableArray array];//用于搜索匹配的数据
    
    NSArray *sortIndexData = [[cityData allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    _indexData = [NSMutableArray arrayWithArray:sortIndexData];//构建索引数据

    for (NSInteger i = 0; i < [_indexData count]; i++)
    {
        [_sourceData addObject:[cityData objectForKey:[_indexData objectAtIndex:i]]];
    }
    
    //构建一维数组
    for (NSInteger i = 0; i < [_sourceData count]; i++)
    {
        for (NSInteger j = 0; j < [[_sourceData objectAtIndex:i] count]; j++)
        {
            [_searchData addObject:[[_sourceData objectAtIndex:i] objectAtIndex:j]];
        }
    }
}

//初始化table
-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
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
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 40)];
    _searchBar.placeholder = @"请输入要搜索的城市...";
    _searchBar.delegate = self;
    [_searchBar sizeToFit];
    
    _tableView.tableHeaderView = _searchBar;
    
    _searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplay.delegate = self;
    _searchDisplay.searchResultsDelegate = self;
    _searchDisplay.searchResultsDataSource = self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch)
    {
        return [_resultData count];
    }
    else
    {
        NSMutableArray *eachArr = [_sourceData objectAtIndex:section];
        return [eachArr count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearch)
    {
        return 1;
    }
    else
    {
        return [_sourceData count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_isSearch)
    {
        return nil;
    }
    else
    {
        return [NSString stringWithFormat:@"  %@",[_indexData objectAtIndex:section]];
    }
}

//建立索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearch)
    {
        return nil;
    }
    else
    {
        NSMutableArray *indexArr = [NSMutableArray array];
        [indexArr addObject:UITableViewIndexSearch];
        [indexArr addObjectsFromArray:_indexData];
        [indexArr addObject:@"end"];
        return indexArr;
    }
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
    {
        return -1;
    }
    
    if ([title isEqualToString:@"end"])
    {
        return -1;
    }
    return index -1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSInteger sectionNo = indexPath.section;
    NSInteger rowNo     = indexPath.row;
    
    //正在搜索
    if (_isSearch)
    {
        cell.textLabel.text = [_resultData objectAtIndex:rowNo];
    }
    else
    {
        cell.textLabel.text = [[_sourceData objectAtIndex:sectionNo] objectAtIndex:rowNo];
    }
    return cell;
}

#pragma mark -
#pragma mark UISearchBarDelegate

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    _isSearch = NO;
}

//搜索框内的文本发生变化时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterBySubstring:searchBar.text];
}

//点击虚拟键盘上的搜索时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
    [self filterBySubstring:searchBar.text];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    _searchBar.showsCancelButton = YES;
    NSArray *subViews;
    if (IS_IOS_7)
    {
        subViews = [(_searchBar.subviews[0]) subviews];
    }
    else {
        subViews = _searchBar.subviews;
    }
    
    for (id view in subViews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark -
#pragma mark Other Methods

//返回到首页
-(void)backToTuanGou
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//执行搜索的方法
-(void)filterBySubstring:(NSString *)subStr
{
    _isSearch = YES;//设置为开始搜索
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",subStr];
    //使用谓词过滤
    [_resultData removeAllObjects];
    [_resultData addObjectsFromArray:[_searchData filteredArrayUsingPredicate:pred]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
