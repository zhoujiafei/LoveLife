//
//  MyViewController.h
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountHeaderTableViewCell.h"
#import "MyTableViewCell.h"

@interface MyViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource,AccountHeaderCellDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end
