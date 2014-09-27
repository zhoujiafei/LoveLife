//
//  PowerPointTableViewCell.h
//  LoveLife
//
//  Created by 刘 金兰 on 14-9-26.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PowerPointTableViewCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end
