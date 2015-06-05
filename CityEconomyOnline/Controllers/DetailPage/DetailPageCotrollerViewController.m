//
//  DetailPageCotrollerViewController.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-13.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "DetailPageCotrollerViewController.h"
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"


@interface DetailPageCotrollerViewController ()

@end


@implementation DetailPageCotrollerViewController
@synthesize detailPage;
@synthesize request;
@synthesize view1;
@synthesize view2;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self fetchURL:[NSURL URLWithString:@"http://198.56.248.157:3000/articles/getdetail?id=5"]];
    [self initView];
    
}
-(void)initView
{
    UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [toolbar setItems:@[backItem]];
//    [self.view addSubview:toolbar];
//    detailPage = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//    [self.view addSubview:detailPage];
    
    
    
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchURL:(NSURL *)url
{
	   
	   
//	[self.request setDelegate:nil];
//	[self.request cancel];
//	[self setRequest:[ASIWebPageRequest requestWithURL:url]];
//    
//	[self.request setDidFailSelector:@selector(webPageFetchFailed:)];
//	[self.request setDidFinishSelector:@selector(webPageFetchSucceeded:)];
//	[self.request setDelegate:self];
//	[self.request setDownloadProgressDelegate:self];
//
//	
//	// It is strongly recommended that you set both a downloadCache and a downloadDestinationPath for all ASIWebPageRequests
//	[self.request setDownloadCache:[ASIDownloadCache sharedCache]];
//	[self.request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];//策略模式
//    
//	//缓存目录
//	[self.request setDownloadDestinationPath:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
//	
//	[[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:NO];
//	[self.request startAsynchronous];
}

- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"访问网页失败");
}



- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{

}

// We'll take over the page load when the user clicks on a link
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)theRequest navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[self fetchURL:[theRequest URL]];
		return NO;
	}
	return YES;
}



-(void)back
{
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
