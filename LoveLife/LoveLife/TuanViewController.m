//
//  TuanViewController.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "TuanViewController.h"
#import "CityViewController.h"

@interface TuanViewController ()

@end

@implementation TuanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置显示最左边的当前城市
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"南京"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(showCitys)];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

//显示城市列表
-(void)showCitys
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
