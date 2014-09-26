//
//  TuanViewController.h
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "TuanTableViewCell.h"

@interface TuanViewController : BaseViewController <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) EGORefreshTableHeaderView *refreshTableHeaderView;
@property (nonatomic,assign) BOOL reloading;
@property (nonatomic,strong) NSMutableArray *shopData;

@end
