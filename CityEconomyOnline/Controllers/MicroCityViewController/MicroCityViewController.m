
//
//  MicroCityViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
#define  SPACE_HEIGHT 0
#import "MicroCityViewController.h"
#import "SecondaryPageController.h"
#import "ASIHTTPRequest.h"
#import "VideoRequest.h"
#import "CacheData.h"
@interface MicroCityViewController ()

@end

@implementation MicroCityViewController

- (id)initWithType:(CommonViewType)type
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.myType = type;
        dataArray = [[NSMutableArray alloc]initWithCapacity:3];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isrequest = NO ;
    self.view.frame = kRightFrame;
    isPrompt = NO ;
    if (_myType == MicroCity) {
        [self addOneSectionWithTitle:@"城市微电影" withY:0 + SPACE_HEIGHT withTag:1];//改过liyongqiang
        [self addOneSectionWithTitle:@"公益广告" withY:234 + SPACE_HEIGHT  withTag:2];
        [self addOneSectionWithTitle:@"焦点专题" withY:2*234 + SPACE_HEIGHT withTag:3];
        NSMutableArray * cacheArray1 = [CacheData readCacheMemory:CITY_MICROFLIM];
//        dataArray = [[NSMutableArray alloc]initWithArray:cacheArray];
        firstArray = [[NSMutableArray alloc]initWithArray:cacheArray1];
          NSMutableArray * cacheArray2 = [CacheData readCacheMemory:CITY_MICROFLIM];
        secondArray = [[NSMutableArray alloc]initWithArray:cacheArray2];
        NSMutableArray * cacheArray3 = [CacheData readCacheMemory:PUBLIC_SERVICE_AD];
        
        thirdArray =  [[NSMutableArray alloc]initWithArray:cacheArray3];
//        [dataArray removeAllObjects];
    }
    else{
        [self addOneSectionWithTitle:@"领导访谈" withY:0 + SPACE_HEIGHT withTag:1];
        [self addOneSectionWithTitle:@"把脉城市" withY:234 + SPACE_HEIGHT withTag:2];
        [self addOneSectionWithTitle:@"热点对话" withY:2*234 + SPACE_HEIGHT withTag:3];
        NSMutableArray * cacheArray1 = [CacheData readCacheMemory:LEADER_TALK];
//        dataArray = [[NSMutableArray alloc]initWithArray: cacheArray];
        firstArray = [[NSMutableArray alloc]initWithArray:cacheArray1];
        
         NSMutableArray * cacheArray2 = [CacheData readCacheMemory:LEADER_TALK];
        secondArray = [[NSMutableArray alloc]initWithArray:cacheArray2];
          NSMutableArray * cacheArray3 = [CacheData readCacheMemory:HOTT_ALK];
        thirdArray = [[NSMutableArray alloc]initWithArray:cacheArray3];
        
    }
    [dataArray addObject:firstArray];
    [dataArray addObject:secondArray];
    [dataArray addObject:thirdArray];
    
      [self loadData];
//    [self  httpGetData];
//
    

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isrequest == NO) {
        
        [self httpGetData];
    }
    
   
//    [self loadData];
}

- (void)addOneSectionWithTitle:(NSString *)title withY:(CGFloat)y withTag:(NSUInteger)tag
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, y, width(self.view), 234)];
    containerView.tag = tag  + 50;//防止取到其他层
    
    //第一行不用再有分界线了
    
    if (y) {
        UIView *seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width(self.view), 1)];
        seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
        [containerView addSubview:seperatorView];
    }
    
    UILabel *label = [CommonUtils getCustomLabelWithFrame:CGRectMake(20, 10, 100, 18) text:title fontSize:15 textColor:nil];
    label.textAlignment = NSTextAlignmentRight;
    [containerView addSubview:label];
    
    for (int i = 0; i < 3; i ++) {
        CommonView *commonView = [[CommonView alloc] initWithFrame:CGRectMake(128 + (kCommonViewWidth + 25)*i, 10, kCommonViewWidth, kCommonViewHeight) withType:self.myType];
        commonView.superViewController = self ;
        commonView.tag = i + 10;
        [containerView addSubview:commonView];
    }
    
    UIButton *moreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 187, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(clickMoreButton:)];
    moreButton.tag = tag;
    [containerView addSubview:moreButton];
    [self.view addSubview:containerView];
}

- (void)loadData
{


//    
    for (int i = 1; i <= [dataArray count]; i ++) {
        UIView *tempContainerview = [self.view viewWithTag:i+50];
        NSMutableArray * array =  [dataArray objectAtIndex:i-1];
        for (int j = 0; j < [array count]; j ++) {
            UIView *tempView = [tempContainerview viewWithTag:j + 10];
            if ([tempView isKindOfClass:[CommonView class]]) {
//                [((CommonView *)tempView) setContentWithData:dicData];
                
                NewesVideo * newesVideo =  [array objectAtIndex:j];
//                NSLog(@"%@",newesVideo);
                  [((CommonView *)tempView) setNewesVideo:newesVideo];
                
            }
            
        }
    }
}
//  从网络获取数据
-(void)httpGetData
{
    int index = 0 ;
    //    NSOperationQueue * queue  = [[NSOperationQueue alloc]init];
    if (_myType == MicroCity) { // 如果是 微城市
        index = 5 ;
    } else {
        index = 2 ;
    }
    // 第一部分请求
    VideoRequest * rquest = [[VideoRequest alloc]init];
     [rquest setCompletionWithType:index  andArray:firstArray andSuccess:^(NSInteger index) {
         
          UIView *tempContainerview = [self.view viewWithTag:1+50];
         for (int j = 0; j < [firstArray count]; j ++) {
             UIView *tempView = [tempContainerview viewWithTag:j + 10];
             if ([tempView isKindOfClass:[CommonView class]]) {
                 //                [((CommonView *)tempView) setContentWithData:dicData];
                 
                 NewesVideo * newesVideo =  [firstArray objectAtIndex:j];
                 //                NSLog(@"%@",newesVideo);
                 [((CommonView *)tempView) setNewesVideo:newesVideo];
                 
             }
             
         }
         isrequest = YES ;
         // 写入本地
         if (index ==2) {
             
             [CacheData writeCacheMemory:firstArray andKeyString:LEADER_TALK];
         } else {
             [CacheData writeCacheMemory:firstArray andKeyString:CITY_MICROFLIM];
         }

         
     } andFailed:^(NSString *errer) {
         if (isPrompt == NO) {
             isPrompt = YES ;
             [self initPrompt];
             
         }

     }];
    index ++ ;
    // 第二部分请求
    VideoRequest * rquest2 = [[VideoRequest alloc]init];
    [rquest2 setCompletionWithType:index  andArray:secondArray andSuccess:^(NSInteger index) {
        
        UIView *tempContainerview = [self.view viewWithTag:2+50];
        for (int j = 0; j < [secondArray count]; j ++) {
            UIView *tempView = [tempContainerview viewWithTag:j + 10];
            if ([tempView isKindOfClass:[CommonView class]]) {
                //                [((CommonView *)tempView) setContentWithData:dicData];
                
                NewesVideo * newesVideo =  [secondArray objectAtIndex:j];
                //                NSLog(@"%@",newesVideo);
                [((CommonView *)tempView) setNewesVideo:newesVideo];
                
            }
        }
        isrequest = YES ;
        // 写入本地 数据
        if (index == 3) {
            [CacheData writeCacheMemory:secondArray andKeyString:PLUSE_City];
            
        }else {
            [CacheData writeCacheMemory:secondArray andKeyString:PUBLIC_SERVICE_AD];
        }
        
    } andFailed:^(NSString *errer) {
        if (isPrompt == NO) {
            isPrompt = YES ;
            [self initPrompt];
            
        }
        
    }];
    index ++ ;
    // 第三部分请求
    VideoRequest * rquest3 = [[VideoRequest alloc]init];
    [rquest3 setCompletionWithType:index andArray:thirdArray andSuccess:^(NSInteger index) {
        
        UIView *tempContainerview = [self.view viewWithTag:3+50];
        for (int j = 0; j < [thirdArray count]; j ++) {
            UIView *tempView = [tempContainerview viewWithTag:j + 10];
            if ([tempView isKindOfClass:[CommonView class]]) {
                //                [((CommonView *)tempView) setContentWithData:dicData];
                
                NewesVideo * newesVideo =  [thirdArray objectAtIndex:j];
                //                NSLog(@"%@",newesVideo);
                [((CommonView *)tempView) setNewesVideo:newesVideo];
                
            }
        }
        if (index == 4) {
            [CacheData writeCacheMemory:thirdArray andKeyString:HOTT_ALK];
        } else {
            [CacheData writeCacheMemory:thirdArray andKeyString:FOCUS_SPRCIAL];
        }
        isrequest = YES ;
        
    } andFailed:^(NSString *errer) {
        if (isPrompt == NO) {
            isPrompt = YES ;
            [self initPrompt];
            
        }
        
    }];
    
}
-(void)initPrompt
{

    CommonUtils * utils = [[CommonUtils alloc]init];
    [utils alertWithMessage:@"网络有点不给力！！" andView:self.view];
    

    
}

- (void)clickMoreButton:(UIButton *)sender
{
    if (isrequest == NO ) {
        [self initPrompt];
        return ;
    }
    int tag = sender.tag;
    CLog(@"对话城市和微城市更多点击tag=%d",tag);
    if (_myType ==MicroCity ) {
        tag = tag + 3 ;
    }
    Videotype type = tag + 1 ;
    SecondaryPageController *sController = [[SecondaryPageController alloc]initWithVideoType:type];
    NSString * titleType = nil ;
    switch (type) {
        case Leadertalk:
         titleType = @"领导谈话";
            break;
            case PulseCity:
            titleType = @"把脉城市";
            break;
            case HotspotDialogue:
            titleType = @"热点对话";
            break;
            case CityMicroFilm:
            titleType = @"城市微电影";
            break;
            case PublicWelfareAd:
            titleType = @"公益广告";
            break;
            case FocusSpecial:
            titleType = @"焦点专题";
        default:
            break;
    }
    sController.leftString = titleType;
    

    [self presentViewController:sController animated:YES completion:nil];
}
-(void)initdata
{
//    ASIHTTPRequest *  request ;
//    NSString * urlString2 = @"http://192.168.51.38:3000/videos/getbyusage/?usage=1";
//    NSURL * url2 = [NSURL URLWithString:urlString2];
//    request= [ASIHTTPRequest requestWithURL:url2];
//    [request startSynchronous];
//    NSString * dataResponseString = [request responseString];
//    NSLog(@"------***--%@",dataResponseString);
//    NSData * data =  [dataResponseString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"------33333----?%@",dic1);
//    
//    NSString * htmlString = [dic1 valueForKey:@"content"];
////    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://192.168.51.38:3000"];
//    
//    NSLog(@"----%@",htmlString);
//    NSMutableArray * array = [[NSMutableArray alloc]init];
//    VideoRequest * videoRequest = [[VideoRequest alloc]init];
//    [videoRequest setCompletionWithPath:@"/videos/getbyusage/?" andType:TravelVideo andArray:array andSuccess:^{
////        NSLog(@"jskgjksjgkjskjgksgj---sgs");
//        NSLog(@"%@",array);
//    } andFailed:^(NSString *errer) {
//        
//        NSLog(@"错误 88888%@",errer);
//    }];
    
}

@end
