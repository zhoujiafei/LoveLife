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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"当前城市--南京";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"deatil_left_arrow"]
                                             style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(backToTuanGou)];
    
    //搜索栏
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,40)];
    _searchBar.placeholder = @"请输入要查找的城市...";
    _searchBar.showsCancelButton = YES;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    
    _searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplay.delegate = self;
//    _searchDisplay.searchResultsDataSource = self;
//    _searchDisplay.searchResultsDelegate = self;
    
    
    
    [self.view addSubview:_searchBar];
    
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [_searchBar setShowsCancelButton:YES];
    for (UIView *v in _searchBar.subviews)
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            [(UIButton *)v setTitle:@"返回" forState:UIControlStateNormal];
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
