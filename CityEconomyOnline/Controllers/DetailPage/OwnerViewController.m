//
//  OwnerViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-12-19.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "OwnerViewController.h"

@interface OwnerViewController ()

@end

@implementation OwnerViewController
@synthesize listView = _listView ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithOwnerImages:(NSMutableArray *)_ownerImages
{
    self = [super init];
    if (self ) {
        self->ownerImages = _ownerImages ;
    }
    return self ;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    //    [self.view addSubview:navTabBar];
    //上面的还回
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 36, 30)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    [self.view addSubview:navTabBar];
    _listView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 1024, 724)];
    _listView.contentSize = CGSizeMake(1024*[self->ownerImages count], 724);
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.pagingEnabled = YES;
    _listView.delegate = self ;

    [self.view addSubview:_listView];

	// Do any additional setup after loading the view.
    [self initImageView];
    
}
-(void)initImageView
{
    for (int i =0 ; i < [self->ownerImages count]; i++) {
        UIImageView * myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*1024, 0, 1024, 724)];
        [myImageView setImage:[self->ownerImages objectAtIndex:i]];
        [_listView addSubview:myImageView];
        
    }
}
-(void)backHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
