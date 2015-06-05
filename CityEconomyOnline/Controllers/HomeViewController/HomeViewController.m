 //
//  HomeViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "HomeViewController.h"
#import "SecondaryPageController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "DetailPageCotrollerViewController.h"
#import "FocusDetailViewController.h"
#import "CityHotButton.h"
#import "ArticleRequest.h"
#import "ArticleTitle.h"
#import "CityHot.h"
#import "ArticleListViewController.h"
#import "CommonUtils.h"
#import "CacheData.h"
#import "TipsCityView.h"
#define kButtonBaseBg 100
#define kHomeVideoHeight 180

@interface HomeViewController ()
{
    CGRect _frame;
}

@end

@implementation HomeViewController
@synthesize navString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Custom initialization
       _frame = frame;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPrompt  =  NO ;
    self->isGethttpData  = NO ;
    self.view.frame = _frame;
    /**********添加滚动效果*********/
    self->rollTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(rollNewsImage) userInfo:nil repeats:YES];
    self->pageindex = 0 ;
    /**********添加滚动效果*********/
    NSMutableArray * cacheArray2 = [CacheData readCacheMemory: VIDEO_RECOMMENT];
    
    self->secondArray = [[NSMutableArray alloc]initWithArray:cacheArray2];
    
    self->fourthArray = [[NSMutableArray alloc]init];
    self->imageButtonarray = [[NSMutableArray alloc]init];
    NSMutableArray * cacheArray1 = [CacheData readCacheMemory:CITY_HOTSPOT];
    
    firstArray  = [[NSMutableArray alloc]initWithArray:cacheArray1];   //  第一部分的数据 ；
    
    NSMutableArray * cacheArray3 = [CacheData readCacheMemory:CITY_FOCUS];
    
    self->thirdArray = [[NSMutableArray alloc]initWithArray:cacheArray3];
    
    //初始化界面控件
    [self initializeUI];
    
    [self getData];
//    [self httpGetdata];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view.
    //获取界面数据
    if (self->isGethttpData == NO) {
        [self httpGetdata];
    }
    
}
//初始化界面控件
- (void)initializeUI
{
    /* ==第一部分== */
    _titleLabel1 = [CommonUtils getCustomLabelWithFrame:CGRectMake(62, 10, 62, 18) text:@"城市热点" fontSize:15 textColor:nil];
    [self.view addSubview:_titleLabel1];
    
    _hotScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(128, 9, 785, 200)];
    //幻灯片使用scrollview做的
    _hotScrollView.showsHorizontalScrollIndicator = NO;
    _hotScrollView.pagingEnabled = YES;
    _hotScrollView.contentSize = CGSizeMake(5 * width(_hotScrollView), height(_hotScrollView));
    _hotScrollView.delegate = self;
    [self.view addSubview:_hotScrollView];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX(_hotScrollView), originY(_hotScrollView) + height(_hotScrollView), width(_hotScrollView), 29)];
    _bgImageView.image = [UIImage imageNamed:@"浅灰色的背景图片"];
    _bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImageView];
    
    _imageContentLabel = [CommonUtils getCustomLabelWithFrame:CGRectMake(10, 5, 550, 18) text:@"经济飞速发展，交通问题仍难解决" fontSize:15 textColor:nil];
    [_bgImageView addSubview:_imageContentLabel];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(573, 5, 210, 20)];
    //幻灯片下面的圆点是UIPageControl
    
    if ( systemVersionValue >= 6.0) {
        _pageControl.currentPageIndicatorTintColor = RGBCOLOR(188, 10, 6);//设置圆点的颜色
    }
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_bgImageView addSubview:_pageControl];
    
    //scrollveiw中的内容
    for (int i = 0; i < _pageControl.numberOfPages; i ++) {
        

        CityHotButton * imageButton = [[CityHotButton alloc]initWithFrame:CGRectMake(i * 785,0 , 785, 198)];
        [imageButton setViewController:self];
        [imageButtonarray  addObject:imageButton];
        [_hotScrollView addSubview:imageButton];

  /*************************网络上获取图片**************************/
//        //测试数据,以后通过网络把数据下载，载入
//
    }
    
    //分割线
    _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 248, width(self.view), 1)];
    _seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:_seperatorView];
    
    
    /* ==第二部分== */
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 249, width(self.view), 200)];
    _secondView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_secondView];

    _titleLabel2 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 10, width(_titleLabel1), height(_titleLabel1)) text:@"视频推荐" fontSize:15 textColor:nil];
    [_secondView addSubview:_titleLabel2];
    /*************************视频推荐***********************/
    //方便使用tag赋值
    for (int i = 100; i < 103; i ++) {
        HomeCommonView *videoView = [[HomeCommonView alloc] initWithFrame:CGRectMake(originX(_hotScrollView) + 270* (i - 100), 10, 245, kHomeVideoHeight)];
        [videoView setHomeViewController:self];
        
        videoView.tag = i;
        [_secondView addSubview:videoView];
    }
    //更多
    _videoMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 158, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreVideo)];
    [_secondView addSubview:_videoMoreButton];
    
    /* ==第三部分== */
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 449, width(self.view), 123)];
    _thirdView.backgroundColor = RGBCOLOR(59, 58, 58);
    [self.view addSubview:_thirdView];

    _titleLabel3 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 10, width(_titleLabel1), height(_titleLabel1)) text:@"城市焦点" fontSize:15 textColor:nil];
    [_thirdView addSubview:_titleLabel3];
    //小圆点
    for (int i = 0 ; i < 4; i++) {
        UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX(_hotScrollView), 19 + 25 * i, 8, 8)] ;
        dotImageView.image = [UIImage imageNamed:@"Home_dot.png"];
        [_thirdView addSubview:dotImageView];
    }
    
    //文本内容
    for (int i = 100; i < 104; i ++) {
        UIButton *focusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        focusButton.frame = CGRectMake(originX(_hotScrollView), 12 + 26 * ( i - 100), 800, 18);
        focusButton.titleLabel.font = [UIFont systemFontOfSize:17];
        focusButton.titleEdgeInsets = UIEdgeInsetsMake(0, 17, 0, 270);//w=530,x +=17
        focusButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        focusButton.tag = i;
        [focusButton addTarget:self action:@selector(focusTextClick:) forControlEvents:UIControlEventTouchUpInside];
        [focusButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        UILabel *timeLabel = [CommonUtils getCustomLabelWithFrame:CGRectMake(width(_thirdView) - 90, originY(focusButton), 90, 14) text:@"2013-07-17" fontSize:16 textColor:nil];
        timeLabel.tag = 2 * i;
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [_thirdView addSubview:timeLabel];
        
        [_thirdView addSubview:focusButton];
    }
    //更多
    _focusMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(originX(_videoMoreButton), 74, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreFocusContent)];
    [_thirdView addSubview:_focusMoreButton];
    
    /* ==第四部分== */
    _forthView = [[UIView alloc] initWithFrame:CGRectMake(0, 570, width(self.view), 141)];
    [self.view addSubview:_forthView];
  
    _titleLabel4 = [CommonUtils getCustomLabelWithFrame:CGRectMake(originX(_titleLabel1), 10, width(_titleLabel1), height(_titleLabel1)) text:@"锦囊推荐" fontSize:15 textColor:nil];
    [_forthView addSubview:_titleLabel4];
    
    //使用for循环，方便使用tag赋值
    for (int i = 100; i < 103; i ++) {
        TipsCityView *videoView = [[TipsCityView alloc] initWithFrame:CGRectMake(originX(_hotScrollView) + 270* (i - 100), 10, 245, kHomeTipsHeight)];
        videoView.tag = i;
//        [videoView  setContentWithData:nil];
        
        videoView.homeViewController = self ;
        [_forthView addSubview:videoView];
    }
    
    //更多
    _tipsMoreButton = [CommonUtils getCustomButtonWithFrame:CGRectMake(90, 95, 29, 29) nomalImage:@"MoreBtn.png" hightImage:nil target:self action:@selector(showMoreCityTips)];
    _tipsMoreButton.hidden = YES ;
    [_forthView addSubview:_tipsMoreButton];

}

- (void)getData//这个函数是在界面显示之前，通过网络获取数据
{
    //测试假数据
    _bgImageView.backgroundColor = RGBCOLOR(59, 58, 58);
    // 第一部分 加载本地数据
    for (int i = 0 ; i < [firstArray count]; i ++) {
        CityHotButton * cityHotButton = [imageButtonarray objectAtIndex:i];
        CityHot * cityHot = [firstArray objectAtIndex:i];
        [cityHotButton setCityHot:cityHot];
    }
        // 城市焦点 添加文本
    for (int i = 0; i < [thirdArray count]; i ++) {
        ArticleTitle * myArticleTitle = [thirdArray objectAtIndex:i];
        
        UIButton *button = (UIButton *)[_thirdView viewWithTag:i +100];
        [button setTitle:myArticleTitle.title forState:UIControlStateNormal];
        UILabel  * label = (UILabel *)[_thirdView viewWithTag:(i+100)*2];
        [label setTextAlignment:NSTextAlignmentLeft];
        label.text = myArticleTitle.updatedtime;
        label.font = [UIFont systemFontOfSize:16];
        
    }

    for (int i = 0; i < [secondArray count]; i ++) {
        HomeCommonView *videoView = (HomeCommonView *)[_secondView viewWithTag:i + 100];
        //            [videoView setContentWithData:nil];
        NewesVideo * myNewesVideo = [secondArray objectAtIndex:i ];
        [videoView setNewesVideo:myNewesVideo];
        
    }
    // 锦囊推荐 使用
    NewesVideo * newesView1 = [[NewesVideo alloc]init];
    newesView1.image = [UIImage imageNamed:@"beijing_01.png"];
    newesView1.title = @"文化中心--北京";
    NewesVideo * newesView2 = [[NewesVideo alloc]init];
    newesView2.image = [UIImage imageNamed:@"beijing_02.png"];
    newesView2.title = @"政治中心--北京";
    NewesVideo * newesView3 = [[NewesVideo alloc]init];
    newesView3.image = [UIImage imageNamed:@"beijing_03.png"];
    newesView3.title = @"经济中心--北京";
    [self->fourthArray  addObject:newesView1];
    [self->fourthArray addObject:newesView2];
    [self->fourthArray addObject:newesView3];
    
    for (int i = 0; i < [fourthArray count]; i ++) {
        TipsCityView *videoView = (TipsCityView *)[_forthView viewWithTag:i + 100];
        //            [videoView setContentWithData:nil];
        NewesVideo * myNewesVideo = [fourthArray objectAtIndex:i ];
        [videoView setNewesVideo:myNewesVideo];
        
    }
    // 第三部分
    NSMutableArray * articleArray = [[NSMutableArray alloc]initWithObjects:@"永贵电器234万股解禁 1月2日上市流通 ",@"1985年，年仅32岁的时即官至副厅级，任共青团新疆生产建设兵团委员会副书记。",@"詹姆斯荣获最佳男运动员 篮球界仅三人追平乔丹",@"蒂格34+14双加时压哨绝杀 欧文40+9骑士不敌老鹰", nil];

    for (int i = 0; i < [articleArray count]; i ++) {
        NSString  * myArticleTitle = [articleArray objectAtIndex:i];
        
        UIButton *button = (UIButton *)[_thirdView viewWithTag:i +100];
        [button setTitle:myArticleTitle forState:UIControlStateNormal];
        UILabel  * label = (UILabel *)[_thirdView viewWithTag:(i+100)*2];
        [label setTextAlignment:NSTextAlignmentLeft];
        label.text = @"2013-09-23";
        label.font = [UIFont systemFontOfSize:16];
        
    }

//    [self httpGetdata];
}
-(void)httpGetdata // 从 网络 上 获取 数据
{
 
    // 第二部分 视频推荐
    VideoRequest *  requset = [[VideoRequest alloc]init];// 视频推荐的网络数据
    [requset setCompletionWithType:0 andArray:secondArray andSuccess:^(NSInteger index) {
        for (int i = 0; i < [secondArray count]; i ++) {
            HomeCommonView *videoView = (HomeCommonView *)[_secondView viewWithTag:i  + 100];
//            [videoView setContentWithData:nil];
            NewesVideo * myNewesVideo = [secondArray objectAtIndex:i ];
            [videoView setNewesVideo:myNewesVideo];
            _imageContentLabel.text = myNewesVideo.title ;
            
        }
        self->isGethttpData = YES ;
        [CacheData writeCacheMemory:secondArray andKeyString:VIDEO_RECOMMENT];
        
    } andFailed:^(NSString *errer) {
        if (isPrompt == NO) {
            isPrompt = YES ;
            [self initPrompt];
        }
    }];
    // 第一部分 网络 请求数据
    
    ArticleRequest * articleRquest = [[ArticleRequest alloc]init];
    [articleRquest requestCiytHotTitleWith:firstArray  andSucceed:^{
        
        for (int i = 0 ; i < [firstArray count]; i ++) {
            CityHotButton * cityHotButton = [imageButtonarray objectAtIndex:i];
            CityHot * cityHot = [firstArray objectAtIndex:i];
            [cityHotButton setCityHot:cityHot];
        }
         self->isGethttpData = YES ;
        [CacheData writeCacheMemory: firstArray andKeyString:CITY_HOTSPOT];
    } andFailed:^{
        if (isPrompt == NO) {
            isPrompt = YES ;
            [self initPrompt];
        }
        
    }];
    // 第三部分 网络请求数据
    ArticleRequest * articleListrquest = [[ ArticleRequest alloc]init];
    [articleListrquest requestArticleWithIndex:0 andArray:thirdArray andSucceed:^{
        for (int i = 0; i < [thirdArray count]; i ++) {
            ArticleTitle * myArticleTitle = [thirdArray objectAtIndex:i];
            
            UIButton *button = (UIButton *)[_thirdView viewWithTag:i +100];
            [button setTitle:myArticleTitle.title forState:UIControlStateNormal];
            UILabel  * label = (UILabel *)[_thirdView viewWithTag:(i+100)*2];
            [label setTextAlignment:NSTextAlignmentLeft];
            label.text = myArticleTitle.updatedtime;
            label.font = [UIFont systemFontOfSize:16];
            
        }
         self->isGethttpData = YES ;
        [ CacheData writeCacheMemory:thirdArray andKeyString:CITY_FOCUS];
        
         
    } andFailed:^(NSString *errer) {
        if (isPrompt == NO) {
            isPrompt = YES ;
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
            [self initPrompt];
            
        }
    }];

    
    
}
-(void)initPrompt
{

    
    CommonUtils   * utils = [[CommonUtils alloc]init];
    [utils alertWithMessage:@"网络有点不给力！！" andView:self.view];
    
    
}

#pragma mark - 幻灯片效果
    
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self->pageindex = scrollView.contentOffset.x / width(_hotScrollView);
    
    _pageControl.currentPage = self->pageindex;
}

- (void)pageValueChanged:(UIPageControl *)sender
{
    int index = sender.currentPage;
    _hotScrollView.contentOffset = CGPointMake(width(_hotScrollView) * index, 0);
}
// 滚动幻灯片
-(void)rollNewsImage
{
    if ([firstArray count]== 0) {
        return ;
        
    }
    if (self->pageindex >= [firstArray count]) {
        self->pageindex = 0;
    }
    //  添加滚动效果
    _hotScrollView.contentOffset = CGPointMake(width(_hotScrollView) * pageindex, 0);
    //于分页控制器同步
     _pageControl.currentPage = _hotScrollView.contentOffset.x / width(_hotScrollView);
    
    CityHot * cityHot = [firstArray objectAtIndex:self->pageindex];
    
    
//    NSLog(@"-----%@",cityHot.cityHotTitle);
    _imageContentLabel.text  = cityHot.cityHotTitle ; //[CommonUtils getCustomLabelWithFrame:CGRectMake(10, 5, 550, 18) text:cityHot.cityHotTitle fontSize:15 textColor:nil];
 // 自动滚动效果
    self->pageindex ++ ;
    
}
#pragma mark - 按钮点击事件

- (void)imageButtonClick:(UIButton *)sender
{
//    int tag = sender.tag - kButtonBaseBg;
//    CLog(@"点击%d页",tag);
}

- (void)showMoreVideo
{
    
    if (isGethttpData == NO) {
        [self initPrompt];
        return ;
    }
    SecondaryPageController *sController = [[SecondaryPageController alloc]initWithVideoType:VideoRecommend];
    sController.leftString = @"视频推荐 ";
    sController.navString  = self.navString;
    
//    [self presentModalViewController:sController animated:YES];
    [self presentViewController:sController animated:YES completion:nil];
    
}

- (void)showMoreFocusContent
{
//    SecondaryPageController *sController = [[[SecondaryPageController alloc]init]autorelease];
//    sController.leftString = @"经济新闻";
//    sController.navString  = self.navString;
    if (isGethttpData == NO) {
        [self initPrompt];
        return ;
    }
    ArticleListViewController * myArticleList = [[ArticleListViewController alloc]init];
    
    myArticleList.leftString = @"城市焦点";

    [self presentViewController:myArticleList animated:YES completion:nil];

}

- (void)showMoreCityTips
{


}

- (void)focusTextClick:(UIButton *)sender
{
    int index = sender.tag - 100;
    CLog(@"首页第三部分第%d文本点击事件",index+1);
    
    if ([thirdArray count] > index) {
        ArticleTitle * myArticleTitle = [thirdArray objectAtIndex:index];
        FocusDetailViewController  * focusDetail = [[FocusDetailViewController alloc]initWithDetailID:myArticleTitle.articleId];
        [self presentViewController:focusDetail animated:YES completion:nil];
    }
  
    
}
@end
