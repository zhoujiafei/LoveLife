//
//  Global.h
//  LoveLife
//
//  Created by 周 加飞 on 14-9-25.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#ifndef LoveLife_Global_h
#define LoveLife_Global_h

#import "UIImageView+WebCache.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "DataManage.h"
#import "ProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#define CACHE_NAME @"data"

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif
