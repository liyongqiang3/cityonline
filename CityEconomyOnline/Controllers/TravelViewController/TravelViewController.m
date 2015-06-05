//
//  TravelViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "TravelViewController.h"
#import "ImageRequest.h"
#import "VideoRequest.h"
#import "SecondaryPageController.h"
#import "CacheData.h"
#import "CommonUtils.h"
#import "OwnerViewController.h"
@interface TravelViewController ()
{
    //第二部分的六个小视频
    TravelSmallView *_smallView0;
    TravelSmallView *_smallView1;
    TravelSmallView *_smallView2;
    TravelSmallView *_smallView3;
    TravelSmallView *_smallView4;
    TravelSmallView *_smallView5;
    
    NSUInteger _index;//遍历Timer的数据源用到
    NSTimeInterval interval;//幻灯片切换的时间间隔
}
@end

@implementation TravelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = kRightFrame;
    isPrompt = NO  ;
    islaod = NO ;
    imgArray = [[NSMutableArray alloc]init];// 数据

    self->strategyDataArray = [[NSMutableArray alloc]init];
    self->travelbigs = [[NSMutableArray alloc]init];
    
    // 读出上一次的数据 旅游照片
//    NSMutableArray * trevalImages = [[NSMutableArray alloc]init];
//      trevalImages   = [CacheData readCacheMemory:TRAVEL_PICTURES];
    // 旅游视频
//    NSMutableArray * trevalVideos = [[NSMutableArray alloc]init];
//    trevalVideos = [CacheData readCacheMemory:TRAVEL_VIDEO];
    // 攻略推荐
//    NSMutableArray * strategys = [CacheData readCacheMemory:STRATERGY_RECOMMENT];
    self->strategyDataArray = [[NSMutableArray alloc]initWithArray:nil];

    imageArray = [[NSMutableArray alloc]initWithArray:nil]; // 存放旅游图片的
    self->smallViewDataArray = [[NSMutableArray alloc]initWithArray:nil]; // 存放小视频对象的一个 数据
    
    //初始化界面元素
    
    
    
    [self initializeUI];
    _index = 0;
    interval = 1.0*[[NSUserDefaults standardUserDefaults]integerForKey:kDefaultSliderTime] ;
    [self getData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabelCount) name:@"OwnerImages" object:nil];
    NSMutableArray * array1 = [CacheData readCacheMemory:OWNER_IMAGES];
    NSString * countString  = [NSString stringWithFormat:@"%i",[array1 count]];
    [_myCityButton setTitle:countString forState:UIControlStateNormal];
//    [self httpGetData];
    
}
// 加载网路数据
-(void)httpGetData
{
    NSLog(@"---------skjgksgkj_-------__-");
    // 加载 第一部分图片 旅游照片
    ImageRequest * myImageRequest = [[ImageRequest alloc]init];
    
    [myImageRequest requestImageseWithArray:imageArray andSucceed:^{
     
//        [_firstPhoto setImageModelArray:[imageArray objectAtIndex:0]];
//        [_secondPhoto setImageModelArray:[imageArray objectAtIndex:1]];
//        [_thirdPhoto setImageModelArray:[imageArray objectAtIndex:2]];
        for (int i = 0 ; i < [imageArray count]; i ++) {
            TravelBigView * myTravelBigView = [travelbigs objectAtIndex:i];
//           [ myTravelBigView setImageModel:[imageArray objectAtIndex:i ]];
            [myTravelBigView setImageModelArray:[imageArray objectAtIndex:i ]];
            
        }
        [CacheData writeCacheMemory:imageArray andKeyString:TRAVEL_PICTURES];
        islaod = YES ;
     
    } onFailed:^{
        
        if (isPrompt == NO) {
            isPrompt = YES ;

            [self initPrompt];
        }

        
    }];
    
    // 加载网络 旅游视频
    VideoRequest   * requestViedo = [[VideoRequest alloc]init];
    [requestViedo setCompletionWithType:TravelVideo andArray:smallViewDataArray andSuccess:^(NSInteger index) {

        
        for (int i = 0 ; i < [smallViewDataArray count]; i ++) {
            NSString * vauleSmallView = @"_smallView";
           TravelSmallView * smallView =   [self valueForKey:[vauleSmallView stringByAppendingFormat:@"%d",i]];
            NewesVideo * myNewesVideo = [smallViewDataArray objectAtIndex:i];
            [smallView setNewesVideo:myNewesVideo];
//
//            
        }
        // 写入 网络 数据到 本地
        [CacheData writeCacheMemory:smallViewDataArray andKeyString:TRAVEL_VIDEO];
        islaod = YES ;
        
    } andFailed:^(NSString *errer) {
        
        
        if (isPrompt == NO) {
            isPrompt = YES ;
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
            [self initPrompt];
        }

    }];
    // 攻略推荐
    
    ImageRequest * strategyRequest = [[ImageRequest alloc]init];
    [strategyRequest requeststrategyimageWith:strategyDataArray andSucceed:^{
        NSString * vauleTipsView = @"tipsView";
        for (int i = 0; i < [strategyDataArray count]; i ++) {
            
            TravelBigView * mytipsView = [self valueForKey:[vauleTipsView stringByAppendingFormat:@"%i",i]];
            [mytipsView setImageModel:[strategyDataArray objectAtIndex:i]];
        }
         // 写入 网络 数据到 本地
        [CacheData writeCacheMemory:strategyDataArray andKeyString:STRATERGY_RECOMMENT];
        islaod = YES ;
        
    } onFailed:^{
        
        if (isPrompt == NO) {
            isPrompt = YES ;
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
            [self initPrompt];
        }
        // 攻略推荐
        
    }];
  
    
}
-(void)initPrompt
{

    CommonUtils * untls = [[CommonUtils alloc]init];
    [untls alertWithMessage:@"网络有点不给力！" andView:self.view];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	if (islaod == NO) {
        [self httpGetData];
    }
}

- (void)dealloc
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    [_timer release];
    _timer = nil;
    self.timerDataArray = nil;
    
    [_settingPopoverController release];
    
    [super dealloc];
}

- (void)initializeUI
{
     /* ==第一部分== */
    _titleLabel1 = [CommonUtils getCustomLabelWithFrame:CGRectMake(62, 10, 62, 18) text:@"旅游照片" fontSize:15 textColor:nil];
    [self.view addSubview:_titleLabel1];
    _firstPhoto = [[TravelBigView alloc] initWithFrame:CGRectMake(129, 10, 245, 210) withType:TravelBigViewSlider];
    _firstPhoto.traverViewController = self ;
    [self.view addSubview:_firstPhoto];
    _thirdPhoto = [[TravelBigView alloc] initWithFrame:CGRectMake(669, 10, 245, 210) withType:TravelBigViewSlider];
    _thirdPhoto.traverViewController = self ;
    _secondPhoto = [[TravelBigView alloc] initWithFrame:CGRectMake(399, 10, 245, 210) withType:TravelBigViewSlider];
    _secondPhoto.traverViewController = self ;
    [travelbigs addObject:_firstPhoto];
    [travelbigs addObject:_secondPhoto];
    [travelbigs addObject:_thirdPhoto];
    
    [self.view addSubview:_secondPhoto];
    [self.view addSubview:_thirdPhoto];
    
    

    
    //分割线
    UIView *separatorView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 235, width(self.view), 1)] autorelease];
    separatorView1.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:separatorView1];
    
    /* ==第二部分== */
    [self initSecondPart];
    
    //分割线
    UIView *separatorView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 358, width(self.view), 1)] autorelease];
    separatorView2.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:separatorView2];
    
     /* ==第三部分== */
    _titleLabel3 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 369, width(_titleLabel1), height(_titleLabel1)) text:@"我的活动" fontSize:15 textColor:nil];
    [self.view addSubview:_titleLabel3];
    
    _myCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _myCityButton.frame = CGRectMake(originX(_firstPhoto), originY(_titleLabel3), 113, 97);
    _myCityButton.titleEdgeInsets = UIEdgeInsetsMake(49, 14, 23, 16);
    _myCityButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _myCityButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_myCityButton setBackgroundImage:[UIImage imageNamed:@"MyCity.png"] forState:UIControlStateNormal];
    [_myCityButton addTarget:self action:@selector(showMyStorage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_myCityButton];
    
    _settingsButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(261, originY(_myCityButton), 113, 97) nomalImage:@"SettingsBtn.png" hightImage:nil target:self action:@selector(clickSetttings)];
    [self.view addSubview:_settingsButton];
    
     /* ==第四部分== */
    _forthContrainerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 474, width(self.view), 237)] autorelease];
    _forthContrainerView.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:_forthContrainerView];
    [self initFouthPart];
    
    
    
}


/*在这里因为城市锦囊的三级页面与城市旅游的
 *二级页面只有第四部分有差别，所以复用城市旅游的代码
 */
-(void)initFouthPart
{
    _titleLabel4 = [CommonUtils getCustomLabelWithFrame:CGRectMake(62, 10, 62, 18) text:@"攻略推荐" fontSize:15 textColor:nil];
    [_forthContrainerView addSubview:_titleLabel4];
    
    tipsView0 = [[[TravelBigView alloc] initWithFrame:CGRectMake(originX(_firstPhoto) + 0 * 270, originY(_titleLabel4), 245, 210) withType:TravelBigViewTips] autorelease];
    tipsView0.traverViewController = self ;
        [_forthContrainerView addSubview:tipsView0];
    
    tipsView1 = [[[TravelBigView alloc] initWithFrame:CGRectMake(originX(_firstPhoto) + 1 * 270, originY(_titleLabel4), 245, 210) withType:TravelBigViewTips] autorelease];
    tipsView1.traverViewController = self ;
        [_forthContrainerView addSubview:tipsView1];
    
    tipsView2 = [[[TravelBigView alloc] initWithFrame:CGRectMake(originX(_firstPhoto) + 2 * 270, originY(_titleLabel4), 245, 210) withType:TravelBigViewTips] autorelease];
    tipsView2.traverViewController = self ;
        [_forthContrainerView addSubview:tipsView2];
    
    _tipsMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 190, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreCityTips)];
    _tipsMoreButton.hidden = YES ;
    [_forthContrainerView addSubview:_tipsMoreButton];
}



- (void)initSecondPart
{
    _secondContainerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 236, width(self.view), 122)] autorelease];
    [self.view addSubview:_secondContainerView];
    
    _titleLabel2 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 10, width(_titleLabel1), height(_titleLabel1)) text:@"旅游视频" fontSize:15 textColor:nil];
    [_secondContainerView addSubview:_titleLabel2];
    
    _videoMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 90, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreVideo)];
    [_secondContainerView addSubview:_videoMoreButton];
    
    _smallView0 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_firstPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView0.travelViewController = self ;
    [_secondContainerView addSubview:_smallView0];
    _smallView1 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(263, originY(_smallView0), kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView1.travelViewController = self ;
    [_secondContainerView addSubview:_smallView1];
    
    _smallView2 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_secondPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView2.travelViewController = self ;
    [_secondContainerView addSubview:_smallView2];
    _smallView3 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(533, originY(_smallView0), kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView3.travelViewController = self ;
    [_secondContainerView addSubview:_smallView3];
    
    _smallView4 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_thirdPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView4.travelViewController = self ;
    [_secondContainerView addSubview:_smallView4];
    _smallView5 = [[[TravelSmallView alloc] initWithFrame:CGRectMake(803, originY(_smallView0), kTravelSmallViewWidth, kTravelSmallViewHeight)] autorelease];
    _smallView5.travelViewController = self ;
    [_secondContainerView addSubview:_smallView5];
}

// 加载缓存
- (void)getData
{
    //  旅游照片 加载本地
    if ([imageArray count]>=3) {
        [_firstPhoto setImageModelArray:[imageArray objectAtIndex:0]];
        [_secondPhoto setImageModelArray:[imageArray objectAtIndex:1]];
        [_thirdPhoto setImageModelArray:[imageArray objectAtIndex:2]];
    }
    
 
    // 旅游视频加载本地缓存
    for (int i = 0 ; i < [smallViewDataArray count]; i ++) {
        NSString * vauleSmallView = @"_smallView";
        TravelSmallView * smallView =   [self valueForKey:[vauleSmallView stringByAppendingFormat:@"%d",i]];
        NewesVideo * myNewesVideo = [smallViewDataArray objectAtIndex:i];
        [smallView setNewesVideo:myNewesVideo];
        
    }
    // 攻略推荐的加载本地缓存
      NSString * vauleTipsView = @"tipsView";
    for (int i = 0; i < [strategyDataArray count]; i ++) {
        
        TravelBigView * mytipsView = [self valueForKey:[vauleTipsView stringByAppendingFormat:@"%i",i]];
        [mytipsView setImageModel:[strategyDataArray objectAtIndex:i]];
    }


    


   }

- (void)imageFetchComplete:(ASIHTTPRequest *)req
{
    
    NSLog(@"*********");
    UIImage *img = [UIImage imageWithContentsOfFile:[req downloadDestinationPath]];
    [imgArray addObject:img];
    
    switch (imgArray.count) {
        case 1:
            [_firstPhoto._imageButton setImage:[imgArray objectAtIndex:0] forState:UIControlStateNormal];
            break;
        case 2:
            [_thirdPhoto._imageButton setImage:[imgArray objectAtIndex:1] forState:UIControlStateNormal];
            break;
        case 3:
            [tipsView0._imageButton  setImage:[imgArray objectAtIndex:2] forState:UIControlStateNormal];
            break;
        case 4:
            [tipsView1._imageButton setImage:[imgArray objectAtIndex:3] forState:UIControlStateNormal];
            break;
        case 5:
            [tipsView2._imageButton setImage:[imgArray objectAtIndex:4] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    
    
}



#pragma mark - 按钮事件处理

- (void)showPhotoSlider:(UIButton *)sender
{
    CLog(@"显示幻灯片详情");
}

- (void)showMoreVideo
{
//    CLog(@"显示更多旅游视频");
    if (islaod == NO) {
        [self initPrompt];
        return ;
    }
     SecondaryPageController *sController = [[[SecondaryPageController alloc]initWithVideoType:TravelVideo]autorelease];
    sController.leftString = @"旅游视频";
    [self presentViewController:sController animated:YES completion:nil];
    
}

- (void)showMoreCityTips
{
    
}

- (void)showMyStorage
{
    if (islaod == NO) {
        [self initPrompt];
        return ;
    }
    
    NSMutableArray * imageArray1 = [CacheData readCacheMemory:OWNER_IMAGES];
    if ([imageArray1 count] == 0) {
        CommonUtils * untils = [[CommonUtils alloc]init];
        [untils alertWithMessage:@"你还没添加图片" andView:self.view];
        return ;
    }
    OwnerViewController * owenerView = [[OwnerViewController alloc]initWithOwnerImages:imageArray1];
    [self presentViewController:owenerView animated:YES completion:nil];
    CLog(@"显示我收藏的城市");
}


- (void)clickSetttings
{
    CLog(@"显示设置内容");
    if (!_settingPopoverController) {
        
        _settingViewController = [[[SettingsViewController alloc] init] autorelease];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:_settingViewController];
        _settingPopoverController = [[UIPopoverController alloc] initWithContentViewController:nav];
        _settingPopoverController.popoverContentSize = CGSizeMake(kSettingsWidth, kSettingsHeight);
    }
    [_settingPopoverController presentPopoverFromRect:_settingsButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
//通知中心的回调函
-(void)changeLabelCount
{
    NSMutableArray * array1 = [CacheData readCacheMemory:OWNER_IMAGES];
    NSString * countString  = [NSString stringWithFormat:@"%i",[array1 count]];
    [_myCityButton setTitle:countString forState:UIControlStateNormal];
//    NSLog(@"收到通知！！uffjdjk");
    
}

@end
