//
//  TuanTableViewCell.h
//  LoveLife
//
//  Created by 刘 金兰 on 14-9-25.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuanTableViewCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *indexPicView;
@property (nonatomic,strong) UILabel *shopName;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *tel;
@property (nonatomic,strong) UILabel *price;

@end
