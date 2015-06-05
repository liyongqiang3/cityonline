//
//  TipsInfoViewController.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-7.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "TipsInfoViewController.h"
#import "TravelSmallView.h"
#import "VedioViewController.h"
#import "ImageRequest.h"
#import "VideoRequest.h"
#import "SecondaryPageController.h"
#import "CacheData.h"
#import "OwnerViewController.h"
@interface TipsInfoViewController ()
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

@implementation TipsInfoViewController
@synthesize tvName;
@synthesize array;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imgArray = [[NSMutableArray alloc]init]; // 存放图片的 的地方
    travelbigs = [[NSMutableArray alloc]init];
    travelVideos = [[NSMutableArray alloc]init]; //旅游视频的
    self.view.backgroundColor = [UIColor blackColor];
    
	UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11);
    [leftBtn setImage :[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 5, 40, 35)];
      homeBtn.imageEdgeInsets = UIEdgeInsetsMake(7.5, 8, 7.5,8) ;
    [homeBtn setImage :[UIImage imageNamed:@"home_01.png"] forState:UIControlStateNormal];
  
    [homeBtn addTarget:self action:@selector(backHomeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:homeBtn];
    
    [navTabBar addSubview:leftBtn];

    
    
    _leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, kLeftViewWidth, height(self.view)-46)];
    _leftMenuView.backgroundColor = RGBCOLOR(51, 50, 50);
    [self.view addSubview:_leftMenuView];
    cityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 72, 65)];
    [cityImageView setImage:[UIImage imageNamed:@"city_bejing.png"]];
    [_leftMenuView addSubview:cityImageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 72, kLeftViewWidth, 50)];
    label.backgroundColor = RGBCOLOR(51, 50, 50);
    label.text = @"北京";
    label.textColor = RGBCOLOR(255 , 255, 255);
    label.textAlignment = NSTextAlignmentCenter;
    [_leftMenuView addSubview:label];
    [self.view addSubview:_leftMenuView];
    
    self.tvName = [NSMutableArray arrayWithObjects:@"北京卫视",nil];
    
   _rightView = [[UIView alloc] initWithFrame:CGRectMake(90,44,934,748-45)];
//    _rightView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ListBackGround.png"]];
    _rightView.backgroundColor = RGBCOLOR(41, 41, 41);
    self->isHttpData = NO ;
    self->isPrompt = NO ;
    [self.view addSubview:_rightView];
    [self initDetailUI];
    [self getData];
//    [self httpGetData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabelCount) name:@"OwnerImages" object:nil];
    NSMutableArray * array1 = [CacheData readCacheMemory:OWNER_IMAGES];
    NSString * countString  = [NSString stringWithFormat:@"%i",[array1 count]];
    [_myCityButton setTitle:countString forState:UIControlStateNormal];
    
    

}

-(void)initDetailUI
{
    /* ==第一部分== */
    _titleLabel1 = [CommonUtils getCustomLabelWithFrame:CGRectMake(62, 10, 62, 18) text:@"旅游照片" fontSize:15 textColor:nil];
    [_rightView addSubview:_titleLabel1];
    
    _firstPhoto = [[TipInfoView alloc] initWithFrame:CGRectMake(129, 10, 245, 210) ];
    _firstPhoto.traverViewController = self ;
    [_rightView addSubview:_firstPhoto];
    _secondPhoto = [[TipInfoView alloc] initWithFrame:CGRectMake(399, 10, 245, 210) ];
    _secondPhoto.traverViewController = self ;
    _thirdPhoto = [[TipInfoView alloc] initWithFrame:CGRectMake(669, 10, 245, 210)];
    _thirdPhoto.traverViewController = self ;
    [travelbigs addObject:_firstPhoto];
    [travelbigs addObject:_secondPhoto];
    [travelbigs addObject:_thirdPhoto];
    
    [_rightView addSubview:_secondPhoto];
    [_rightView addSubview:_thirdPhoto];
    
   //
    //分割线
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 235, width(self.view), 1)];
    separatorView1.backgroundColor = RGBCOLOR(59, 59, 59);
   
    /* ==第二部分== */
    [self initSecondPart];
    
    //分割线
    UIView *separatorView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 358, width(self.view), 1)];
    separatorView2.backgroundColor = RGBCOLOR(59, 59, 59);
    [_rightView addSubview:separatorView2];
    
    /* ==第三部分== */
    _titleLabel3 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 369, width(_titleLabel1), height(_titleLabel1)) text:@"我的活动" fontSize:15 textColor:nil];
    [_rightView addSubview:_titleLabel3];
    
    _myCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _myCityButton.frame = CGRectMake(originX(_firstPhoto), originY(_titleLabel3), 113, 97);
    _myCityButton.titleEdgeInsets = UIEdgeInsetsMake(49, 14, 23, 16);
    _myCityButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _myCityButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_myCityButton setBackgroundImage:[UIImage imageNamed:@"MyCity.png"] forState:UIControlStateNormal];
    [_myCityButton addTarget:self action:@selector(showMyStorage) forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:_myCityButton];
    
    _settingsButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(261, originY(_myCityButton), 113, 97) nomalImage:@"SettingsBtn.png" hightImage:nil target:self action:@selector(clickSetttings)];
    [_rightView addSubview:_settingsButton];
    
    /* ==第四部分== */
    _forthContrainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 474, 937, 237)];
    _forthContrainerView.backgroundColor = RGBCOLOR(59, 59, 59);
    
   
    [_rightView addSubview:_forthContrainerView];
    [self initFourthPart];
    [_rightView addSubview:separatorView1];
    

}

-(void)initFourthPart
{
    _titleLabel4 = [CommonUtils getCustomLabelWithFrame:CGRectMake(62, 474, width(_titleLabel1), height(_titleLabel1)) text:@"直播" fontSize:15 textColor:nil];
    [_rightView addSubview:_titleLabel4];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 474, 600, 237)];
    [_imageView setImage:[UIImage imageNamed:@"beijing2.png"]];
    [_rightView addSubview:_imageView];
    
    
    tvList = [[UITableView alloc]initWithFrame:CGRectMake(730, 474, 204, 237)];
    tvList.backgroundColor = [UIColor clearColor];
    tvList.separatorColor = [UIColor blackColor];
    tvList.delegate = self;
    tvList.dataSource = self;
    tvList.allowsSelection = YES ;
//    tvList.a
    [_rightView addSubview:tvList];
    
    
    
}

#pragma mark 表格相关函数
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.tvName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"playOnline.png"];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text =[self.tvName objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if (isHttpData == NO) {
        [self initPrompt];
        return ;
    }
    
    VedioViewController *detailViewController = [[VedioViewController alloc]init];
        detailViewController.addressId = indexPath.row;
    
   [self presentViewController:detailViewController animated:YES completion:nil];
    
}


- (void)initSecondPart
{
    _secondContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 236, width(_rightView), 122)];
    [_rightView addSubview:_secondContainerView];
    
    _titleLabel2 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 10, width(_titleLabel1), height(_titleLabel1)) text:@"旅游视频" fontSize:15 textColor:nil];
    [_secondContainerView addSubview:_titleLabel2];
    
    _videoMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 90, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreVideo)];
    [_secondContainerView addSubview:_videoMoreButton];
    
    _smallView0 = [[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_firstPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView0.travelViewController = self ;
    [_secondContainerView addSubview:_smallView0];
    _smallView1 = [[TravelSmallView alloc] initWithFrame:CGRectMake(263, originY(_smallView0), kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView1.travelViewController = self ;
    [_secondContainerView addSubview:_smallView1];
    
    _smallView2 = [[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_secondPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView2.travelViewController = self ;
    
    [_secondContainerView addSubview:_smallView2];
    _smallView3 = [[TravelSmallView alloc] initWithFrame:CGRectMake(533, originY(_smallView0), kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView3.travelViewController = self ;
    [_secondContainerView addSubview:_smallView3];
    
    _smallView4 = [[TravelSmallView alloc] initWithFrame:CGRectMake(originX(_thirdPhoto), 10, kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView4.travelViewController = self ;
    [_secondContainerView addSubview:_smallView4];
    _smallView5 = [[TravelSmallView alloc] initWithFrame:CGRectMake(803, 10, kTravelSmallViewWidth, kTravelSmallViewHeight)];
    _smallView5.travelViewController = self ;
    [_secondContainerView addSubview:_smallView5] ;
}

- (void)clickSetttings
{
    CLog(@"显示设置内容");
    if (!_settingPopoverController) {
      
        _settingViewController = [[SettingsViewController alloc] init];
          UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:_settingViewController];
        _settingPopoverController = [[UIPopoverController alloc] initWithContentViewController:nav];
        _settingPopoverController.popoverContentSize = CGSizeMake(kSettingsWidth, kSettingsHeight);
    }
    [_settingPopoverController presentPopoverFromRect:_settingsButton.frame inView:_rightView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
- (void)httpGetData
{
    // 加载 第一部分图片
    ImageRequest * myImageRequest = [[ImageRequest alloc]init];
    // 以后 cityid 是动态 获取的 默认为北京
    
    [myImageRequest requestCiytImageWithArray:imgArray andCityId:@"1" onSucceed:^{

        for (int i = 0 ; i < [imgArray count]; i ++) {
            TipInfoView * myTravelBigView = [travelbigs objectAtIndex:i];

            [myTravelBigView setImageModelArray:[imgArray objectAtIndex:i ]];
            
        }
        self->isHttpData = YES ;
    } onfailed:^{
        if (isPrompt == NO ) {
            isPrompt = YES ;
            [self initPrompt];
        }
    }];
    
    // 加载旅游视频的 默认城市 为北京 id ＝ 1
    VideoRequest * myVideorequest = [[VideoRequest alloc]init];
    [myVideorequest requestCityVideoWithType:TravelVideo andCityId:@"1" andArray:travelVideos onSuccess:^{

        for (int i = 0 ; i < [travelVideos count]; i ++) {
            NSString * vauleSmallView = @"_smallView";
            TravelSmallView * smallView =   [self valueForKey:[vauleSmallView stringByAppendingFormat:@"%d",i]];
            NewesVideo * myNewesVideo = [travelVideos objectAtIndex:i];
            [smallView setNewesVideo:myNewesVideo];
        }
//        _smallView5 setNewesVideo:[travelVideos objectAtIndex:]
        self->isHttpData = YES ;
        
    } onFailed:^{
        if (isPrompt == NO) {
            isPrompt = YES ;
            [self initPrompt];
            
    
        }
    }];
    
}
- (void)getData
{
//    [_secondButton setImage:[UIImage imageNamed:@"Travel_Slider.png"] forState:UIControlStateNormal];

    
    NSDictionary *dic1 = nil ; //[NSDictionary dictionaryWithObjectsAndKeys:@"Travel_Small1.png",@"imageUrl",@"登山旅游注意事项",@"content", nil];
    NSDictionary *dic2 = nil ; //[NSDictionary dictionaryWithObjectsAndKeys:@"Travel_Small2.png",@"imageUrl",@"小编教你摄影",@"content", nil];
    [_smallView0 setContentWithData:dic1];
    [_smallView1 setContentWithData:dic2];
    [_smallView2 setContentWithData:dic1];
    [_smallView3 setContentWithData:dic2];
    [_smallView4 setContentWithData:dic1];
    [_smallView5 setContentWithData:dic2];
    
    [_myCityButton setTitle:@"1" forState:UIControlStateNormal];
    
    for (int i = 50; i < 53 ;i ++) {
        if ([[_forthContrainerView viewWithTag:i] isKindOfClass:[TipInfoView class]]) {
            TipInfoView *tempView = (TipInfoView *)[_forthContrainerView viewWithTag:i];
            [tempView setContentWithData:nil];
        }
    }
    
    //触发timer
//    if (![_timer isValid]) {
//        [_timer fire];
//    }

    
    
    
    NSString *urlString = [HOST stringByAppendingString:@"/pictures/getbyusage?usage=0"];
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
//    [request startSynchronous];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    if (data==nil) {
        return;
    }
    
//    array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    
    
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
    
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
	[networkQueue setDelegate:self];
    
    for (int i=0; i<[array count]; i++) {
        
        NSString *imgUrl = [(NSDictionary *)[array objectAtIndex:i] objectForKey:@"url"];
        
        NSString *imageUrl = [HOST stringByAppendingString:imgUrl];
        
        ASIHTTPRequest *req;
        req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
        NSString *fileName = [NSString stringWithFormat:@"tips-%d.png",i];
        [req setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName]];
        [networkQueue addOperation:req];
    }
    
    [networkQueue go];
    
    _firstPhoto._contentLabel.text = [(NSDictionary *)[array objectAtIndex:0]  objectForKey:@"landscape_name"];
    
    _thirdPhoto._contentLabel.text = [(NSDictionary *)[array objectAtIndex:1]  objectForKey:@"landscape_name"];
    
    }

-(void)initPrompt
{
    
    
    CommonUtils   * utils = [[CommonUtils alloc]init];
    [utils alertWithMessage:@"网络有点不给力！！" andView:self.view];
    
    
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
    if (isHttpData == NO) {
        [self initPrompt];
        return ;
    }
    SecondaryPageController *sController = [[SecondaryPageController alloc]initWithVideoType:TravelVideo];
    sController.leftString = @"旅游视频";
    [self presentViewController:sController animated:YES completion:nil];
    
    
}

- (void)showMoreCityTips
{
    
}

- (void)showMyStorage
{
    if (isHttpData == NO) {
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


- (void)timerFired:(NSTimer *)senderTimer
{
    NSString *tempStr = [_timerDataArray objectAtIndex:0];
    if (_index < [_timerDataArray count]) {
        tempStr = [_timerDataArray objectAtIndex:_index];
        _index ++;
    }
    else{
        _index = 0;
    }
    [_secondButton setImage:[UIImage imageNamed:tempStr] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isHttpData == NO ) {
        [self httpGetData];
    }
	// Do any additional setup after loading the view.
    
    //设置界面元素的内容
    
//    
//    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
//    }
//    //当数据显示到界面后开始触发
//    _timerDataArray = [[NSArray alloc] initWithObjects:@"Travel_Slider.png",@"Travel_BigViewTips.png",@"Travel_BigViewSlider.png", nil];
    
}
//回到上一层

-(void)viewWillUnload
{
    
    
}
-(void)backHome
{
//    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:STOPTIME object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 回到主页
-(void)backHomeClick:(UIButton * )sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:BACK_HOME object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//通知中心的回调函
-(void)changeLabelCount
{
     NSMutableArray * array1 = [CacheData readCacheMemory:OWNER_IMAGES];
    NSString * countString  = [NSString stringWithFormat:@"%i",[array1 count]];
     [_myCityButton setTitle:countString forState:UIControlStateNormal];
    NSLog(@"收到通知！！！");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
