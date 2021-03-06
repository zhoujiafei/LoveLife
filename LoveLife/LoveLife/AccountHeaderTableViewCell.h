//
//  AccountHeaderTableViewCell.h
//  LoveLife
//
//  Created by 周 加飞 on 14-10-21.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountHeaderCellDelegate;

@interface AccountHeaderTableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton *couponBtn;//优惠按钮
@property (nonatomic,strong) UIButton *collectBtn;//收藏按钮
@property (nonatomic,strong) UIButton *historyBtn;//最近浏览按钮
@property (nonatomic,strong) id <AccountHeaderCellDelegate> delegate;

@end

//代理
@protocol AccountHeaderCellDelegate <NSObject>

@optional

-(void)clickCouponButton;
-(void)clickCollectButton;
-(void)clickHistoryButton;

@end
