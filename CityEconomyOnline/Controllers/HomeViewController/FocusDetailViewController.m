//
//  FocusDetailViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-11-24.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "FocusDetailViewController.h"
#import "ArticleRequest.h"
#import "ArticleDetail.h"
#import "MyRootViewController.h"
@interface FocusDetailViewController ()

@end

@implementation FocusDetailViewController
@synthesize  contentView = _contentView ;
//@synthesize  toolbar = _toolbar ;
@synthesize  articleTitle = _articleTitle ;
@synthesize  subTilte = _subTilte ;
@synthesize  viewController = _viewController ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDetailID:(NSString *)_detailID
{
    self = [super init];
    if (self) {
        
        self->detailID = _detailID ;
    }
    return self  ;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self->articleDetails = [[NSMutableArray alloc]init];
    
    [self initCommentView];
    self.view.backgroundColor = [UIColor blackColor];
    hud = [[MBProgressHUD alloc]init];
    hud.labelText = @"loading......";
    [self.view addSubview:hud];
//    [hud show:YES];
    [self initGetData];
  
}
-(void)initCommentView
{

    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    //上面的还回
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 10);
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 5, 40, 35)];
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(7.5, 8, 7.5,8) ;
    [homeBtn setImage :[UIImage imageNamed:@"home_01.png"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navTabBar addSubview:leftBtn];
    [navTabBar addSubview:homeBtn];
    
    
    [self.view addSubview:navTabBar];
    UIView  * seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 1024, 1)];
    [self.view addSubview:seperatorView];
    seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
   
    UIView *  titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, 1024, 80)];
    _articleTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 500, 55)];
    _subTilte = [[UILabel alloc]initWithFrame:CGRectMake(30, 55, 800, 25)];
    _articleTitle.font = [UIFont systemFontOfSize:24];
    _subTilte.font = [UIFont systemFontOfSize:12];
    _subTilte.textColor = [UIColor whiteColor];
    _articleTitle.textColor = [UIColor whiteColor];
    _articleTitle.backgroundColor = [UIColor clearColor];
    _subTilte.backgroundColor = [UIColor clearColor];
    [titleView addSubview:_articleTitle];
    [titleView addSubview:_subTilte];
    [self.view addSubview:titleView];
    UIView  * seperatorView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 126, 1024, 1)];
    [self.view addSubview:seperatorView1];
    seperatorView1.backgroundColor = RGBCOLOR(59, 59, 59);
    _contentView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 127, SCREEN_WIDTH, SCREEN_HEIGHT - 127)];
    _contentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_contentView];
    [_contentView loadHTMLString:@"<html><body style= 'color: white; background: black' ></body></html>" baseURL:nil];
    _contentView.hidden = YES ;
    
    
}
-(void)initGetData
{
//    NSString * urlString2 = @"http://192.168.51.38:3000/articles/getdetail?id=3";
//    NSURL * url2 = [NSURL URLWithString:urlString2];
//      request= [ASIHTTPRequest requestWithURL:url2];
//    [request startSynchronous];
//    NSString * dataResponseString = [request responseString];
////    NSLog(@"------***--%@",dataResponseString);
//    NSData * data =  [dataResponseString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"------33333----?%@",dic1);
//    
//    NSString * htmlString = [dic1 valueForKey:@"content"];
//   htmlString = [htmlString stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://192.168.51.38:3000"];
//    NSLog(@"----%@",htmlString);
//    [_contentView loadHTMLString:htmlString baseURL:nil];
    // <html><body bgcolor="rgb(36,36,36)"></body></html>
    ArticleRequest * request = [[ArticleRequest alloc]init];
    NSInteger index = [detailID integerValue];
    NSLog(@"----______----%i",index);
    [request requestArticleDetailWithIndex:index andArray:articleDetails andSucceed:^{
        
    
        ArticleDetail * myArticleDetail = [articleDetails objectAtIndex:0];
        // 组装 html 字符串
//        NSString * htmlString = [NSString stringWithFormat:@"<html><body bgcolor="rgb(36,36,36)">%@</body></html>",myArticleDetail.content];
        _articleTitle.text = myArticleDetail.title;
        _subTilte.text = myArticleDetail.subtitle ;
        
        
        NSString * htmlString = [NSString stringWithFormat:@"<html><body style= 'color: white; background: black' >%@</body></html>"  ,myArticleDetail.content];
        [_contentView loadHTMLString:htmlString baseURL:nil];
        
        [hud hide:YES];
        _contentView.hidden = NO ;
    } andFailed:^{
        
         [hud hide:YES];
       
        CommonUtils * utils = [[CommonUtils alloc]init];
        [utils alertWithMessage:@"网络有点不给力" andView:self.view];
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}
//回到主页
-(void)backHome:(UIButton *)sender 
{
    // 回到主页
    //自定义 动画效果
    
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:NO completion:^{                                                                                                                                                                                                                                                                                                                                                                                                      
        [_viewController dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:BACK_HOME object:nil];
        }];
    }];
    
    
    
    
}
// 回到上一级
-(void)back
{

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
