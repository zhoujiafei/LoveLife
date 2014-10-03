//
//  HeaderTableViewCell.h
//  LoveLife
//
//  Created by 刘 金兰 on 14-10-3.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UIScrollView  *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end
