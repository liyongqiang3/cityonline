//
//  SecretTipsViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-12-3.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "SecretTipsViewController.h"
#import "SecretTipsCiytCell.h"
#import  "SecretCityTip.h"
#import "ImageRequest.h"

@interface SecretTipsViewController ()

@end

@implementation SecretTipsViewController
@synthesize cityTabeleView = _cityTabeleView ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self->viewFrame = frame;
        [self.view setFrame:frame];
        
    }
    return self ;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initdata];
    self->isGethttp = NO ;
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    NSLog(@"%f----%f",self->viewFrame.size.width,self->viewFrame.size.height);
    
    _cityTabeleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self->viewFrame.size.width, self->viewFrame.size.height) style:UITableViewStylePlain];
    _cityTabeleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cityTabeleView];
     _cityTabeleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cityTabeleView.delegate = self ;
    _cityTabeleView.dataSource =  self ;
    hud = [[MBProgressHUD alloc]init];
    hud.labelText = @"loading......";
    [self.view addSubview:hud];
    [hud show: YES]; ;
    self->cityTips = [[NSMutableArray alloc]init];
//    [self loadHttpListData];

}
-(void)viewWillAppear:(BOOL)animated
{
    if (self->isGethttp == NO) {
        [self loadHttpListData];
    }
}
-(void)initdata
{
    
}
//获取数据
- (void)loadHttpListData
{
    ImageRequest * request = [[ImageRequest alloc]init];
    [request requestImagePdfWithArray:self->cityTips andCityId:0 onSuccess:^{
        [_cityTabeleView reloadData];
        
        if ([cityTips count] == 0) {
            hud3 =[[MBProgressHUD alloc]initWithView:self.view];
            hud3.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_error.png"]];
            hud3.mode = MBProgressHUDModeCustomView;
            //    hud.delegate = self;
            hud3.labelText = @"还没开始上传数据～";
            [self.view addSubview:hud3];
            [hud3 show:YES];
//            [hud3 hide:YES afterDelay:2];

        } else {
            [hud hide:YES];
        }
        self->isGethttp = YES  ;
        [hud hide:YES] ;
        
    } onFailed:^{
//        [hud hide:YES]; ;
        CommonUtils * utlis = [[CommonUtils alloc]init];
        [utlis alertWithMessage:@"网络有点不给力！" andView:self.view];
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UItableView datasoure mothds
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger  count = 0 ;
    
    if ([self->cityTips count]>0) {
     
        count = [cityTips count]/3 ;
        if ([cityTips count]% 3 != 0) {
            count ++ ;
            
        }
        
    }
    NSLog(@"------------%i",count);
    
    return count;
}
// 返回  cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString * indentiferiCell = @"indentiferiCell";
    SecretTipsCiytCell * cell = [tableView dequeueReusableCellWithIdentifier:indentiferiCell];
    if (cell == nil) {
        cell = [[SecretTipsCiytCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentiferiCell];
        
    }
    cell.viewController = self ;
    
    NSMutableArray * citytips = [[NSMutableArray alloc]init];
    for (int i = 3 * indexPath.row; (i < indexPath.row *3 + 3) && i < [cityTips count] ;i ++ ) {
        
        [citytips addObject:[cityTips objectAtIndex:i]];
    }
    [cell setCityTipsButtons:citytips];
    
    
    return cell ;
 
}
// 每个 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCityTopSpace + kCityHeight + kCityBottomSpace;
}

@end
