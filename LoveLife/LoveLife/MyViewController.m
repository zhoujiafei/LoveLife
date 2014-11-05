//
//  MyViewController.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (nonatomic,strong) NSMutableArray *cellIconArr;

@end

@implementation MyViewController

@synthesize tableView  = _tableView;
@synthesize dataSource = _dataSource;
@synthesize cellIconArr = _cellIconArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initTableview];
}

#pragma mark
#pragma mark Init Methods

//初始化数据源
-(void)initDataSource
{
    _dataSource = [NSMutableArray arrayWithObjects:@[@"今日推荐"],
                                                   @[@"待付款订单",@"已付款订单",@"抽奖单"],
                                                   @[@"抵用券"],nil];
    _cellIconArr = [NSMutableArray arrayWithObjects:@[@"user_listicon_tuijian"],
                                                    @[@"user_listicon_daifukuan",@"user_listicon_yifukuan",@"user_listicon_choujiang"],
                                                    @[@"user_listicon_diyongquan"],nil];
    
}

//初始化tableView
-(void)initTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
}


#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return [[_dataSource objectAtIndex:section - 1] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger rowNo   = indexPath.row;
    
    if (section == 0)
    {
        static NSString *cellId = @"headCell";
        AccountHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[AccountHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.delegate = self;
        return cell;
    }
    else
    {
        static NSString *cellId = @"cellId";
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.cellTitle.text = [[_dataSource objectAtIndex:section - 1] objectAtIndex:rowNo];
        cell.imageView.image = [UIImage imageNamed:[[_cellIconArr objectAtIndex:section - 1] objectAtIndex:rowNo]];
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 220;
    }
    else
    {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }
    else
    {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark
#pragma mark AccountHeaderCellDelegate
-(void)clickCouponButton
{
    NSLog(@"clickCouponButton");
}

-(void)clickCollectButton
{
    NSLog(@"clickCollectButton");
}

-(void)clickHistoryButton
{
    NSLog(@"clickHistoryButton");
}


#pragma mark
#pragma mark Other Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
