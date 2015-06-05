//
//  ReadPdfViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-12-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ReadPdfViewController.h"
#define PDF_DOCMENT @"docment"
@interface ReadPdfViewController ()

@end

@implementation ReadPdfViewController
//@synthesize previewController = _previewController ;
@synthesize webView = _webView ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    //上面的还回
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11);
    [leftBtn setImage :[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    //分割线
    UIView  * seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 1024, 1)];
    seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);

    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 1024, 724)];
    NSString * path = [self getPath];
    NSURL * url = [NSURL URLWithString:path];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:request];
    
}
-(void)backHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//得到 沙河 路径  
-(NSString * )getPath
{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path =  [path stringByAppendingFormat:@"/%@%@.pdf",PDF_DOCMENT,imagePdf.pdfId];
    NSLog(@"%@",path);
    return path ;
}
-(void)setImagePdf:(ImagePdf *)_imagePdf
{
    self->imagePdf = _imagePdf ;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
