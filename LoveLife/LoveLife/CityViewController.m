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
    _isSearch = NO;
    
    //构建列表数据
    _sourceData = [NSMutableArray array];
    for (int section = 'A'; section <='Z'; section ++)
    {
        NSMutableArray *itemArr = [NSMutableArray array];
        for (int row = 0; row < 5; row ++)
        {
            NSString *name = [NSString stringWithFormat:@"%c%d",section,row];
            [itemArr addObject:name];
        }
        [_sourceData addObject:itemArr];
    }
    _resultData = [NSMutableArray array];
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
    NSMutableArray *eachArr = [_sourceData objectAtIndex:section];
    return [eachArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sourceData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [NSString stringWithFormat:@"第%c段",'A' + section];
    return sectionName;
}

//建立索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexData = [NSMutableArray array];
    [indexData addObject:UITableViewIndexSearch];
    for (NSInteger i = 0; i<26; i++)
    {
        NSString *item = [NSString stringWithFormat:@"%c",'A' + i];
        [indexData addObject:item];
    }
    [indexData addObject:@"end"];
    return indexData;
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
#pragma mark UISearchBarDelegate

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    _isSearch = NO;
}

//搜索框内的文本发生变化时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _isSearch = YES;
}

//点击虚拟键盘上的搜索时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
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
